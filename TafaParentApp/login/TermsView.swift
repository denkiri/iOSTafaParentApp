//
//  TermsView.swift
//  TafaParentApp
//
//  Created by Macbook Pro on 03/07/2024.
//

import SwiftUI
import WebKit
struct TermsView: View {
    var body: some View {
        WebView()
    }
}

#Preview {
    TermsView()
}
struct WebView: UIViewRepresentable {
 
    let webView: WKWebView
    
    init() {
        webView = WKWebView(frame: .zero)
      
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        webView.load(URLRequest(url: URL(string: "https://tafatalk.co.ke/terms-and-condition")!))
    }
}
