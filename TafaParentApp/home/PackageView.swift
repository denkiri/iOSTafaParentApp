//
//  PackageView.swift
//  TafaParentApp
//
//  Created by Macbook Pro on 20/05/2024.
//
import SwiftUI
let samplePackageData = PaymentPackagesItem(amount: 50.0, id: "1")
struct PackageView: View {
    var Data:PaymentPackagesItem
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 4)
                .frame(width: 150,height: 160)
                .padding([.horizontal], 10)
                .overlay(
                    HStack(alignment: .center, spacing: 8){
                VStack(
                    alignment:.center
                ){
                    Text("Recharge")
                        .font(.title3)
                        .fontWeight(.regular)
                        .foregroundColor(.black)
                    Text("Tokens")
                        .font(.title3)
                        .fontWeight(.regular)
                        .foregroundColor(.black)
                    Text("KSH \(Data.amount)")
                        .font(.headline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.black)
                    RoundedRectangle(cornerRadius: 120)
                        .frame(width: 100,height: 40,alignment: .center)
                        .foregroundColor(Color.green)
                        .shadow(color: .gray, radius: 8)
                        .overlay(Text("Pay"))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .padding()
                    
                    
                }
            })
            
            
            
        }
    }
}

#Preview {
    PackageView(Data: samplePackageData)
}
