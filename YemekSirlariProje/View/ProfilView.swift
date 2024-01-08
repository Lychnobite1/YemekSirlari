//
//  ProfilView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI
import SDWebImageSwiftUI
struct ProfilView: View {
    @State private var gorunum = false
    @State private var arama = ""
    @State private var kullaniciAdi = ""
    @State private var hesapAdi = ""
    @State private var profilResmi = ""
    @ObservedObject var ViewModel = ProfilIslemleriViewModel()
    @ObservedObject var girisCikis = GirisCikisViewModel()
    @State private var cikis = false
    @State private var gecis = false
    @Environment(\.presentationMode) var pm
    func tarifAra() -> [TarifModel] {
        if arama.isEmpty {
            return ViewModel.kullaniciTarifleri
        }
        else {
            return ViewModel.kullaniciTarifleri.filter{i in
                i.yemekAdi.localizedCaseInsensitiveContains(arama)
            }
        }
    }
    
    var body: some View {
        NavigationStack{
            ScrollView(.vertical,showsIndicators: false){
                VStack{
                    HStack{
                        Image(systemName: "circle")
                            .foregroundColor(.white)
                        Spacer()
                        Text("Profil")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(Color("Yesil5"))
                        Spacer()
                        Menu{
                            Button{
                                // MARK: Profil Düzenle
                                self.gecis = true
                            }label: {
                                NavigationLink(destination: ProfilBilgileriGuncelle(), isActive: $gecis){
                                    Label("Profil Düzenle", systemImage: "pencil")
                                }
                            }
                            Button(role: .destructive){
                                // MARK: Çıkış
                                self.girisCikis.cikis()
                            }label: {
                                Label("Çıkış", systemImage: "xmark")
                            }
                            
                            
                        }label: {
                            HStack(spacing: 3){
                                Circle().fill(Color("Yesil5"))
                                Circle().fill(Color("Yesil5"))
                                Circle().fill(Color("Yesil5"))
                                
                            }.frame(width: 20,height: 20)
                        }
                    }.padding(.horizontal)
                        .padding(.top,40)
                    NavigationLink(destination: GirisEkraniView(), isActive: $girisCikis.cikisYapildiMi){
                        EmptyView()
                    }
                    

                    if ViewModel.profilResmi != "" {
                        WebImage(url: URL(string: ViewModel.profilResmi))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150,height: 150)
                            .clipShape(Circle())
                            .padding(.top)
                    }
                    else {
                        Image("cooking1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150,height: 150)
                            .clipShape(Circle())
                            .padding(.top)
                    }
                    
                    HStack(spacing: 30){
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("Yesil5").opacity(0.7))
                                .frame(width: 160,height: 100)
                            VStack(spacing: 13){
                                Text("Kullanıcı Adı")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                if ViewModel.kullaniciAdi != "" {
                                    Text(ViewModel.kullaniciAdi)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white.opacity(0.8))
                                        .font(.system(size: 17))
                                }
                                else {
                                    Text("Belirsiz")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white.opacity(0.8))
                                        .font(.system(size: 17))
                                }
                                
                            }
                        }
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("Yesil5").opacity(0.7))
                                .frame(width: 160,height: 100)
                            VStack(spacing: 13){
                                Text("Tarifler")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                Text("\(ViewModel.kullaniciTarifToplami)")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white.opacity(0.8))
                                    .font(.system(size: 18))
                            }
                        }
                    }
                    HStack{
                        Text("Tarif Listem")
                            .foregroundColor(Color("Yesil5"))
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                        Spacer()
                        Button{
                            self.gorunum.toggle()
                        }label: {
                            Image(systemName: self.gorunum ? "circle.grid.2x2.fill" : "text.justify")
                                .foregroundColor(.black.opacity(0.6))
                                .font(.system(size: 20))
                        }
                        
                    }.padding(.top)
                            .padding(.horizontal,22)

                    
                    Divider().padding(.horizontal)
                    TextField("Tarif Ara", text: $arama)
                        .padding(.horizontal,20)
                        .frame(height: 40)
                        .background(Color("Yesil1").opacity(0.04))
                        .cornerRadius(10)
                        .padding(.horizontal,22)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black.opacity(0.2))
                                .padding(.horizontal,22)
                        )
                    
                    if ViewModel.kullaniciTarifToplami == 0 {
                        BosSayfaView()
                            .padding(.top,20)
                    }
                    else if self.gorunum == true {
                        /*
                        ListTarifView()
                            .padding(.horizontal)
                            .padding(.top)
                         */
                        LazyVGrid(columns: [GridItem(.flexible())]){
                            ForEach(tarifAra(),id: \.documentID){i in
                                NavigationLink(destination: TarifDetayView(tarif: i)){
                                    ProfilListCellView(tarif: i)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                    else {
                        /*
                        ProfilGridView()
                            .padding(.horizontal)
                            .padding(.top)
                         */
                        LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]){
                            ForEach(tarifAra(),id: \.documentID){i in
                                NavigationLink(destination: TarifDetayView(tarif: i)){
                                    ProfilGridCellView(tarif: i)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
                
                
            }
            .onAppear{
                ViewModel.profilBilgileriniGetir()
                ViewModel.kullaniciTarifleriniGetir()
                ViewModel.kullaniciTarifSayisi()
                self.kullaniciAdi = ViewModel.kullaniciAdi
                self.hesapAdi = ViewModel.hesapAdi
                self.profilResmi = ViewModel.profilResmi
                
            }
        }
    }
}
/*
struct BackView : View {
    @Environment(\.presentationMode) var pm
    @ObservedObject var ViewModel = GirisCikisViewModel()
    @State private var cikis = false
    @State private var anasayfaGecis = false
    var body: some View {
        HStack{
            Button{
                self.pm.wrappedValue.dismiss()
            }label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 23))
                    .foregroundColor(.black)
            }
            Spacer()
            Button {
                self.cikis = true
            }label: {
                Image(systemName: "xmark")
                    .font(.system(size: 23))
                    .foregroundColor(.black)
            }
            .alert("Çıkış", isPresented: $cikis){
                Button(role: .cancel){
                    
                }label: {
                    Text("Hayır")
                }
                Button(role: .destructive){
                    ViewModel.cikis()
                }label: {
                    Text("Evet")
                }
            }
        }.padding(.horizontal,25)
            .onChange(of: ViewModel.cikisYapildiMi) { newValue in
                if newValue == false {
                    self.anasayfaGecis = true
                }
            }
        NavigationLink(destination: GirisEkraniView(), isActive: $anasayfaGecis){
            EmptyView()
        }
    }
}
 */
struct BarView : View {
    @ObservedObject var ViewModel = GirisCikisViewModel()
    @State private var gecis = false
    var body: some View {
        HStack{
            Image(systemName: "circle")
                .foregroundColor(.white)
            Spacer()
            Text("Profil")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(Color("Yesil5"))
            Spacer()
            Menu{
                Button{
                    // MARK: Profil Düzenle
                    self.gecis = true
                }label: {
                    NavigationLink(destination: ProfilBilgileriGuncelle(), isActive: $gecis){
                        Label("Profil Düzenle", systemImage: "pencil")
                    }
                }
                Button(role: .destructive){
                    // MARK: Çıkış
                    ViewModel.cikis()
                }label: {
                    Label("Çıkış", systemImage: "xmark")
                }
                
                
            }label: {
                HStack(spacing: 3){
                    Circle().fill(Color("Yesil5"))
                    Circle().fill(Color("Yesil5"))
                    Circle().fill(Color("Yesil5"))
                    
                }.frame(width: 20,height: 20)
            }
        }.padding(.horizontal)
            .onAppear{
                self.gecis = false
            }
        NavigationLink(destination: GirisEkraniView(), isActive: $ViewModel.cikisYapildiMi) {
                EmptyView()
        }
    }
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView()
    }
}
