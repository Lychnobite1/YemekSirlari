//
//  KesfetView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI

struct KesfetView: View {
    @State private var yemekAra = ""
    @ObservedObject var ViewModel = TarifViewModel()
    init(){
        ViewModel.tarifleriGetir()
    }
    func tarifAra() -> [TarifModel] {
        if yemekAra.isEmpty {
            return ViewModel.tarifListesi
        }
        else {
            return ViewModel.tarifListesi.filter { i in
                i.yemekAdi.localizedCaseInsensitiveContains(yemekAra)
            }
        }
    }
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack{
                TextField("Pizza,Hamburger vb.", text: $yemekAra)
                    .padding(.horizontal,40)
                    .frame(height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black.opacity(0.3))
                            .frame(height: 50)
                            .padding(.horizontal)
                    )
                VStack{
                    HStack{
                        Text("Kategoriler")
                            .font(.system(size: 22))
                            .fontWeight(.semibold)
                            .foregroundColor(.black.opacity(0.7))
                        Spacer()
                    }
                    KategoriView()
                }
                .padding(.top)
                .padding(.horizontal)
                VStack{
                    HStack{
                        Text("Tarifleri Keşfet")
                            .font(.system(size: 22))
                            .fontWeight(.semibold)
                            .foregroundColor(.black.opacity(0.7))
                        Spacer()
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                
                //GridTarifView()
                LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]){
                    ForEach(tarifAra(),id: \.documentID){i in
                        NavigationLink(destination: TarifDetayView(tarif: i)){
                            GridTarifCellView(tarif: i)
                        }
                    }
                }
                Spacer()
            }
            .padding(.top,40)
            .onAppear{
                ViewModel.tarifleriGetir()
            }
        }
    }
}

struct KesfetView_Previews: PreviewProvider {
    static var previews: some View {
        KesfetView()
    }
}
