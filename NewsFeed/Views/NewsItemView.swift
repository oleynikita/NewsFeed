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
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
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
