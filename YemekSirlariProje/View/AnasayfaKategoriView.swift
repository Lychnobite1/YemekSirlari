//
//  AnasayfaKategoriView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 5.01.2024.
//

import SwiftUI

struct AnasayfaKategoriView: View {
    var body: some View {
        LazyHGrid(rows: [GridItem(.flexible()),GridItem(.flexible())]){
            ForEach(anasayfaKategoriListesi,id: \.id){i in
                AnasayfaKategoriCellView(kategori: i)
                    .padding(.horizontal,5)
            }
        }
        .frame(height: 130)
    }
}

struct AnasayfaKategoriView_Previews: PreviewProvider {
    static var previews: some View {
        AnasayfaKategoriView()
    }
}
