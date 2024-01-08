//
//  TarifEkleView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI

struct TarifEkleView: View {
    @State private var malzemeler : [String] = [""]
    @State private var yemekadi = ""
    @State private var yapilis = ""
    @State private var secilenResim : UIImage?
    @State private var resimSecildiMi = false
    @ObservedObject var ViewModel = TarifViewModel()
    @ObservedObject var profilIslemleriViewModel = ProfilIslemleriViewModel()
    @State private var hesapAdi = ""
    @State private var kullaniciAdi = ""
    @State private var profilResmi = ""
    @Environment(\.presentationMode) var pm
    func satirSil(at offsets : IndexSet) {
        self.malzemeler.remove(atOffsets: offsets)
    }
    
    var body: some View {
        /*NavigationStack{
         VStack{
         List{
         ForEach(malzemeler.indices,id: \.self){i in
         TextField("Malzeme giriniz..", text: self.binding(forIndex: i))
         }
         }
         }
         .toolbar{
         ToolbarItem(placement: .navigationBarTrailing){
         Button{
         self.malzemeler.append("")
         }label: {
         Text("Ekle")
         }
         }
         }
         .toolbar{
         ToolbarItem(placement: .navigationBarLeading){
         Button{
         for i in malzemeler {
         print("\(index)-) \(i)")
         self.index += 1
         }
         }label: {
         Text("Kaydet")
         }
         }
         }
         }*/
        NavigationStack{
            ScrollView(.vertical,showsIndicators: false){
                ZStack{
                    VStack{
                        
                        HStack(spacing: 30){
                            if self.secilenResim != nil {
                                Image(uiImage: secilenResim!)
                                    .resizable()
                                    .clipped()
                                    .frame(width: 110,height: 110)
                                    .cornerRadius(10)
                            }
                            else {
                                Image("VarsayilanResim")
                                    .resizable()
                                    .scaledToFit()
                                    .clipped()
                                    .frame(width: 110,height: 110)
                                    .cornerRadius(10)
                            }
                            
                            Button{
                                // MARK: Resim Seç
                                self.resimSecildiMi = true
                            }label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black.opacity(0.3))
                                        .frame(width: 135,height: 40)
                                    Text("Resim Ekle")
                                        .foregroundColor(.black)
                                }
                            }
                            .sheet(isPresented: $resimSecildiMi){
                                ResimSec(secilenResim: $secilenResim, resimSecildiMi: $resimSecildiMi)
                            }
                            Spacer()
                        }
                        .padding(.leading)
                        .padding(.top,30)
                        VStack(spacing: 10){
                            HStack{
                                Text("Yemek Adı")
                                    .foregroundColor(.black.opacity(0.6))
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            TextField("Pizza vb.", text: $yemekadi)
                                .frame(height: 40)
                                .padding(.horizontal)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black.opacity(0.3))
                                )
                        }
                        .padding(.horizontal)
                        .padding(.top,20)
                        
                        VStack{
                            HStack{
                                Text("Malzemeler")
                                    .foregroundColor(.black.opacity(0.6))
                                    .fontWeight(.semibold)
                                Spacer()
                                Button{
                                    // MARK: Ekle Buton
                                    self.malzemeler.append("")
                                }label: {
                                    HStack{
                                        Image(systemName: "plus.circle")
                                        Text("Ekle")
                                    }
                                }.foregroundColor(Color("Yesil1"))
                            }.padding(.horizontal)
                            List{
                                ForEach(0..<malzemeler.count,id: \.self) {i in
                                    HStack{
                                        Text("\(i + 1). ")
                                            .foregroundColor(.black.opacity(0.5))
                                        TextField("Malzemeler", text: self.binding(forIndex: i))
                                    }
                                }.onDelete(perform: satirSil)
                                /*
                                 ForEach(malzemeler.indices,id: \.self){i in
                                 HStack{
                                 TextField("Malzeme Giriniz.", text: self.binding(forIndex: i))
                                 }
                                 
                                 }
                                 */
                            }.listStyle(.inset)
                                .frame(height: malzemeler.isEmpty ? 0 : CGFloat(malzemeler.count * 50))
                            
                        }
                        .padding(.top,20)
                        VStack{
                            HStack{
                                Text("Yapılış")
                                    .foregroundColor(.black.opacity(0.6))
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            TextField("Yapılış", text: $yapilis,axis: .vertical)
                                .frame(height: 140)
                                .lineLimit(7,reservesSpace: true)
                                .padding(.horizontal)
                                .padding(.top)
                            
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black.opacity(0.3))
                                )
                        }.padding(.horizontal)
                        Button{
                            // MARK: Kaydet
                            for i in malzemeler {
                                print(i)
                            }
                            ViewModel.tarifEkle(resim: secilenResim!, yemekadi: yemekadi, malzemeler: malzemeler, yapilis: yapilis, profilResim: profilResmi, kullaniciAdi: profilIslemleriViewModel.kullaniciAdi, hesapAd: profilIslemleriViewModel.hesapAdi)
                        }label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color("Yesil1").opacity(0.8))
                                    .frame(width: 200,height: 50)
                                Text("Tarifi Paylaş")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                            }
                        }
                        .padding(.top,40)
                        Spacer()
                    }
                    .padding(.top)
                    
                }

            }
            .onAppear{
                
                profilIslemleriViewModel.profilBilgileriniGetir()
                self.hesapAdi = profilIslemleriViewModel.hesapAdi
                self.kullaniciAdi = profilIslemleriViewModel.kullaniciAdi
                self.profilResmi = profilIslemleriViewModel.profilResmi
                print("kullanıcı adı: \(kullaniciAdi)")
                print("hesap adi : \(hesapAdi)")
                 
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    func binding(forIndex index: Int) -> Binding<String> {
        return Binding(
            get: {
                return self.malzemeler[index]
            },
            set: { newValue in
                self.malzemeler[index] = newValue
            }
        )
    }
     
    /*
    func binding(forIndex index: Int) -> Binding<String> {
        return Binding(
            get: {
                return self.malzemeler[index][0]
            },
            set: { newValue in
                self.malzemeler[index][0] = newValue
            }
        )
    }
     */
}


struct TarifEkleView_Previews: PreviewProvider {
    static var previews: some View {
        TarifEkleView()
    }
}
