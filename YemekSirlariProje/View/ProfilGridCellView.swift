//
//  ProfilGridCellView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 5.01.2024.
//

import SwiftUI
import SDWebImageSwiftUI
struct ProfilGridCellView: View {
    var tarif : TarifModel
    var body: some View {
        VStack{
            ZStack{
                WebImage(url: URL(string: tarif.yemekResmi))
                    .resizable()
                    .clipped()
                    .frame(width: (UIScreen.main.bounds.width / 2) - 40,height: 150)
                    .cornerRadius(20)
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .frame(width: nil,height: 30)
                    HStack(spacing: 2){
                        Text("\(tarif.begeniSayisi)")
                            .foregroundColor(.black)
                        Image(systemName: "heart.fill")
                            .foregroundColor(Color("Yesil2").opacity(0.78))
                    }.padding(.horizontal,5)
                }.offset(x:45,y: -50)
                    .fixedSize(horizontal: true, vertical: false)
                    
            }
            Text(tarif.yemekAdi)
                .font(.system(size: 15))
                .fontWeight(.bold)
                .foregroundColor(.black.opacity(0.7))
                .frame(width: (UIScreen.main.bounds.width / 2) - 30)
                .lineLimit(3)
            
            
        }
    }
}

struct ProfilGridCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilGridCellView(tarif: TarifModel(documentID: "asdna", kullaniciID: "asdnaskdnas", kullaniciAdi: "Murat Başer", hesapAdi: "asdfsfds", begeniSayisi: 0, profilResmi: "VarsayilanResim", yemekAdi: "Gömme Kuzu pirzola", yemekResmi: "VarsayilanResim", yapilis: "asdjnlkasjdsdklfjdklsjfsldkjfklsdjfklsdjfklsdjfklsdjfk", malzemeler: ["2 Adet Yumurta","5 su bardağı süt","1 adet sarımsak"]))
    }
}
