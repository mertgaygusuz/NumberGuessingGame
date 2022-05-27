//
//  ViewController.swift
//  Sayı Tahmin Oyunu
//
//  Created by Mert Gaygusuz on 4.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var txtTahminEdilecekSayi: UITextField!
    
    @IBOutlet weak var imgKaydet: UIImageView!
    
    @IBOutlet weak var btnKaydet: UIButton!
    
    @IBOutlet weak var txtTahminSayisi: UITextField!
    
    @IBOutlet weak var imgTahminDurum: UIImageView!
    
    @IBOutlet weak var btnDene: UIButton!
    
    @IBOutlet weak var lblSonuc: UILabel!
    
    @IBOutlet weak var imgYildiz1: UIImageView!
    
    @IBOutlet weak var imgYildiz2: UIImageView!
    
    @IBOutlet weak var imgYildiz3: UIImageView!
    
    @IBOutlet weak var imgYildiz4: UIImageView!
    
    @IBOutlet weak var imgYildiz5: UIImageView!
    
    var yildizlar : [UIImageView] = [UIImageView]()
    let maxDenemeSayisi: Int = 5
    var denemeSayisi: Int = 0
    var hedefSayi : Int = -1
    var oyunBasarili: Bool = false //oyun başarılı şekilde biterse true olacak
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        yildizlar = [imgYildiz1, imgYildiz2, imgYildiz3, imgYildiz4, imgYildiz5]
        
        imgKaydet.isHidden = true
        imgTahminDurum.isHidden = true //ikonu başlangıçta göstermez
        btnDene.isEnabled = false //buton tıklama durumunu pasif yapar
        txtTahminEdilecekSayi.isSecureTextEntry = true //sayıyı şifreli şekilde gösterir
        lblSonuc.text = ""
        
    }
    
    
    @IBAction func btnKaydetClicked(_ sender: UIButton) {
        
        imgKaydet.isHidden = false //butona basılınca ikon gösterilecek
        if let t = Int(txtTahminEdilecekSayi.text!){
            hedefSayi = t
            btnDene.isEnabled = true
            txtTahminEdilecekSayi.isEnabled = false
            btnKaydet.isEnabled = false
            imgKaydet.image = UIImage(named: "onay")
        }
        else{
            imgKaydet.image = UIImage(named: "hata")
        }
    }
    
    @IBAction func btnDeneClicked(_ sender: Any) {
        
        
        if oyunBasarili == true || denemeSayisi > maxDenemeSayisi{
            //oyun bittiyse
            return
        }
        
        imgTahminDurum.isHidden = false
        if let girilenSayi = Int(txtTahminSayisi.text!){
            //kullanıcı düzgün değer girdiyse
            denemeSayisi += 1
            yildizlar[denemeSayisi-1].image = UIImage(named: "beyazYildiz")
            
            if girilenSayi > hedefSayi{
                imgTahminDurum.image = UIImage(named: "asagi")
                txtTahminSayisi.backgroundColor = UIColor.red
                txtTahminSayisi.text = nil
            }
            else if girilenSayi < hedefSayi{
                imgTahminDurum.image = UIImage(named: "yukarı")
                txtTahminSayisi.backgroundColor = UIColor.red
                txtTahminSayisi.text = nil
            }
            else{
                //buraya girerse başarılı şekilde tahmin etmiştir
                imgTahminDurum.image = UIImage(named: "tamam")
                btnKaydet.isEnabled = true
                lblSonuc.text = "Doğru tahmin"
                txtTahminSayisi.backgroundColor = UIColor.green
                txtTahminEdilecekSayi.isSecureTextEntry = false
                oyunBasarili = true
                
                let alertController = UIAlertController(title: "Başarılı", message: "Sayıyı doğru tahmin ettiniz", preferredStyle: UIAlertController.Style.alert)
                
                let okAction = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(okAction)
                
                let playAgainAction = UIAlertAction(title: "Yeniden Oyna", style: UIAlertAction.Style.default){
                    (action: UIAlertAction) in
                    self.txtTahminEdilecekSayi.isEnabled = true
                    self.txtTahminEdilecekSayi.text = nil
                    self.txtTahminEdilecekSayi.isSecureTextEntry = true
                    self.imgKaydet.isHidden = true
                    self.imgTahminDurum.isHidden = true
                    self.txtTahminSayisi.isEnabled = true
                    self.txtTahminSayisi.backgroundColor = UIColor.white
               }
                
                alertController.addAction(playAgainAction)
                alertController.addAction(okAction)
                
                present(alertController, animated: true, completion: nil)
                
                return
            }
        }
        else{
            //kullanıcı yanlış değer girdiyse
            imgTahminDurum.image = UIImage(named: "hata")
        }
        
        if denemeSayisi == maxDenemeSayisi{
            //buraya girerse oyunu başarısız bir şekilde bitirmiştir
            btnDene.isEnabled = false
            imgTahminDurum.image = UIImage(named: "hata")
            lblSonuc.text = "Oyun Başarısız! \nArkadaşın \(hedefSayi) Sayısını girmişti"
            txtTahminEdilecekSayi.isSecureTextEntry = false
            
            let alertController = UIAlertController(title: "Başarısız", message: "\(hedefSayi) Sayısını bilemediniz ve Oyunu kaybettiniz", preferredStyle: UIAlertController.Style.alert)
            
            let Action = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
            alertController.addAction(Action)
            
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
    }
    
}

