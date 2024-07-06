//
//  StudentView.swift
//  TafaParentApp
//
//  Created by Macbook Pro on 15/05/2024.
//

import SwiftUI

struct StudentView: View {
    var Data: Student
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 4)
                    .frame(width: 360, height: 250)
                    .padding([.horizontal], 10)
                    .overlay(
                        VStack(alignment: .center, spacing: 10) {
                            HStack {
                                Text("Date")
                                    .font(.title3)
                                    .foregroundColor(.black)
                                Spacer()
                                Text(Data.date_created)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                            }
                            HStack {
                                Text("Status")
                                    .font(.title3)
                                    .foregroundColor(.black)
                                Spacer()
                                Text(Data.status)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.green)
                            }
                            HStack {
                                Text("Name")
                                    .font(.title3)
                                    .foregroundColor(.black)
                                Spacer()
                                Text(Data.name)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                            }
                            HStack {
                                Text("Username")
                                    .font(.title3)
                                    .foregroundColor(.black)
                                Spacer()
                                Text(Data.username)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                            }
                            HStack {
                                Text("Token")
                                    .font(.title3)
                                    .foregroundColor(.black)
                                Spacer()
                                Text("\(Data.token ?? 0.00, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                            }
                            HStack {
                                if Data.status != "ACTIVE" {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 80, height: 40, alignment: .center)
                                        .foregroundColor(Color.defaultBlue)
                                        .shadow(color: .gray, radius: 8)
                                        .overlay(Text("Activate"))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                }
                                Spacer()
                                NavigationLink(destination: StudentDetailsView(data: Data)) {
                                    Text("View More >>")
                                        .font(.subheadline)
                                        .foregroundColor(.defaultOrange)
                                        .fontWeight(.bold)
                                }
                            }
                        }.padding()
                    )
            }
        }
    }


//#Preview {
//   // StudentView(Data:sampleData)
//}
