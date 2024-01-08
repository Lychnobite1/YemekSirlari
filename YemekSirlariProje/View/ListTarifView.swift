//
//  ListTarifView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 5.01.2024.
//

import SwiftUI

struct ListTarifView: View {
    @ObservedObject var ViewModel = ProfilIslemleriViewModel()
    init(){
        ViewModel.kullaniciTarifSayisi()
        ViewModel.kullaniciTarifleriniGetir()
    }
    var body: some View {
        VStack{
            LazyVGrid(columns: [GridItem(.flexible())]){
                ForEach(ViewModel.kullaniciTarifleri,id: \.documentID){i in
                    NavigationLink(destination: TarifDetayView(tarif: i)){
                        ProfilListCellView(tarif: i)
                    }
                }
            }
        }
        .onAppear{
            ViewModel.kullaniciTarifleriniGetir()
            ViewModel.kullaniciTarifSayisi()
        }
    }
}

struct ListTarifView_Previews: PreviewProvider {
    static var previews: some View {
        ListTarifView()
    }
}
