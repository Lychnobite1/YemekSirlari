//
//  AnasayfaView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI

struct AnasayfaView: View {
    @State private var yemekResimleri = ["yemek1","yemek2","yemek3","yemek4","yemek5","yemek6","yemek7","yemek8","yemek9","yemek10","yemek11","yemek12"]
    @State private var rastgeleResimler : [String] = []
    @ObservedObject var ViewModel = TarifViewModel()
    @State private var currentPicker = 0
    init(){
        ViewModel.tarifleriGetir()
    }
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    HeaderView()
                    
                    TabView{
                        ForEach(rastgeleResimler,id: \.self){i in
                            Image(i)
                                .resizable()
                                .frame(width: 350,height: 270)
                                .clipped()
                                .cornerRadius(25)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                        .frame(height: 280)
                        .padding(.top)
                    HStack{
                        Text("Tarifler").foregroundColor(.black.opacity(0.6))
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .padding(.horizontal)
                        Spacer()
                        Picker("", selection: $currentPicker){
                            Text("En Çok Beğenilen").tag(0)
                            Text("En Çok Yorum Yapılan").tag(1)
                            Text("Pratik Tarifler").tag(2)
                            Text("Yeni Eklenenler").tag(3)
                        }.accentColor(Color("Yesil5"))
                        
                        
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    GridTarifView()
                        .padding(.horizontal)
                    
                    
                    
                }
                .padding(.top)
                .navigationBarBackButtonHidden(true)
                .onAppear{
                    ViewModel.tarifleriGetir()
                    self.rastgeleResimler = []
                    let items = yemekResimleri.shuffled().prefix(4)
                    for i in items {
                        self.rastgeleResimler.append(i)
                    }
                }
            }
        }
    }
}

struct AnasayfaView_Previews: PreviewProvider {
    static var previews: some View {
        AnasayfaView()
    }
}
