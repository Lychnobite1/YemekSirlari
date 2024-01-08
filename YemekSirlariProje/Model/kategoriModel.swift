//
//  kategoriModel.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI

struct Kategori : Identifiable {
    var id : Int
    var kategori_ad : String
}

let kategoriListesi : [Kategori] = [
    Kategori(id: 1, kategori_ad: "Hamur"),
    Kategori(id: 2, kategori_ad: "Etli"),
    Kategori(id: 3, kategori_ad: "Sebze"),
    Kategori(id: 4, kategori_ad: "Sokak Lezzetleri"),
    Kategori(id: 5, kategori_ad: "Mangal"),
    Kategori(id: 6, kategori_ad: "Haşlama"),
    Kategori(id: 7, kategori_ad: "Salata"),
    Kategori(id: 8, kategori_ad: "Balık"),
    Kategori(id: 9, kategori_ad: "Soslar")
    
]
