//
//  StudentDetailsView.swift
//  TafaParentApp
//
//  Created by Macbook Pro on 20/05/2024.
//

import SwiftUI
struct StudentDetailsView: View {
    var packageData:[PaymentPackagesItem] = [
        .init(amount: 50.0, id: "1"),
        .init(amount: 100.0, id: "2"),
        .init(amount: 200.0, id: "3"),
        .init(amount: 500.0, id: "4"),
        .init(amount: 1000.0, id: "5")
    ]
    var callLogData:[CallLogs] = [
        .init(duration:20.0, id: 2, mobile_number: "0700107838", timestamp: 18.00, tokens_consumed: 40.0),
        .init(duration:20.0, id: 2, mobile_number: "0700107838", timestamp: 18.00, tokens_consumed: 40.0),
        .init(duration:20.0, id: 2, mobile_number: "0700107838", timestamp: 18.00, tokens_consumed: 40.0),
        .init(duration:20.0, id: 2, mobile_number: "0700107838", timestamp: 18.00, tokens_consumed: 40.0),
        .init(duration:20.0, id: 2, mobile_number: "0700107838", timestamp: 18.00, tokens_consumed: 40.0),
        .init(duration:20.0, id: 2, mobile_number: "0700107838", timestamp: 18.00, tokens_consumed: 40.0),
        .init(duration:20.0, id: 2, mobile_number: "0700107838", timestamp: 18.00, tokens_consumed: 40.0),
        .init(duration:20.0, id: 2, mobile_number: "0700107838", timestamp: 18.00, tokens_consumed: 40.0)
    ]
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ScrollView{
                VStack(alignment: .leading){
                    VStack{
                        Spacer()
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.white)
                                .shadow(color: .gray, radius: 4)
                                .frame(width: 360,height: 120)
                                .overlay(
                                    HStack{
                                        Image("ic_launcher_round").resizable().aspectRatio(contentMode: .fit)
                                            .frame(width: 100,height: 100,alignment: .top)
                                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                            .shadow(color:Color.defaultBlue, radius:4)
                                        Spacer()
                                        VStack(alignment:.center){
                                            Text("Mwangi Timothy")
                                                .font(.title3)
                                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                                .foregroundColor(.black)
                                            Text("0764207838")
                                                .font(.subheadline)
                                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                                .foregroundColor(Color.defaultOrange)
                                            
                                            
                                        }.padding()
                                        Spacer()
                                        Spacer()
                                    
                                    })
                            
                            
                            
                        }
                        HStack{
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.white)
                                    .shadow(color: .gray, radius: 4)
                                    .frame(width: 160,height: 120)
                                    .padding([.horizontal], 10)
                                HStack{
                                    
                                    VStack{
                                        Text("Token Balance")
                                            .font(.title3)
                                            .fontWeight(.regular)
                                            .foregroundColor(.black)
                                        Text("56.85")
                                            .font(.headline)
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(Color.black)
                                        
                                        
                                    }.padding()
                                }
                                
                                
                                
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.white)
                                    .shadow(color: .gray, radius: 4)
                                    .frame(width: 160,height: 120)
                                    .padding([.horizontal], 10)
                                HStack{
                                    
                                    VStack{
                                        Text("Relative Minutes")
                                            .font(.title3)
                                            .fontWeight(.regular)
                                            .foregroundColor(.black)
                                        Text("11.85")
                                            .font(.headline)
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(Color.black)
                                        
                                        
                                    }.padding()
                                }
                                
                                
                                
                            }
                        }
                        
                        packageViews
                        callLogViews
                        ContactUs()
                        
                    }
                }
                
                
                
                
            }
        }
    }
    
    private var packageViews: some View {
        ZStack{
            Image("card_background")
                .resizable()
                .frame(width: 360, height: 200)
                .cornerRadius(20)
                .overlay(
                    ScrollView(.horizontal){
                        HStack(alignment: .center, spacing: 26) {
                            ForEach(packageData, id: \.id){ data in
                                PackageView(Data: data)
                            }
                        }
                    } .scrollIndicators(.hidden)
                )
        }}
    private var callLogViews: some View {
        ZStack{
            Image("card_background")
                .resizable()
                .frame(width: 360, height: 400)
                .cornerRadius(20)
                .overlay(
                    VStack{
                        Text("Call Logs")
                            .font(.system(size: 25))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                        ScrollView(.vertical){
                            VStack(alignment:.center,spacing: 10){
                                ForEach(callLogData,id: \.id){
                                    data in
                                    CallLogView(Data: data)
                                }
                            }
                        }
                        
                    })
            
        }}
    
}
#Preview {
    StudentDetailsView()
}
