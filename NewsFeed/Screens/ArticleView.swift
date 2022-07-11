//
//  ArticleView.swift
//  NewsFeed
//
//  Created by Mykyta Oliinyk on 12.07.2022.
//

import SwiftUI

struct ArticleView: View {
    let url: URL
    
    var body: some View {
        WebView(url: url)
    }
}

