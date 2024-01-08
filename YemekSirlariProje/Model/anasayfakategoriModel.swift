//
//  anasayfakategoriModel.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI

struct AnasayfaKategori : Identifiable {
    var id : Int
    var kategori : String
}

let anasayfaKategoriListesi : [AnasayfaKategori] = [
    AnasayfaKategori(id: 1, kategori: "En Çok Beğenilen"),
    AnasayfaKategori(id: 2, kategori: "En Çok Yorum Yapılan"),
    AnasayfaKategori(id: 3, kategori: "Yeni Eklenenler"),
    AnasayfaKategori(id: 4, kategori: "Pratik Tarifler")
]
