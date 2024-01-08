//
//  ProfilListCellView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 5.01.2024.
//

import SwiftUI
import SDWebImageSwiftUI
struct ProfilListCellView: View {
    var tarif : TarifModel
    var body: some View {
        HStack{
            WebImage(url: URL(string: tarif.yemekResmi))
                .resizable()
                .clipped()
                .frame(width: 70,height: 70)
                .cornerRadius(20)
            VStack(alignment: .leading,spacing: 8){
                Text(tarif.yemekAdi)
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundColor(.black.opacity(0.7))
                    .lineLimit(1)
                HStack{
                    Text("\(tarif.begeniSayisi)")
                        .foregroundColor(.black)
                    Image(systemName: "heart.fill")
                        .foregroundColor(Color("Yesil2").opacity(0.78))
                    Spacer()
                }
                .offset(x:3)
            }
            
            
        }.padding(.horizontal)
    }
}

struct ProfilListCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilListCellView(tarif: TarifModel(documentID: "ksdfjklsdfkm", kullaniciID: "sdfmkslfdmkf", kullaniciAdi: "lskdfjklsd", hesapAdi: "asdfsfsdfsdf", begeniSayisi: 0, profilResmi: "VarsayilanResim", yemekAdi: "alsdhfjklsf", yemekResmi: "VarsayilanResim", yapilis: "jsadfnsdjfsdkfjskdlfmsşldsdfsdfsdf", malzemeler: ["","",""]))
    }
}
