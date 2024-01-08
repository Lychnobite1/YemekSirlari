//
//  GridTarifView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI

struct GridTarifView: View {
    @ObservedObject var ViewModel = TarifViewModel()
    
    init(){
        ViewModel.tarifleriGetir()
    }
    

    var body: some View {
        VStack{
            LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]){
                ForEach(ViewModel.tarifListesi,id: \.documentID){i in
                    NavigationLink(destination: TarifDetayView(tarif: i)){
                        GridTarifCellView(tarif: i)
                    }
                }
            }
        }
        .onAppear{
            ViewModel.tarifleriGetir()
        }
    }
}

struct GridTarifView_Previews: PreviewProvider {
    static var previews: some View {
        GridTarifView()
    }
}
