//
//  ProfilGridView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 5.01.2024.
//

import SwiftUI

struct ProfilGridView: View {
    @ObservedObject var ViewModel = ProfilIslemleriViewModel()
    init(){
        ViewModel.kullaniciTarifSayisi()
        ViewModel.kullaniciTarifleriniGetir()
    }

    var body: some View {
        VStack{
            
            LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]){
                ForEach(ViewModel.kullaniciTarifleri,id: \.documentID){i in
                    NavigationLink(destination: TarifDetayView(tarif: i)){
                        ProfilGridCellView(tarif: i)
                    }
                }
            }
            
        }
        .onAppear{
            ViewModel.kullaniciTarifSayisi()
            ViewModel.kullaniciTarifleriniGetir()
        }
    }
}

struct ProfilGridView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilGridView()
    }
}
