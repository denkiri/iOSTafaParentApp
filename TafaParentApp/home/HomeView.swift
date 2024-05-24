//
//  HomeView.swift
//  TafaParentApp
//
//  Created by Macbook Pro on 15/05/2024.
//

import SwiftUI

struct HomeView: View {
    var studentData: [Student] = [
        .init(date_created: "23-03-2024", id: "1", name: "Dele Tech", status: "Active", username: "Dele", school: "Alliance Boys", token: 50.0, token_rate_per_min: 5.0, student_activation: 30.0),
        .init(date_created: "23-03-2023", id: "2", name: "Dele Tech", status: "Active", username: "Dele", school: "Alliance Boys", token: 50.0, token_rate_per_min: 5.0, student_activation: 30.0),
        .init(date_created: "23-03-2023", id: "3", name: "Dele Tech", status: "Active", username: "Dele", school: "Alliance Boys", token: 50.0, token_rate_per_min: 5.0, student_activation: 30.0)
    ]

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
                                                ForEach(studentData, id: \.id){ data in
                                                    StudentView(Data: data)
                                                    
                                                }
                                            }
                                            
                                            
                                        }})
                            
                            
                            
                            
                        }
                        ContactUs()
                    }.padding(20)
                }
        
            }}
        
        
    }
    
#Preview {
    HomeView()
}
