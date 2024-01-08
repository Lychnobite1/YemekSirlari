//
//  profilsayfasiViewModel.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI
import Firebase
import FirebaseStorage

class ProfilIslemleriViewModel : ObservableObject {
    @Published var profilResmi = ""
    @Published var kullaniciAdi = ""
    @Published var hesapAdi = ""
    
    @Published var kullaniciTarifToplami = 0
    @Published var kullaniciTarifleri = [TarifModel]()
    
    func profilBilgileriniGetir() {
        let db = Firestore.firestore()
        db.collection("Hesaplar").whereField("kullaniciID", isEqualTo: Auth.auth().currentUser?.uid).getDocuments { (snapshot, error) in
            if error != nil {
                print("profil bilgileri getirilemedi")
            }
            else {
                if let document = snapshot?.documents.first ,
                    let ka = document.data()["kullaniciAdi"] as? String,
                    let ha = document.data()["hesapAdi"] as? String,
                    let pr = document.data()["profilResmi"] as? String {
                    self.profilResmi = pr
                    self.kullaniciAdi = ka
                    self.hesapAdi = ha
                }
                print("prpfil bilgiler getirildi.")
            }
        }
    }
    func kullaniciTarifleriniGetir(){
        let db = Firestore.firestore()
        db.collection("Tarifler").whereField("kullaniciID", isEqualTo: Auth.auth().currentUser!.uid).getDocuments { (snapshot, error) in
            if error != nil {
                print("kullanıcıya ait veriler getirilemedi")
            }
            else {
                for i in snapshot!.documents {
                    let docID = i.documentID
                    let data = i.data()
                    var kullaniciID = data["kullaniciID"] as? String
                    var kullaniciAdi = data["kullaniciAdi"] as? String
                    var hesapAdi = data["hesapAdi"] as? String
                    var profilResim = data["profilResim"] as? String
                    var tarifResim = data["tarifResmi"] as? String
                    var yemekAdi = data["yemekAdi"] as? String
                    var yapilis = data["yapilis"] as? String
                    var malzemeler = data["malzemeler"] as? [String]
                    var begeniSayisi = data["begeniSayisi"] as? Int
                    self.kullaniciTarifleri.append(TarifModel(documentID: docID, kullaniciID: kullaniciID!, kullaniciAdi: kullaniciAdi!, hesapAdi: hesapAdi!, begeniSayisi: begeniSayisi!, profilResmi: profilResim!, yemekAdi: yemekAdi!, yemekResmi: tarifResim!, yapilis: yapilis!, malzemeler: malzemeler!))
                    
                }
            }
        }
    }
    func kullaniciTarifSayisi(){
        let db = Firestore.firestore()
        db.collection("Tarifler").whereField("kullaniciID", isEqualTo: Auth.auth().currentUser!.uid).getDocuments { (snapshot, error) in
            if error != nil {
                print("kullanıcı toplam tarif sayısı getirilemedi")
            }
            else {
                self.kullaniciTarifToplami = snapshot?.documents.count ?? 0
            }
        }
    }
    func profilResimGuncelle(yeniResim:UIImage){
        let firebaseStoage = Storage.storage()
        let storageRef = firebaseStoage.reference()
        let mediaFolder = storageRef.child("ProfilResimleri")
        if let data = yeniResim.jpegData(compressionQuality : 0.5) {
           let uuid = UUID().uuidString
           let imageRef = mediaFolder.child("\(uuid).jpeg")
           imageRef.putData(data,metadata:nil) { (metadata,error) in
               if error != nil {
                   print("putData hatası")
               }
               else {
                   imageRef.downloadURL { (url, error) in
                       if error != nil {
                           print("downloadUrl hatası")
                       }
                       else {
                           let resimUrl = url?.absoluteString
                           // GÜNCELLEME
                           let db = Firestore.firestore()
                           db.collection("Tarifler").whereField("kullaniciID", isEqualTo : Auth.auth().currentUser!.uid).getDocuments { (snapshot,error) in
                               if error != nil {
                                   print("hata")
                               }
                               else {
                                   guard let documents = snapshot?.documents else {
                                       print("belge bulunamadı")
                                       return
                                   }
                                   for i in documents {
                                       let docID = i.documentID
                                       var updateProfil : [String : Any] = [:]
                                       updateProfil["profilResmi"] = resimUrl
                                       db.collection("Tarifler").document(docID).updateData(updateProfil) { (error) in
                                           if error != nil {
                                               print("güncellenemedi")
                                           }
                                           else {
                                               print("tüm tariflerden resim güncellendi")
                                           }
                                       }
                                   }
                               }
                           }
                       }
                   }
                   
               }
           }
        }
    }
    func hesapProfilResmiGuncelle(yeniResim:UIImage){
        let firebaseStoage = Storage.storage()
        let storageRef = firebaseStoage.reference()
        let mediaFolder = storageRef.child("ProfilResimleri")
        if let data = yeniResim.jpegData(compressionQuality : 0.5) {
           let uuid = UUID().uuidString
           let imageRef = mediaFolder.child("\(uuid).jpeg")
           imageRef.putData(data,metadata:nil) { (metadata,error) in
               if error != nil {
                   print("putData hatası")
               }
               else {
                   imageRef.downloadURL { (url, error) in
                       if error != nil {
                           print("downloadUrl hatası")
                       }
                       else {
                           let resimUrl = url?.absoluteString
                           // GÜNCELLEME
                           let db = Firestore.firestore()
                           db.collection("Hesaplar").whereField("kullaniciID", isEqualTo : Auth.auth().currentUser!.uid).getDocuments { (snapshot,error) in
                               if error != nil {
                                   print("hata")
                               }
                               else {
                                   guard let documents = snapshot?.documents, let document = documents.first else {
                                       print("belge bulunamadı")
                                       return
                                   }
                                   db.collection("Hesaplar").document(document.documentID).updateData(["profilResmi":resimUrl]) { (error) in
                                       if error != nil {
                                           print("error")
                                       }
                                       else{
                                           print("hesaplardan resim güncellendi.")
                                       }
                                   }
                               }
                           }
                       }
                   }
                   
               }
           }
        }
    }
    func hesapBilgileriniGuncelle(yeniKullaniciAdi:String,yeniHesapAdi:String){
        let db = Firestore.firestore()
        db.collection("Hesaplar").whereField("kullaniciID", isEqualTo: Auth.auth().currentUser!.uid).getDocuments { (snapshot, error) in
            if error != nil {
                print("hata")
            }
            else {
                guard let documents = snapshot?.documents, let document = documents.first else {
                    print("belge bulunamadı")
                    return
                }
                db.collection("Hesaplar").document(document.documentID).updateData(["kullaniciAdi":yeniKullaniciAdi,"hesapAdi":yeniHesapAdi]) { (error) in
                    if error != nil {
                        print("güncellenemedi")
                    }
                    else {
                        print("profil resmi güncellendi")
                       
                    }
                    
                }
            }
        }
    }
}
