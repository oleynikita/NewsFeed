//
//  WebView.swift
//  NewsFeed
//
//  Created by Mykyta Oliinyk on 12.07.2022.
//

import SwiftUI
import WebKit
import Combine

struct WebView: UIViewRepresentable {

    let url: URL
    
    init(url: URL) {
        self.url = url
    }
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: URL(string: "https://apple.com")!)
    }
}
