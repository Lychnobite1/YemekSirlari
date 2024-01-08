//
//  tariflerViewModel.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI
import Firebase
import FirebaseStorage

class TarifViewModel : ObservableObject {
    @Published var tarifListesi = [TarifModel]()
    @Published var tarifPaylasildiMi = false
    func tarifEkle(resim:UIImage,yemekadi: String,malzemeler : [String],yapilis:String,profilResim:String,kullaniciAdi:String,hesapAd:String){
        self.tarifPaylasildiMi = true
        let firebaseStorage = Storage.storage()
        let storageRef = firebaseStorage.reference()
        let mediaFolder = storageRef.child("TarifResimleri")
        if let data = resim.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            let resimRef = mediaFolder.child("\(uuid).jpeg")
            resimRef.putData(data,metadata: nil) { (metadata, error) in
                if error != nil {
                    print("put data error")
                }
                else {
                    resimRef.downloadURL { (url, error) in
                        if error != nil{
                            print("downloadURL error")
                        }
                        else {
                            let resimURL = url?.absoluteString
                            // kaydetme
                            let database = Firestore.firestore()
                            var ref : DocumentReference?
                            let veriler : [String : Any] = [
                                "kullaniciID":Auth.auth().currentUser!.uid,
                                "profilResim":profilResim,
                                "kullaniciAdi":kullaniciAdi,
                                "hesapAdi": hesapAd,
                                "email":Auth.auth().currentUser!.email,
                                "tarifResmi":resimURL,
                                "yemekAdi":yemekadi,
                                "yapilis":yapilis,
                                "malzemeler":malzemeler,
                                "begeniSayisi":0,
                                "tarih":FieldValue.serverTimestamp()
                            ]
                            ref = database.collection("Tarifler").addDocument(data: veriler,completion: { (error) in
                                if error != nil {
                                    print("addDocument error")
                                }
                                else {
                                    print("veriler kaydedildi")
                                    self.tarifPaylasildiMi = false
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    
    func tarifleriGetir(){
        let db = Firestore.firestore()
        db.collection("Tarifler").order(by: "tarih",descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print("hata")
            }
            else {
                if snapshot != nil {
                    self.tarifListesi.removeAll(keepingCapacity: false)
                    for i in snapshot!.documents {
                        let documentid = i.documentID
                        if let begeni = i.get("begeniSayisi") as? Int {
                            if let hesapadi = i.get("hesapAdi") as? String {
                                if let kullaniciad = i.get("kullaniciAdi") as? String {
                                    if let malzemeler = i.get("malzemeler") as? [String] {
                                        if let profilresim = i.get("profilResim") as? String {
                                            if let tarifresmi = i.get("tarifResmi") as? String {
                                                if let yapilis = i.get("yapilis") as? String {
                                                    if let yemekadi = i.get("yemekAdi") as? String {
                                                        self.tarifListesi.append(TarifModel(documentID: documentid, kullaniciID: Auth.auth().currentUser!.uid, kullaniciAdi: kullaniciad, hesapAdi: hesapadi, begeniSayisi: begeni, profilResmi: profilresim, yemekAdi: yemekadi, yemekResmi:tarifresmi, yapilis: yapilis, malzemeler: malzemeler))
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
        }
    }
    func tarifSil(docID:String){
        let db = Firestore.firestore()
        db.collection("Tarifler").document(docID).delete { (error) in
            if error != nil {
                print("error!!")
            }
            else {
                print("tarif silindi.")
                self.tarifleriGetir()
            }
        }
    }
    func tarifKullaniciBilgileriGuncelle(yeniHesapAdi:String,yeniKullaniciAdi:String){
        let db = Firestore.firestore()
        db.collection("Tarifler").whereField("kullaniciID", isEqualTo: Auth.auth().currentUser!.uid).getDocuments { (snapshot, error) in
            if error != nil {
                print("hata")
            }
            else {
                guard let documens = snapshot?.documents else {
                    print("belge bulunamadı..")
                    return
                }
                for i in documens {
                    let docID = i.documentID
                    var updateData : [String : Any] = [:]
                    updateData["hesapAdi"] = yeniHesapAdi
                    updateData["kullaniciAdi"] = yeniKullaniciAdi
                    
                    db.collection("Tarifler").document(docID).updateData(updateData) { (error) in
                        if error != nil {
                            print("güncellenemedi")
                        }
                        else {
                            print("bilgiler güncellendi")
                        }
                    }
                }
            }
        }
    }
    func tarifProfilResmiGuncelle(yeniResim : UIImage){
        let firebaseStorage = Storage.storage()
        let storageRef = firebaseStorage.reference()
        let mediaFolder = storageRef.child("TarifResimleri")
        if let data = yeniResim.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageRef = mediaFolder.child("\(uuid).jpeg")
            imageRef.putData(data,metadata: nil) { (metadata, error) in
                if error != nil {
                    print("putData hatası")
                }
                else {
                    imageRef.downloadURL { (url, error) in
                        if error != nil {
                            print("download hatası")
                        }
                        else {
                            let resimUrl = url?.absoluteString
                            // güncelleme
                            let db = Firestore.firestore()
                            db.collection("Tarifler").whereField("kullaniciID", isEqualTo: Auth.auth().currentUser!.uid).getDocuments { (snapshot, error) in
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
                                        var updateImage : [String : Any] = [:]
                                        updateImage["profilResim"] = resimUrl
                                        
                                        db.collection("Tarifler").document(docID).updateData(updateImage) { (error) in
                                            if error != nil {
                                                print("tarifdeki profil resim güncellenemedi")
                                            }
                                            else {
                                                print("tarifdeki profil resim güncellendi")
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
    
}
