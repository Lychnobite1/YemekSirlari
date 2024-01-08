//
//  KayitEkraniView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI

struct KayitEkraniView: View {
    @State private var kullaniciAdi = ""
    @State private var hesapAdi = ""
    @State private var email = ""
    @State private var sifre = ""
    @State private var sifreTekrar = ""
    @State private var profilResmi = ""
    @State private var sifreGosterilsinMi = false
    @State private var sifreTekrarGosterilsinMi = false
    @State private var sifrehataMesaji = ""
    @State private var sifretekrarHataMesaji = ""
    @ObservedObject var ViewModel = GirisCikisViewModel()
    @Environment(\.presentationMode) var pm
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(colors: [Color("Color5").opacity(0.8),Color("Color6").opacity(0.8)], startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 50){
                    BackBarView().padding(.top,30)
                    VStack{
                        HStack{
                            TextField("Kullanıcı Adı", text: $kullaniciAdi)
                        }
                        Divider().frame(width: 290)
                            .offset(y:8)
                    }.padding(.horizontal,50).padding(.top,50)
                    VStack{
                        HStack{
                            TextField("Hesap Adı", text: $hesapAdi)
                        }
                        Divider().frame(width: 290)
                            .offset(y:8)
                    }.padding(.horizontal,50)
                    VStack{
                        HStack{
                            TextField("Email", text: $email)
                        }
                        Divider().frame(width: 290)
                            .offset(y:8)
                    }.padding(.horizontal,50)
                    VStack{
                        HStack{
                            if self.sifreGosterilsinMi == true {
                                TextField("Şifre", text: $sifre)
                                    .onChange(of: sifre) { newValue in
                                        if self.sifre.count > 10 {
                                            self.sifrehataMesaji = "Fazla karakter"
                                        }
                                        else {
                                            self.sifrehataMesaji = ""
                                        }
                                    }
                            }
                            else {
                                SecureField("Şifre", text: $sifre)
                                    .onChange(of: sifre) { newValue in
                                        if self.sifre.count > 10 {
                                            self.sifrehataMesaji = "Fazla karakter"
                                        }
                                        else {
                                            self.sifrehataMesaji = ""
                                        }
                                    }
                            }
                            
                            Button{
                                self.sifreGosterilsinMi.toggle()
                            }label: {
                                Image(systemName: self.sifreGosterilsinMi ? "eye" : "eye.slash")
                                    .foregroundColor(.black.opacity(0.5))
                            }
                        }
                        Divider().frame(width: 290)
                            .offset(y:8)
                        HStack{
                            Spacer()
                            Text(sifrehataMesaji)
                                .offset(y:5)
                                .foregroundColor(.red)
                                .fontWeight(.semibold)
                                .font(.system(size: 15))
                        }.padding(.horizontal,50)
                    }.padding(.horizontal,50)
                    VStack{
                        HStack{
                            if self.sifreTekrarGosterilsinMi == true {
                                TextField("Şifre Tekrar", text: $sifreTekrar)
                                    .onChange(of: sifreTekrar) { newValue in
                                        if self.sifreTekrar.count > 10 {
                                            self.sifretekrarHataMesaji = "Fazla karakter"
                                        }
                                        else {
                                            self.sifretekrarHataMesaji = ""
                                        }
                                    }
                            }
                            else {
                                SecureField("Şifre Tekrar", text: $sifreTekrar)
                                    .onChange(of: sifreTekrar) { newValue in
                                        if self.sifreTekrar.count > 10 {
                                            self.sifretekrarHataMesaji = "Fazla karakter"
                                        }
                                        else {
                                            self.sifretekrarHataMesaji = ""
                                        }
                                    }
                            }
                            
                            Button{
                                self.sifreTekrarGosterilsinMi.toggle()
                            }label: {
                                Image(systemName: self.sifreTekrarGosterilsinMi ? "eye" : "eye.slash")
                                    .foregroundColor(.black.opacity(0.5))
                            }
                        }
                        Divider().frame(width: 290)
                            .offset(y:8)
                        HStack{
                            Spacer()
                            Text(sifretekrarHataMesaji)
                                .offset(y:5)
                                .foregroundColor(.red)
                                .fontWeight(.semibold)
                                .font(.system(size: 15))
                        }.padding(.horizontal,50)
                    }.padding(.horizontal,50)
                    Button{
                        // MARK: kayıtol
                        ViewModel.kayitOl(email: email, sifre: sifre, kullaniciAdi: kullaniciAdi, profilResim: profilResmi, hesapAdi: hesapAdi)
                    }label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color("Yesil5"))
                                .frame(width: 130,height: 50)
                            Text("Kayıt Ol")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                    }
                    if ViewModel.kayitYapildiMi {
                        ProgressView("Kayıt Yapılıyor..")
                    }
                    
                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
                .onChange(of: ViewModel.kayitYapildiMi) { newValue in
                    if newValue == false {
                        self.kullaniciAdi = ""
                        self.hesapAdi = ""
                        self.sifre = ""
                        self.sifreTekrar = ""
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                            self.pm.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
    }
}

struct KayitEkraniView_Previews: PreviewProvider {
    static var previews: some View {
        KayitEkraniView()
    }
}
