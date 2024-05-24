//
//  CallLogView.swift
//  TafaParentApp
//
//  Created by Macbook Pro on 23/05/2024.
//

import SwiftUI
let callLogData = CallLogs(duration: 20.0, id: 20, mobile_number: "0700107838", timestamp: 50.0, tokens_consumed: 50.0)
struct CallLogView: View {
    var Data:CallLogs
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

#Preview {
    CallLogView(Data: callLogData)
}
