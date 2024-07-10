//
//  HomeView.swift
//  TafaParentApp
//
//  Created by Macbook Pro on 15/05/2024.
//

import SwiftUI

import SwiftUI
import Combine

struct HomeView: View {
    @ObservedObject var viewModel = MainViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                             Spacer()
                        if let profile = viewModel.profileDetails {
                            ScrollView{
                                ProfileCardView(profile: profile, viewModel: viewModel)
                                ZStack {
                                    Image("card_background")
                                        .resizable()
                                        .frame(width: 360, height: 500)
                                        .cornerRadius(20)
                                        .overlay(
                                            VStack {
                                                Text("Students")
                                                    .font(.system(size: 25))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.white)
                                                Divider()
                                                ScrollView(.vertical, showsIndicators: false) {
                                                    VStack {
                                                        ForEach(profile.students, id: \.id) { data in
                                                            StudentView(Data: data)
                                                        }
                                                    }
                                                }
                                            }
                                        )
                                }
                                ContactUs()
                            }
                        } 
                    else if viewModel.errorMessage.isEmpty {
                            Text("Loading...")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        } else {
                            ErrorView(errorMessage: viewModel.errorMessage) {
                                reloadProfile()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        }
                      
                    }
                    .padding(20)
                
                .onAppear {
                    reloadProfile()
                }
            }
        }
//        .alert(isPresented: $viewModel.showingAlert) {
//            Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
//        }
    }

    private func reloadProfile() {
        if let details = loadDetails() {
            viewModel.getProfile(token: details.access_token, jwtAuth: details.jwt_token)
        } else {
            print("Failed to load details from UserDefaults.")
        }
    }

    private func loadDetails() -> Details? {
        if let savedDetailsData = UserDefaults.standard.data(forKey: "details") {
            let decoder = JSONDecoder()
            if let loadedDetails = try? decoder.decode(Details.self, from: savedDetailsData) {
                return loadedDetails
            }
        }
        return nil
    }
}

struct ProfileCardView: View {
    let profile: ProfileDetails
    let viewModel: MainViewModel
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = true

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 4)
                .frame(width: 360, height: 120)
                .padding(10)
                .overlay(
                    HStack {
                        Image("ic_launcher_round")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .shadow(color: Color.defaultBlue, radius: 4)

                        Spacer()

                        VStack(alignment: .center) {
                            Text(profile.name)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.black)

                            Text(profile.username)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.defaultOrange)
                        }

                        Spacer()

                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.blue)
                            .frame(width: 35, height: 35)
                            .onTapGesture {
                                viewModel.logout()
                                isLoggedIn = false
                            }
                    }
                    .padding()
                )
        }
    }
}

struct ErrorView: View {
    let errorMessage: String
    let retryAction: () -> Void

    var body: some View {
            VStack {
                Text(errorMessage)
                    .font(.headline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button(action: retryAction) {
                    Text("Retry")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.defaultOrange)
                        .cornerRadius(10)
                }
            }
            .padding()
            .cornerRadius(20)
            .shadow(radius: 10)
        
    }
}


    
#Preview {
    HomeView()
}
