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
    @ObservedObject var viewModel = MainViewModel()
    @State private var navigateToHome = false
    @State private var showTerms = false
    @State private var showPrivacyPolicy = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                ScrollView(showsIndicators: false) {
                    VStack {
                        Spacer()
                        Image("logo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                        Text("Parent login")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.white)
                                .shadow(color: .white, radius: 4)
                                .frame(width: 360, height: 360)
                                .padding(.horizontal, 10)
                            VStack {
                                if username.isEmpty {
                                    Text("Username")
                                        .foregroundColor(.black)
                                        .padding(.leading, 10)
                                        .frame(width: 350, alignment: .center)
                                        .font(Font.system(size: 15, weight: .medium, design: .serif))
                                }
                                TextField("", text: $username)
                                    .padding(10)
                                    .frame(width: 350)
                                    .font(Font.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(.black)
                                    .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 0.5)
                                        .frame(height: 45))
                                    .multilineTextAlignment(.center)
                                    .padding(10)

//                                SecureField("Password", text: $password)
//                                    .font(.title3)
//                                    .padding()
//                                    .frame(width: 350)
//                                    .background(Color.white)
//                                    .foregroundColor(Color.black)
//                                    .cornerRadius(50.0)
//                                    .shadow(color: Color.black.opacity(0.8), radius: 60, x: 0, y: 8)
//                                    .padding(10)
                                if password.isEmpty {
                                    Text("Password")
                                        .foregroundColor(.black)
                                        .padding(.leading, 10)
                                        .frame(width: 350, alignment: .center)
                                        .font(Font.system(size: 15, weight: .medium, design: .serif))
                                }
                                SecureField("", text: $password)
                                    .padding(10)
                                    .frame(width: 350)
                                    .font(Font.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(.black)
                                    .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 0.5)
                                        .frame(height: 45))
                                    .multilineTextAlignment(.center)
                                    .padding(10)


                                Text("By clicking on login, you agree to Tafa Talk")
                                    .fontWeight(.regular)
                                    .foregroundColor(Color.black)
                                HStack {
                                    Text("Terms and conditions of use")
                                        .onTapGesture {
                                            showTerms = true
                                        }
                                        .fontWeight(.regular)
                                        .foregroundColor(Color.defaultBlue)
                                        .underline()
                                    Text("&")
                                        .foregroundColor(.black)
                                    Text("Privacy Policy")
                                        .onTapGesture {
                                            showPrivacyPolicy = true
                                        }
                                        .fontWeight(.regular)
                                        .foregroundColor(Color.defaultBlue)
                                        .underline()

                                }
                               

                                Button(action: {
                                    viewModel.login(username: username, password: password)
                                }) {
                                    RoundedRectangle(cornerRadius: 120)
                                        .frame(width: 350, height: 50, alignment: .center)
                                        .foregroundColor(Color.defaultOrange)
                                        .shadow(color: .gray, radius: 8)
                                        .overlay(Text("Login"))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .font(.system(size: 25))
                                        .padding()
                                }

                                Text("Forgot Password ?")
                                    .foregroundColor(Color.defaultBlue)
                                    .fontWeight(.bold)
                                    .opacity(0.8)
                                    .underline()
                            }
                        }
                        ContactUs()
                    }
                }
            }
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
            .onChange(of: viewModel.loadedDetails) { oldDetails, newDetails in
                if newDetails != nil {
                    navigateToHome = true
                }
            }
            .navigationDestination(isPresented: $navigateToHome) {
            HomeView()
            }
            .navigationDestination(isPresented: $showTerms) {
            TermsView()
            }
            .navigationDestination(isPresented: $showPrivacyPolicy) {
            PrivacyPolicyView()
            }
      
        }
    }
}

#Preview {
    LoginView()
}

struct ContactUs: View {
    var body: some View {
        Text("Contact us")
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
