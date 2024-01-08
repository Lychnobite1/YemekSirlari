//
//  KategoriCellView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI

struct KategoriCellView: View {
    var kategori : Kategori
    @State private var tiklandiMi = false
    var body: some View {
        /*
            Button{
                self.tiklandiMi.toggle()
            }label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(self.tiklandiMi ?  Color("Yesil5") : .white)
                        .frame(width: nil,height: 50)
                        .shadow(color: Color.black.opacity(0.3), radius: 0.5,x:2,y:2)
                        .padding(.vertical,5)
                    Text(kategori.kategori_ad)
                        .foregroundColor(self.tiklandiMi ? .white : Color("Yesil5").opacity(0.7))
                        .lineLimit(1)
                        .padding(.horizontal,5)
                        .fontWeight(.semibold)
                        .font(.system(size: 15))
                        
                }
                
            }
         */
        Button{
            self.tiklandiMi.toggle()
        }label: {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(self.tiklandiMi ?  Color("Yesil5") : .white)
                    .frame(width: nil,height: 50)
                    .padding(.vertical,5)
                Text(kategori.kategori_ad)
                    .foregroundColor(self.tiklandiMi ? .white : Color("Yesil5").opacity(0.9))
                    .lineLimit(1)
                    .padding(.horizontal,5)
                    .fontWeight(.semibold)
                    .font(.system(size: 15))
                    
            }
            
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray.opacity(0.4))
                    .frame(width: nil,height: 50)
            )
            
        }
    }
}

struct KategoriCellView_Previews: PreviewProvider {
    static var previews: some View {
        KategoriCellView(kategori: kategoriListesi[0])
    }
}
