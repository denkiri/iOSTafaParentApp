//
//  PrivacyPolicyView.swift
//  TafaParentApp
//
//  Created by Macbook Pro on 03/07/2024.
//

import SwiftUI
import WebKit

struct PrivacyPolicyView: View {
    var body: some View {
    PolicyWebView()
    }
}

#Preview {
    PrivacyPolicyView()
}
struct PolicyWebView: UIViewRepresentable {
 
    let webView: WKWebView
    
    init() {
        webView = WKWebView(frame: .zero)
      
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        webView.load(URLRequest(url: URL(string: "https://tafatalk.co.ke/privacy")!))
    }
}
