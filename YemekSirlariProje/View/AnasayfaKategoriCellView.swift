//
//  AnasayfaKategoriCellView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 5.01.2024.
//

import SwiftUI

struct AnasayfaKategoriCellView: View {
    var kategori : AnasayfaKategori
    var body: some View {
        Button{
            
        }label: {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(width: nil,height: 43)
                    .shadow(color: Color("Yesil5").opacity(0.3), radius: 2,x: 2,y: 2)
                Text(kategori.kategori)
                    .font(.system(size: 17))
                    .padding(.horizontal)
            }
            
        }
    }
}

struct AnasayfaKategoriCellView_Previews: PreviewProvider {
    static var previews: some View {
        AnasayfaKategoriCellView(kategori: anasayfaKategoriListesi[0])
    }
}
