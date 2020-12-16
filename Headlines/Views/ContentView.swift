//
//  ContentView.swift
//  Headlines
//
//  Created by Sailaja Gorti on 12/16/20.
//

import SwiftUI

struct ContentView: View {
    
   @ObservedObject var networkManager = NetworkManager()
    @State var selectedCountry = "us"
    @State var usaSelected = true
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("USA")
                        .font(.headline)
                        .frame(width: 100, height: 40, alignment: .center)
                        .background(usaSelected ? Color.green : Color.gray)
                        .clipShape(Capsule())
                        .onTapGesture {
                            usaSelected = true
                            networkManager.fetchArticles(country: "us")
                        }
                    Text("India")
                        .font(.headline)
                        .frame(width: 100, height: 40, alignment: .center)
                        .background(usaSelected ? Color.gray : Color.green)
                        .clipShape(Capsule())
                        .onTapGesture {
                            usaSelected = false
                            networkManager.fetchArticles(country: "in")
                        }
                }
            List(networkManager.articles) { article in
                NavigationLink(destination: DetailView(url: article.url)) {
                    HStack {
                        RemoteImage(url: article.urlToImage ?? "")
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        VStack {
                            Text(article.title ?? "No content available")
                            Text(article.author ?? "")
                                .font(.caption)
                        }
                    }
                }
            }
            }
            .onAppear(perform: {
                networkManager.fetchArticles(country: usaSelected ? "us" : "in")
            })
            .navigationTitle("Headline News")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
