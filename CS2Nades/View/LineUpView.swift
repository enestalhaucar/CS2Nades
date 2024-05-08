//
//  LineUpView.swift
//  CS2Nades
//
//  Created by Enes Talha Uçar  on 8.05.2024.
//

import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    var url : URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct LineUpView: View {
    @State private var showWebView = false
    let urlString : String
    var body: some View {
        VStack {
            WebView(url: URL(string: urlString) ?? URL(string: "https://www.google.com/")!)
        }
    }
}

#Preview {
    LineUpView(urlString: "https://www.google.com/")
}
