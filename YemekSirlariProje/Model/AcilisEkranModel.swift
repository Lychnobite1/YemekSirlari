//
//  AcilisEkranModel.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI

struct AcilisEkrani : Identifiable {
    var id : Int
    var baslik : String
    var aciklama : String
    var resim : String
}

var acilisEkraniVerileri : [AcilisEkrani] = [
    AcilisEkrani(id: 1, baslik: "Yemek Sırlarına Hoşgeldiniz", aciklama: "En sevdiğin yemek tarifini bizimle paylaş ve diğer lezzet tutkunlarıyla buluştur. Mutfağında gizlediğin o özel dokunuşu paylaş, çünkü lezzet paylaşıldıkça güzelleşir!", resim: "cooking1"),
    AcilisEkrani(id: 2, baslik: "Lezzetin Sırları", aciklama: "Denediğin yeni tarifleri, kendi yorumlarını ve önerilerini paylaşarak diğer şefleri etkile. Yaratıcılığını konuştur, mutfakta birlikte büyüleyici bir yolculuğa çıkalım.", resim: "cooking2")
]
