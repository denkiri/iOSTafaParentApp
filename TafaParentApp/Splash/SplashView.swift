//
//  SplashView.swift
//  TafaParentApp
//
//  Created by Macbook Pro on 14/05/2024.
//

import SwiftUI

struct SplashView: View {
    @State var isActive: Bool = false
    @State private var size = 0.7
    @State private var opacity = 0.4
    var body: some View {
        if  isActive{
            LoginView()
        }
        else{
            ZStack {
                Image("background")
                    .resizable()
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack{
                    Image("ic_launcher_round")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200,height:200)
                    Text("Tafa Talk")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                        .opacity(0.7)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.0)){
                        self.size = 1.1
                        self.opacity = 1.0
                    }
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){ withAnimation{
                        self.isActive = true
                    }}
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
