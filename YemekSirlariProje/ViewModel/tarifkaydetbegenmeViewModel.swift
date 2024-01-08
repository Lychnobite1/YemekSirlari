//
//  tarifkaydetbegenmeViewModel.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 6.01.2024.
//

import SwiftUI
import Firebase
import FirebaseStorage


class TarifKayitBegeniViewModel : ObservableObject {
    @Published var begeniSayisi = 0
    
    
    
    func verininBegeniBilgisi(docID:String){
        let db = Firestore.firestore()
        let belge = db.collection("Tarifler").document(docID)
        
        belge.getDocument { (snapshot, error) in
            if error != nil {
                print("error")
            }
            else {
                if let snapshot = snapshot, snapshot.exists {
                    if let begeniSayi = snapshot.data()?["begeniSayisi"] {
                        self.begeniSayisi = begeniSayi as! Int
                        print("bu verinin begeniSayisi : \(begeniSayi)")
                    }
                    else {
                        print("begeniSayisi alanı bulunamadı.")
                    }
                }
                else {
                    print("belge bulunamadı.")
                }
            }
        }
    }
    func tarifBegenArttir(docID:String) {
        
        let db = Firestore.firestore()
        let belge = db.collection("Tarifler").document(docID)
        belge.updateData(["begeniSayisi" : self.begeniSayisi + 1]) { (error) in
            if error != nil {
                print("beğeni sayısı 1 arttırılamadı..")
            }
            else {
                print("begeni sayisi 1 arttırıldı..")
                self.verininBegeniBilgisi(docID: docID)
            }
        }
        
    }
    func tarifBegeniAzalt(docID:String) {
        let db = Firestore.firestore()
        let belge = db.collection("Tarifler").document(docID)
        belge.updateData(["begeniSayisi" : self.begeniSayisi - 1]) { (error) in
            if error != nil {
                print("begeni sayisi arttirilamadı")
            }
            else {
                print("begeni sayısı arttırıldı.")
                self.verininBegeniBilgisi(docID: docID)
            }
        }
    }
}

