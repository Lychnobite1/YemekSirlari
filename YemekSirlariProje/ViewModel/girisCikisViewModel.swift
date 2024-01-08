//
//  girisCikisViewModel.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI
import FirebaseAuth
import Firebase

class GirisCikisViewModel : ObservableObject {
    @Published var girisYapildiMi = false
    @Published var cikisYapildiMi = false
    @Published var kayitYapildiMi = false
    
    func girisYap(email : String, sifre : String) {
        self.girisYapildiMi = true
        Auth.auth().signIn(withEmail: email, password: sifre) { (result, error) in
            if error != nil {
                print("error")
            }
            else {
                print("Giriş Yapıldı")
                self.girisYapildiMi = false
            }
        }
    }
    func kayitOl(email:String,sifre:String,kullaniciAdi : String, profilResim: String,hesapAdi : String) {
        self.kayitYapildiMi = true
        Auth.auth().createUser(withEmail: email, password: sifre) { (result, error) in
            if error != nil {
                print("kayıt başarısız")
            }
            else {
                print("kayıt başarılı")
                let firestoreDatabase = Firestore.firestore()
                var ef : DocumentReference?
                var veriler : [String : Any] = [
                    "kullaniciID":result!.user.uid,
                    "email":email,
                    "kullaniciAdi":kullaniciAdi,
                    "hesapAdi":hesapAdi,
                    "profilResmi":profilResim
                ]
                firestoreDatabase.collection("Hesaplar").addDocument(data: veriler) { (error) in
                    if error != nil {
                        print("hesap bilgileri hatası")
                    }
                    else {
                        print("hesap bilgileri kaydedildi.")
                        self.kayitYapildiMi = false
                    }
                }
            }
        }
    }
    func cikis(){
        do {
            try Auth.auth().signOut()
            self.cikisYapildiMi = true
        }
        catch{
            print("çıkış yapılmadı.")
        }
    }
}
