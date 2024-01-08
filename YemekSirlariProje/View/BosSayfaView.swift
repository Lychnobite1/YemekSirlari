//
//  BosSayfaView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 5.01.2024.
//

import SwiftUI

struct BosSayfaView: View {
    var body: some View {
        VStack(spacing: 40){
            ZStack{
                Image(systemName: "text.justify")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30,height: 30)
                    .foregroundColor(.black.opacity(0.6))
                Rectangle().fill(.black.opacity(0.6))
                    .frame(width: 50,height: 2)
                    .rotationEffect(Angle(degrees: 135))
            }
            Text("Tarifiniz Bulunmamaktadır.")
        }
    }
}

struct BosSayfaView_Previews: PreviewProvider {
    static var previews: some View {
        BosSayfaView()
    }
}
