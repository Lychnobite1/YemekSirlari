//
//  ContentView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI

struct AcilisEkraniView: View {
    @State private var index = 0
    @State private var girisSayfasinaGecis = false
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(colors: [Color("Color5").opacity(0.8),Color("Color6").opacity(0.8)], startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    TabView(selection: $index){
                        ForEach(acilisEkraniVerileri,id: \.id){i in
                            VStack(spacing: 20){
                                Image(i.resim)
                                    .resizable()
                                    .scaledToFit()
                                    .clipped()
                                    .frame(width: 265,height: 265)
                                    .cornerRadius(10)
                                Text(i.baslik)
                                    .font(.system(size: 19))
                                    .fontDesign(.serif)
                                    .fontWeight(.bold)
                                Text(i.aciklama)
                                    .frame(width:260,height: nil)
                                    .foregroundColor(.black.opacity(0.6))
                                    .font(.system(size: 15))
                                    .fontDesign(.serif)
                                
                            }
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .frame(height: 550)
                    .offset(y:-30)
                    if self.index == 2 {
                        Button{
                            self.girisSayfasinaGecis = true
                        }label: {
                            NavigationLink(destination: GirisEkraniView(), isActive: $girisSayfasinaGecis){
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.red)
                                        .frame(width: 100,height: 50)
                                    Text("Başla")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                }
                            }
                        }.offset(y:40)
                        
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AcilisEkraniView()
    }
}
