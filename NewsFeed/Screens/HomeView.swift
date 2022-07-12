//
//  HomeView.swift
//  NewsFeed
//
//  Created by Mykyta Oliinyk on 11.07.2022.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    @ObservedObject private var viewStore: ViewStore<HomeNewsState, HomeNewsAction>
    
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
                    
                    if viewStore.emptyResults {
                        VStack {
                            Image(systemName: "eyeglasses")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200, alignment: .center)
                            Text("Sorry, we coudn't find anything. Let's try something like \"Apple\"")
                                .padding()
                        }
                        .background(Color.white)
                    } else {
                        ScrollView {
                            LazyVStack {
                                ForEach(viewStore.articles, id: \.self) { article in
                                    NavigationLink {
                                        ArticleView(url: article.urlObject)
                                    } label: {
                                        NewsItemView(item: article)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("News Home")
            .background(Color(UIColor.systemGray5))
            .searchable(text: searchQuery)
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
    
    private var searchQuery: Binding<String> {
        Binding(
            get: { viewStore.state.searchQuery },
            set: { viewStore.send(.onSearchEdit($0)) }
        )
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
                    .mock
                ]
            ),
            reducer: homeReducer,
            environment: .init(client: NewsClientMock()))
    }
}
