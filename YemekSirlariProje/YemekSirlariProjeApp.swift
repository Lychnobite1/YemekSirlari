//
//  YemekSirlariProjeApp.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI
import Firebase
@main
struct YemekSirlariProjeApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            if Auth.auth().currentUser != nil {
                TabbarView()
            }
            else {
                AcilisEkraniView()
            }
            
        }
    }
}
