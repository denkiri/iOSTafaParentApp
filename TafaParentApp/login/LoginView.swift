//
//  LoginView.swift
//  TafaParentApp
//
//  Created by Macbook Pro on 14/05/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    var body: some View {
        ZStack {
            Image("background")
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack{
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200,height: 200)
                Text("Parent login")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.white)
                        .shadow(color: .gray, radius: 4)
                        .frame(width: 360,height: 370)
                        .padding([.horizontal], 10)
                    VStack {
                        TextField("Username", text: $username)
                            .font(.title3)
                            .padding()
                            .frame(width: 350)
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(20), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 8)
                            .padding(.vertical)
                           
                        TextField("Password", text: $password)
                            .font(.title3)
                            .padding()
                            .frame(width: 350)
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(20), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 8)
                            .padding(.vertical)
                        Text("By clicking on login,you agree to Tafa Talk")
                            .fontWeight(.regular)
                            .foregroundColor(Color.black)
                        HStack{
                            Text("Terms and conditions of use")
                                .fontWeight(.regular)
                                .foregroundColor(Color.defaultBlue)
                                .underline()
                            Text("&")
                            Text("Privacy Policy")
                                .fontWeight(.regular)
                                .foregroundColor(Color.defaultBlue)
                                .underline()
                            
                    
                        }
                        RoundedRectangle(cornerRadius: 120)
                            .frame(width: 350,height: 50,alignment: .center)
                            .foregroundColor(Color.defaultOrange)
                            .shadow(color: .gray, radius: 8)
                            .overlay(Text("Login"))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                            .padding()
                        Text("Forgot Password ?")
                            .font(.system(size: 20))
                            .foregroundColor(Color.defaultBlue)
                            .fontWeight(.bold)
                            .opacity(0.8)
                        
                    }
                    
                    
                    
                }
                Text("Contact us")
                    .font(.system(size: 18))
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .opacity(0.8)
                HStack{
                    Text("+254706938156")
                        .fontWeight(.regular)
                        .foregroundColor(Color.white)
                    Text("|")
                        .fontWeight(.regular)
                        .foregroundColor(Color.white)
                    
                    Text("+254706938156")
                        .fontWeight(.regular)
                        .foregroundColor(Color.white)
                    
                    
                }.padding()
                Text("Version:1.0.5")
                    .font(.system(size: 18))
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .opacity(0.8)
            }
        }
    }
}

#Preview {
    LoginView()
}
