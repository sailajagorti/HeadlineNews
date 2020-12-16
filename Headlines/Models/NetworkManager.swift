//
//  NetworkManager.swift
//  Headlines
//
//  Created by Sailaja Gorti on 12/16/20.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var articles = [Article]()
    var country: String = "us"
    
    
    func fetchArticles(country: String) {
        
        if let urlString = URL(string: "https://newsapi.org/v2/top-headlines?country=\(country)&apiKey=\(Constants.API_KEY)") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlString) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let returnedFeed = try decoder.decode(NewsFeed.self, from: safeData)
                            DispatchQueue.main.sync {
                                self.articles = returnedFeed.articles
                            }
                            
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
