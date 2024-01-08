//
//  TarifDetayView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI
import SDWebImageSwiftUI
struct TarifDetayView: View {
    @Environment(\.presentationMode) var pm
    @State private var favorilereEkle = false
    @ObservedObject var ViewModel = ProfilIslemleriViewModel()
    var tarif : TarifModel
    @ObservedObject var begeniViewModel = TarifKayitBegeniViewModel()
    var body: some View {
        NavigationStack{
            ScrollView(.vertical,showsIndicators: false){
                ZStack{
                    WebImage(url: URL(string: tarif.yemekResmi))
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width,height: 350)
                        .clipped()
                        
                    HStack{
                        ZStack{
                            Circle().fill(.white).frame(width: 35,height: 35)
                            Button{
                                self.pm.wrappedValue.dismiss()
                            }label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 23))
                                    .foregroundColor(.black.opacity(0.6))
                            }
                        }
                        Spacer()
                        ZStack{
                            Circle().fill(.white).frame(width: 35,height: 35)
                            Button{
                                self.favorilereEkle.toggle()
                            }label: {
                                Image(systemName:self.favorilereEkle ? "bookmark.fill" : "bookmark")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(self.favorilereEkle ? Color("Yesil5") : .black)
                                    .frame(width: 20,height: 20)
                                    
                            }
                        }.offset(x:-10)
                    }
                    .padding(.horizontal)
                    .offset(x:10,y:-90)
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                            .frame(width: nil,height: 30)
                        HStack(spacing: 2){
                            Text("\(tarif.begeniSayisi)")
                            Image(systemName: "heart.fill")
                                .foregroundColor(Color("Yesil2").opacity(0.78)) 
                        }.padding(.horizontal,5)
                    }.offset(x:160,y: 140)
                        .fixedSize(horizontal: true, vertical: false)
                }
                .offset(y:-60)
                HStack{
                    if ViewModel.profilResmi != "" {
                        WebImage(url: URL(string: ViewModel.profilResmi))
                            .resizable()
                            .frame(width: 60,height: 60)
                            .clipShape(Circle())
                            .clipped()
                    }
                    else {
                        Image("VarsayilanResim")
                            .resizable()
                            .frame(width: 60,height: 60)
                            .clipShape(Circle())
                            .clipped()
                    }
                    
                    Text(tarif.kullaniciAdi)
                        .foregroundColor(.black.opacity(0.7))
                        .fontWeight(.semibold)
                    Spacer()
                    HStack{
                        Circle().fill(.black.opacity(0.7)).frame(width: 9,height: 9)
                        Text("\(ViewModel.kullaniciTarifToplami) Tarif")
                            .foregroundColor(.black.opacity(0.6))
                            .fontWeight(.semibold)
                    }
                }
                .padding(.horizontal)
                .offset(y:-55)
                
                HStack{
                    Text(tarif.yemekAdi)
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(.black.opacity(0.7))
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                .offset(y:-55)
                HStack(spacing: 20){
                    Divider().frame(width: 110,height: 2)
                        .background(Color.black.opacity(0.3))
                    Text("Malzemeler")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.black.opacity(0.6))
                    Divider().frame(width: 110,height: 2)
                        .background(Color.black.opacity(0.3))
                }
                .padding(.top)
                .offset(y:-50)
                GroupBox{
                    DisclosureGroup {
                        ForEach(tarif.malzemeler,id: \.self){i in
                           Divider()
                           HStack{
                               Text(i)
                               Spacer()
                               
                           }
                       }
                    }label: {
                        HStack{
                            Text(tarif.yemekAdi)
                                .foregroundColor(Color("Yesil5"))
                            Spacer()
                        }
                    }
                }.accentColor(Color("Yesil5"))
                 .padding(.horizontal)
                 .offset(y:-50)
                 /*
                
                VStack(alignment: .leading,spacing: 5){
                    ForEach(tarif.malzemeler,id: \.self){i in
                        HStack{
                            Text(i)
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                                .foregroundColor(.black.opacity(0.7))
                            Spacer()
                        }.padding(.horizontal)
                    }
                }
                .padding(.top)
                .offset(y:-50)
                  */
                HStack(spacing: 20){
                    Divider().frame(width: 110,height: 2)
                        .background(Color.black.opacity(0.3))
                    Text("Hazırlanış")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.black.opacity(0.6))
                    Divider().frame(width: 110,height: 2)
                        .background(Color.black.opacity(0.3))
                }
                .padding(.top,20)
                .offset(y:-50)
                Text(tarif.yapilis)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(.black.opacity(0.7))
                    .padding(.horizontal)
                    .padding(.top,5)
                    .offset(y:-50)
                
            }
            .onAppear{
                ViewModel.kullaniciTarifSayisi()
                ViewModel.profilBilgileriniGetir()
                begeniViewModel.verininBegeniBilgisi(docID: tarif.documentID)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct TarifDetayView_Previews: PreviewProvider {
    static var previews: some View {
        TarifDetayView(tarif: TarifModel(documentID: "alkdhsnkls", kullaniciID: "slıkdfjnksl", kullaniciAdi: "Murat Başer", hesapAdi: "muratbaser1", begeniSayisi: 10, profilResmi: "VarsayilanResim", yemekAdi: "Mercimek Çorbası", yemekResmi: "VarsayilanResim", yapilis: "slkdfmklsdmfkşlsdmfkşsdmjfsdmnfksdjmfklsdnmklfmskldfmklsdmfklsdmfklsdmfksdmlkfmslkdfmklsdmfklsdmfklsdmlfkmsdlkfmslkdfmklsdmfklsdmlfksdmlfksdmlkfmslkdfmklsdmfklsdmfklsdmlfkdsmfklsdmlkfmslkdfmklsdfmkldsmfklsdmfklsdmlfksdmlkfmslkdfmklsdmfklsdmfklsdmfkldsm", malzemeler: ["slkdfnksdnfk","sadşfjsıefmklsd","şoasdjfkdsşlfms","skldjfklsdjfklsd","sdşklfmsldş","şsdjklşfsdf","opsdwjfosdş"]))
    }
    
}
