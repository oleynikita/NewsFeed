//
//  NewsItemView.swift
//  NewsFeed
//
//  Created by Mykyta Oliinyk on 12.07.2022.
//

import SwiftUI

struct NewsItemView: View {
    let item: ArticleItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Circle()
                    .frame(width: 30, height: 30)
                Text(item.author ?? "Author unknown")
                Spacer()
                Text(item.stringDate)
            }
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.title)
                    .foregroundColor(.primary)
                if let imageUrl = item.imageUrlObject {
                    AsyncImage(url: imageUrl, transaction: Transaction(animation: .easeInOut)) { phase in
                        if case .empty = phase {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color(UIColor.systemGray3).opacity(0.3))
                                .overlay(
                                    ProgressView()
                                )
                        }
                        if case .success(let image) = phase {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .transition(.opacity)
                        }
                    }
                }
                
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Text(item.content)
        }
        .padding()
        .background(Color.white)
    }
}

struct NewsItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewsItemView(item: .mock)
    }
}
