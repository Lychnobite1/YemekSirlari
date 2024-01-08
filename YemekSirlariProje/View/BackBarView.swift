//
//  BackBarView.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI

struct BackBarView: View {
    @Environment(\.presentationMode) var pm
    var body: some View {
        HStack{
            Button{
                self.pm.wrappedValue.dismiss()
            }label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 23))
                    .foregroundColor(.black)
            }
            Spacer()
        }.padding(.horizontal,25)
    }
}

struct BackBarView_Previews: PreviewProvider {
    static var previews: some View {
        BackBarView()
    }
}
