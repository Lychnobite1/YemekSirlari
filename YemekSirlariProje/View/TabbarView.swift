//
//  TabbarView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI

struct TabbarView: View {
    var body: some View {
        NavigationStack{
            VStack{
                TabView {
                    AnasayfaView().tabItem {
                        VStack{
                            Text("Anasayfa")
                            Image("anasayfa")
                        }
                    }
                    KesfetView().tabItem {
                        VStack{
                            Text("Keşfet")
                            Image("kesfet")
                        }
                    }
                    TarifEkleView().tabItem {
                        VStack{
                            Text("Tarife")
                            Image("olustur")
                            
                        }
                    }
                    ProfilView().tabItem {
                        VStack{
                            Text("Profil")
                            Image("profil")
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
