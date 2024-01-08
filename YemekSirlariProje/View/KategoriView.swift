//
//  KategoriView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI

struct KategoriView: View {
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            LazyHGrid(rows: [GridItem(.flexible()),GridItem(.flexible())]){
                ForEach(kategoriListesi,id: \.id){i in
                    KategoriCellView(kategori: i)
                        .padding(.horizontal,5)
                }
                
            }
        }
        .frame(height: 130)
    }
}

struct KategoriView_Previews: PreviewProvider {
    static var previews: some View {
        KategoriView()
    }
}
