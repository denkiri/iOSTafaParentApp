//
//  HomeView.swift
//  TafaParentApp
//
//  Created by Macbook Pro on 15/05/2024.
//

import SwiftUI

struct TestUIView: View {
    @ObservedObject var viewModel = MainViewModel()
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ScrollView{
                VStack{
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.white)
                            .shadow(color: .gray, radius: 4)
                            .frame(width: 360,height: 120)
                            .padding(10)
                            .overlay(
                                HStack{
                                    Image("ic_launcher_round").resizable().aspectRatio(contentMode: .fit)
                                        .frame(width: 100,height: 100,alignment: .top)
                                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                        .shadow(color:Color.defaultBlue, radius:4)
                                    Spacer()
                                    VStack{
                                        Text("Mwangi Timothy")
                                            .font(.title3)
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(.black)
                                        Text("0764207838")
                                            .font(.subheadline)
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(Color.defaultOrange)
                                    }
                                    Spacer()
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.blue)
                                        .frame(width: 40,height: 40)
                                    
                                    
                                }.padding())
                        
                        
                        
                    }
                    ZStack{
                        Image("card_background")
                            .resizable()
                            .frame(width: 360, height: 500)
                            .cornerRadius(20)
                            .overlay(
                                VStack{
                                    Text("Students")
                                        .font(.system(size: 25))
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(.white)
                                    
                                    
                                    Divider()
                                    ScrollView(.vertical, showsIndicators: false){
                                        VStack {
                                            //                                                ForEach(studentData, id: \.id){ data in
                                            //                                                    StudentView(Data: data)
                                            //
                                            //                                                }
                                        }
                                        
                                        
                                    }})
                        
                        
                        
                        
                    }
                    ContactUs()
                }.padding(20)
            }
            .onAppear {
                 func loadDetails() -> Details? {
                    if let savedDetailsData = UserDefaults.standard.data(forKey: "details") {
                        let decoder = JSONDecoder()
                        if let loadedDetails = try? decoder.decode(Details.self, from: savedDetailsData) {
                            return loadedDetails
                        }
                    }
                    return nil
                }
                if let details = loadDetails() {
                    let accessToken = details.access_token
                    let expiresIn = details.expires_in
                    let jwtToken = details.jwt_token
                    let refreshToken = details.refresh_token
                    let tokenType = details.token_type
                    viewModel.getProfile(token: accessToken, jwtAuth:jwtToken)
                    // Use the individual values as needed
                    print("Access Token: \(accessToken)")
                    print("Expires In: \(expiresIn)")
                    print("JWT Token: \(jwtToken)")
                    print("Refresh Token: \(refreshToken)")
                    print("Token Type: \(tokenType)")
                } else {
                    print("Failed to load details from UserDefaults.")
                }
                 }
        }
    }
        
        
    }
    
#Preview {
    HomeView()
}

