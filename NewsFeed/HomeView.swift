//
//  HomeView.swift
//  NewsFeed
//
//  Created by Mykyta Oliinyk on 11.07.2022.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    
    @ObservedObject
    private var viewStore: ViewStore<HomeNewsState, HomeNewsAction>

    @Environment(\.scenePhase)
    private var scenePhase
    
    init(store: Store<HomeNewsState, HomeNewsAction>) {
        self.viewStore = ViewStore(store)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    if viewStore.isLoading {
                        ProgressView()
                    }
                    ScrollView {
                        LazyVStack {
                            ForEach(viewStore.articles, id: \.self) { article in
                                NavigationLink {
                                    ArticleDetailView(url: article.urlObject)
                                } label: {
                                    NewsItemView(item: article)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
            }
            .navigationTitle("News Home")
            .background(Color(UIColor.systemGray5))
            .searchable(text: searchQuerry)
            .onSubmit(of: .search) {
                viewStore.send(.onSearchSend)
            }
        }
        .onAppear(perform: { viewStore.send(.onAppear) })
        .onChange(of: scenePhase) { newValue in
            if case .active = newValue {
                viewStore.send(.onAppear)
            }
        }
    }
    
    private var searchQuerry: Binding<String> {
        Binding(
            get: { viewStore.state.searchQuerry },
            set: { viewStore.send(.onSearchEdit($0)) }
        )
    }
}

struct NewsItemView: View {
    let item: ArticleItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Circle()
                    .frame(width: 50, height: 50)
                Text(item.author ?? "Author unknown")
                Spacer()
                Text(item.stringDate)
            }
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.title)
                    .foregroundColor(.primary)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(store: .mock)
    }
}

extension Store where State == HomeNewsState, Action == HomeNewsAction {
    static var mock: Store<HomeNewsState, HomeNewsAction> {
        Store(
            initialState: .init(
                articles: [
                    ArticleItem(
                        author: "Tim Cook",
                        title: "WWDC22",
                        description: "One More Thing",
                        url: "apple.com",
                        urlToImage: "apple.com",
                        publishedAt: Date(),
                        content: "Welcome to WWDC 22"
                    )
                ]
            ),
            reducer: homeReducer,
            environment: .init(client: NewsClientMock()))
    }
}
