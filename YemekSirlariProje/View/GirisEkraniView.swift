//
//  GirisEkraniView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import Firebase
import FirebaseAuth
struct GirisEkraniView: View {
    @State private var email = ""
    @State private var sifre = ""
    @State private var sifreGorunuyorMu = false
    @State private var kayitolGecis = false
    @State private var hataMesaji = ""
    @ObservedObject var ViewModel = GirisCikisViewModel()
    @State private var tabbarGecis = false
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(colors: [Color("Color5").opacity(0.8),Color("Color6").opacity(0.8)], startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 50){
                    VStack{
                        HStack{
                            Image(systemName: "person")
                                .font(.system(size: 20))
                                .foregroundColor(.black.opacity(0.5))
                            TextField("Email", text: $email)
                        }
                        .padding(.horizontal,50)
                        Divider()
                            .frame(width: 320)
                            .offset(y:8)
                    }
                    VStack{
                        HStack{
                            Image(systemName: "lock")
                                .font(.system(size: 20))
                                .foregroundColor(.black.opacity(0.5))
                            if self.sifreGorunuyorMu == true {
                                TextField("Şifre", text: $sifre)
                                    .onChange(of: sifre){ newValue in
                                        if sifre.count > 10 {
                                            self.hataMesaji = "fazla karakter"
                                        }
                                        else {
                                            self.hataMesaji = ""
                                        }
                                    }
                            }
                            else {
                                SecureField("Şifre", text: $sifre)
                                    .onChange(of: sifre){ newValue in
                                        if sifre.count > 10 {
                                            self.hataMesaji = "fazla karakter"
                                        }
                                        else {
                                            self.hataMesaji = ""
                                        }
                                    }
                            }
                            
                            
                            Button{
                                self.sifreGorunuyorMu.toggle()
                            }label: {
                                Image(systemName:self.sifreGorunuyorMu ? "eye" : "eye.slash")
                                    .foregroundColor(.black.opacity(0.5))
                            }
                        }
                        .offset(y:-3)
                        .padding(.horizontal,50)
                        Divider()
                            .frame(width: 320)
                            .offset(y:8)
                        HStack{
                            Spacer()
                            Text(hataMesaji)
                                .offset(y:5)
                                .foregroundColor(.red)
                                .fontWeight(.semibold)
                                .font(.system(size: 15))
                        }.padding(.horizontal,50)
                    }
                    HStack(spacing: 10){
                        Button{
                            // MARK: Giriş Yap
                            if self.email != "" && self.sifre != ""{
                                ViewModel.girisYap(email: email, sifre: sifre)
                            }
                            else {
                                print("giriş yapılamaz..")
                            }
                            
                        }label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color("Yesil5").opacity(0.8))
                                    .frame(width: 130,height: 50)
                                Text("Giriş Yap")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                            }
                        }
                        NavigationLink(destination: TabbarView(), isActive: $tabbarGecis){
                            EmptyView()
                        }
                        Spacer()
                        Button{
                            // MARK: Kayıt Ol
                            self.kayitolGecis = true
                        }label: {
                            NavigationLink(destination: KayitEkraniView(), isActive: $kayitolGecis){
                                ZStack{
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(.black.opacity(0.17))
                                        .frame(width: 130,height: 50)
                                    Text("Kaydol")
                                        .foregroundColor(Color("Yesil5"))
                                        .fontWeight(.semibold)
                                }
                            }
                            
                        }
                    }.padding(.horizontal,70)
                    
                    if ViewModel.girisYapildiMi {
                        ProgressView("Giriş Yapılıyor..")
                            .frame(height: 50)
                    }
                      
                    VStack(spacing: 25){
                        Button{
                            // MARK: Google ile devam
                            handleLogin()
                        }label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 14).fill(Color("Color6")).frame(width: 330,height: 50)
                                    
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 14).stroke(.black.opacity(0.4))
                                    )
                                HStack{
                                    Image("google")
                                        .resizable()
                                        .frame(width: 23,height: 23)
                                    Text("Google İle Devam Et")
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        Button{
                            // MARK: Apple ile devam
                        }label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 14).fill(Color("Color6")).frame(width: 330,height: 50)
                                    
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 14).stroke(.black.opacity(0.4))
                                    )
                                HStack{
                                    Image("apple")
                                        .resizable()
                                        .frame(width: 23,height: 23)
                                    Text("Apple İle Devam Et")
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        
                    }
                    
                }
                .offset(y:30)
                
                
                
            }
            .navigationBarBackButtonHidden(true)
            .onChange(of: ViewModel.girisYapildiMi) { newValue in
                if newValue == false {
                    self.tabbarGecis = true
                }
            }
            
        }
    }
    
    func handleLogin(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) {  result, error in
            if let error = error {
                print("error")
            }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { (result, error) in
                if error != nil {
                    print("hata var")
                }
                guard let user = result?.user else {
                    return
                }
                print(user.displayName ?? "success!")
                UserDefaults.standard.set(true, forKey: "signin")
            }
        }
    }
}
extension View {
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        return root
    }
}
struct GirisEkraniView_Previews: PreviewProvider {
    static var previews: some View {
        GirisEkraniView()
    }
}
