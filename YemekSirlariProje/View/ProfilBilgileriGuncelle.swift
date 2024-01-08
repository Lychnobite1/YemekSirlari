//
//  ProfilBilgileriGuncelle.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 5.01.2024.
//

import SwiftUI
import SDWebImageSwiftUI
struct ProfilBilgileriGuncelle: View {
    @State private var secilenProfilResim : UIImage?
    @State private var profilResimSecildiMi = false
    
    @State private var tfhesapAdi = ""
    @State private var tfkullaniciAdi = ""
    @State private var profilresim = ""
    @ObservedObject var ViewModel = ProfilIslemleriViewModel()
    @ObservedObject var tarifViewModel = TarifViewModel()
     
    init(){
        ViewModel.profilBilgileriniGetir()
    }
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 25){
                ZStack{
                    Rectangle()
                        .fill(LinearGradient(colors: [Color("Yesil1").opacity(0.2),Color("Yesil5").opacity(0.3)], startPoint: .leading, endPoint: .trailing))
                        .frame(height: 260)
                        .edgesIgnoringSafeArea(.top)
                        
                    VStack{
                        BackBarView()
                            .padding(.top)
                            .offset(y:-10)
                        ZStack{
                            Circle().fill(.white).frame(width: 165,height: 165)
                                .offset(y:50)
                            ZStack{
                                
                                 if self.secilenProfilResim != nil {
                                 Image(uiImage: secilenProfilResim!)
                                 .resizable()
                                 .scaledToFill()
                                 .clipShape(Circle())
                                 .frame(width: 150,height: 150)
                                 .clipped()
                                 }
                                 else if ViewModel.profilResmi != "" {
                                 WebImage(url: URL(string: ViewModel.profilResmi))
                                 .resizable()
                                 .clipShape(Circle())
                                 .frame(width: 150,height: 150)
                                 .clipped()
                                 }
                                 else {
                                 Image("VarsayilanResim")
                                 .resizable()
                                 .clipped()
                                 .clipShape(Circle())
                                 .frame(width: 150,height: 150)
                                 .clipped()
                                 }
                                 
                                Button{
                                    self.profilResimSecildiMi = true
                                }label: {
                                    Image(systemName: "plus")
                                        .foregroundColor(Color("Yesil5"))
                                        .font(.system(size: 25))
                                }
                                .offset(x:80,y: 60)
                                .sheet(isPresented: $profilResimSecildiMi){
                                    ProfilResmiSec(secilenProfilResmi: $secilenProfilResim, profilResimSecildiMi: $profilResimSecildiMi)
                                }
                            }
                            .offset(y:50)
                        }
                    }
                }
                
                    
                VStack(alignment: .leading,spacing: 15){
                    Text("Hesap Adı")
                        .fontWeight(.bold)
                        .foregroundColor(.black.opacity(0.6))
                    TextField("Hesap Adı", text: $tfhesapAdi)
                        .padding(.horizontal)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black.opacity(0.5))
                                .frame(height: 40)
                        )
                }
                .padding(.top,30)
                .padding(.horizontal)
                .offset(y:30)
                VStack(alignment: .leading, spacing: 15){
                    Text("Kullanıcı Adı")
                        .fontWeight(.bold)
                        .foregroundColor(.black.opacity(0.6))
                    TextField("Kullanıcı Adı", text: $tfkullaniciAdi)
                        .padding(.horizontal)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black.opacity(0.5))
                                .frame(height: 40)
                        )
                }
                .padding(.top,30)
                .padding(.horizontal)
                .offset(y:25)
                Button{
                    
                    if tfhesapAdi != "" && tfkullaniciAdi != "" && secilenProfilResim == nil {
                        DispatchQueue.main.async {
                            ViewModel.hesapBilgileriniGuncelle(yeniKullaniciAdi: tfkullaniciAdi, yeniHesapAdi: tfhesapAdi)
                            tarifViewModel.tarifKullaniciBilgileriGuncelle(yeniHesapAdi: tfhesapAdi, yeniKullaniciAdi: tfkullaniciAdi)
                        }
                        
                    }
                    else if tfhesapAdi != "" && tfkullaniciAdi != "" && secilenProfilResim != nil {
                        DispatchQueue.main.async {
                            tarifViewModel.tarifProfilResmiGuncelle(yeniResim: secilenProfilResim!)
                            tarifViewModel.tarifKullaniciBilgileriGuncelle(yeniHesapAdi: tfhesapAdi, yeniKullaniciAdi: tfkullaniciAdi)
                            ViewModel.profilResimGuncelle(yeniResim: secilenProfilResim!)
                            ViewModel.hesapProfilResmiGuncelle(yeniResim: secilenProfilResim!)
                        }
                        
                    }
                    print("ka: \(ViewModel.kullaniciAdi)")
                    print("ha: \(ViewModel.hesapAdi)")
                    print("profil: \(ViewModel.profilResmi)")
                    
                }label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("Yesil5").opacity(0.9))
                            .frame(width: 150,height: 50)
                        Text("Güncelle")
                            .fontWeight(.bold)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            
                    }
                }
                .padding(.top,30)
                .offset(y:30)
                Spacer()
                
            }
            .onAppear{
                
                ViewModel.profilBilgileriniGetir()
                    
                self.tfhesapAdi = ViewModel.hesapAdi
                self.tfkullaniciAdi = ViewModel.kullaniciAdi
                self.profilresim = ViewModel.profilResmi
                     
                
                
            }
             
            .navigationBarBackButtonHidden(true)
        }
    }
}
/*
 VStack(spacing: 25){
     BackBarView()
         .padding(.top)
     
     ZStack{
         Image("yemek1")
             .resizable()
             .clipped()
             .clipShape(Circle())
             .frame(width: 150,height: 150)
             .clipped()
         /*
         if self.secilenProfilResim != nil {
             Image(uiImage: secilenProfilResim!)
                 .resizable()
                 .scaledToFill()
                 .clipShape(Circle())
                 .frame(width: 150,height: 150)
                 .clipped()
         }
         else if ViewModel.profilResmi != "" {
             WebImage(url: URL(string: ViewModel.profilResmi))
                 .resizable()
                 .clipShape(Circle())
                 .frame(width: 150,height: 150)
                 .clipped()
         }
         else {
             Image("VarsayilanResim")
                 .resizable()
                 .clipped()
                 .clipShape(Circle())
                 .frame(width: 150,height: 150)
                 .clipped()
         }
         */
         Button{
             self.profilResimSecildiMi = true
         }label: {
             Image(systemName: "plus")
                 .foregroundColor(Color("Yesil5"))
                 .font(.system(size: 25))
         }
         .offset(x:80,y: 60)
         .sheet(isPresented: $profilResimSecildiMi){
             ProfilResmiSec(secilenProfilResmi: $secilenProfilResim, profilResimSecildiMi: $profilResimSecildiMi)
         }
     }
     .offset(y:50)
         
     VStack(alignment: .leading,spacing: 15){
         Text("Hesap Adı")
             .fontWeight(.bold)
             .foregroundColor(.black.opacity(0.6))
         TextField("Hesap Adı", text: $tfhesapAdi)
             .padding(.horizontal)
             .overlay(
                 RoundedRectangle(cornerRadius: 5)
                     .stroke(.black.opacity(0.5))
                     .frame(height: 40)
             )
     }
     .padding(.top,30)
     .padding(.horizontal)
     .offset(y:50)
     VStack(alignment: .leading, spacing: 15){
         Text("Kullanıcı Adı")
             .fontWeight(.bold)
             .foregroundColor(.black.opacity(0.6))
         TextField("Kullanıcı Adı", text: $tfkullaniciAdi)
             .padding(.horizontal)
             .overlay(
                 RoundedRectangle(cornerRadius: 5)
                     .stroke(.black.opacity(0.5))
                     .frame(height: 40)
             )
     }
     .padding(.top,30)
     .padding(.horizontal)
     .offset(y:50)
     Button{
         /*
         if tfhesapAdi != "" && tfkullaniciAdi != "" && secilenProfilResim == nil {
             DispatchQueue.main.async {
                 ViewModel.hesapBilgileriniGuncelle(yeniKullaniciAdi: tfkullaniciAdi, yeniHesapAdi: tfhesapAdi)
                 tarifViewModel.tarifKullaniciBilgileriGuncelle(yeniHesapAdi: tfhesapAdi, yeniKullaniciAdi: tfkullaniciAdi)
             }
             
         }
         else if tfhesapAdi != "" && tfkullaniciAdi != "" && secilenProfilResim != nil {
             DispatchQueue.main.async {
                 tarifViewModel.tarifProfilResmiGuncelle(yeniResim: secilenProfilResim!)
                 tarifViewModel.tarifKullaniciBilgileriGuncelle(yeniHesapAdi: tfhesapAdi, yeniKullaniciAdi: tfkullaniciAdi)
                 ViewModel.profilResimGuncelle(yeniResim: secilenProfilResim!)
                 ViewModel.hesapProfilResmiGuncelle(yeniResim: secilenProfilResim!)
             }
             
         }
         print("ka: \(ViewModel.kullaniciAdi)")
         print("ha: \(ViewModel.hesapAdi)")
         print("profil: \(ViewModel.profilResmi)")
         */
     }label: {
         ZStack{
             RoundedRectangle(cornerRadius: 10)
                 .fill(Color("Yesil5").opacity(0.9))
                 .frame(width: 150,height: 50)
             Text("Güncelle")
                 .fontWeight(.bold)
                 .fontWeight(.semibold)
                 .foregroundColor(.white)
                 .font(.system(size: 18))
                 
         }
     }
     .padding(.top,30)
     .offset(y:50)
     Spacer()
     
 }
 */
struct ProfilBilgileriGuncelle_Previews: PreviewProvider {
    static var previews: some View {
        ProfilBilgileriGuncelle()
    }
}

