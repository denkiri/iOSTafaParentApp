//
//  ContentView.swift
//  TafaParentApp
//
//  Created by Macbook Pro on 14/05/2024.
//
import SwiftUI
struct ContentView: View {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    var body: some View {
        NavigationView {
            if isLoggedIn {
                HomeView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
