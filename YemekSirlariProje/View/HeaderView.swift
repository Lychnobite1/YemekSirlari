//
//  HeaderView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 7.01.2024.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack(spacing: 15){
            Image(systemName: "frying.pan")
            Text("Yemek Sırları")
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .foregroundColor(Color("Yesil5"))
            Image(systemName: "frying.pan")
                .rotationEffect(Angle.degrees(180))
                .scaleEffect(x:1,y: -1,anchor: .center)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
