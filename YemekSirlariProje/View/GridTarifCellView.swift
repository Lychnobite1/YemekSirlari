//
//  GridTarifCellView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI
import SDWebImageSwiftUI
struct GridTarifCellView: View {
    var tarif : TarifModel
    @State private var begenildiMi = false
    @ObservedObject var ViewModel = TarifKayitBegeniViewModel()
    var body: some View {
        VStack{
            HStack{
                
                if tarif.profilResmi != ""{
                    WebImage(url: URL(string: tarif.profilResmi))
                        .resizable()
                        .clipped()
                        .frame(width: 30,height: 30)
                        .clipShape(Circle())
                }
                else {
                    Image("VarsayilanResim")
                        .resizable()
                        .clipped()
                        .frame(width: 30,height: 30)
                        .clipShape(Circle())
                }
                
                Text(tarif.kullaniciAdi)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    
            }
            .offset(x:-25)
            ZStack{
                WebImage(url: URL(string: tarif.yemekResmi))
                    .resizable()
                    .clipped()
                    .frame(width: (UIScreen.main.bounds.width / 2) - 30,height: 160)
                    .cornerRadius(20)
                ZStack{
                    Circle().fill(.white).frame(width: 27,height: 27)
                    Button{
                        self.begenildiMi.toggle()
                        if self.begenildiMi == true {
                            ViewModel.tarifBegenArttir(docID: tarif.documentID)
                        }
                        else {
                            ViewModel.tarifBegeniAzalt(docID: tarif.documentID)
                        }
                    }label: {
                        Image(systemName: self.begenildiMi ? "heart.fill" : "heart")
                            .foregroundColor(self.begenildiMi ? Color("Yesil2").opacity(0.78) : .black)
                    }
                }.offset(x:56,y:-56)
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .frame(width: nil,height: 30)
                    HStack(spacing: 2){
                        Text("\(tarif.begeniSayisi)")
                            .foregroundColor(.black)
                            .font(.system(size: 14))
                        Image(systemName: "heart.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 13,height: 13)
                            .foregroundColor(Color("Yesil2").opacity(0.78))
                    }.padding(.horizontal,5)
                        
                }
                .fixedSize(horizontal: true, vertical: false)
                .offset(x:56,y: 50)
            }
            Text(tarif.yemekAdi)
                .frame(width: (UIScreen.main.bounds.width / 2) - 30)
                .lineLimit(3)
                .foregroundColor(.black)
            
        }
        .onAppear{
            ViewModel.verininBegeniBilgisi(docID: tarif.documentID)
        }
    }
}

struct GridTarifCellView_Previews: PreviewProvider {
    static var previews: some View {
        GridTarifCellView(tarif: TarifModel(documentID: "asdna", kullaniciID: "asdnaskdnas", kullaniciAdi: "Murat Başer", hesapAdi: "asdasdas", begeniSayisi: 0, profilResmi: "VarsayilanResim", yemekAdi: "Gömme Kuzu pirzola", yemekResmi: "VarsayilanResim", yapilis: "asdjnlkasjdsdklfjdklsjfsldkjfklsdjfklsdjfklsdjfklsdjfk", malzemeler: ["2 Adet Yumurta","5 su bardağı süt","1 adet sarımsak"]))
    }
}
