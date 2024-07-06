//
//  CallLogView.swift
//  TafaParentApp
//
//  Created by Macbook Pro on 23/05/2024.
//

import SwiftUI
struct CallLogView: View {
    var Data:Communication
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 4)
                .frame(width: 360,height: 50)
                .padding([.horizontal], 10)
                .overlay(
                        HStack{
                            Text(Data.mobile_number)
                                .font(.subheadline)
                                .foregroundColor(.black)
                            Spacer()
                            Text("\(Data.timestamp)")
                                .font(.subheadline)
                                .foregroundColor(.black)
                            Spacer()
                            Text(" \(Data.tokens_consumed)")
                                .font(.subheadline)
                                .foregroundColor(Color.black)
                        }.padding())
        }}}
//
//#Preview {
//    CallLogView(Data: Data)
//}
