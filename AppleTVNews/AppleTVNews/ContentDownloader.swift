//
//  ContentDownloader.swift
//  AppleTVNews
//
//  Created by Sraavan Chevireddy on 05/02/23.
//

import Foundation
import Combine

class ContentDownloader: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    @Published var feed: Feed!
    
    init(){
        
    }
    
    func downloadContent() async throws {
        URLSession.shared
            .dataTaskPublisher(for: URL(string: "https://rss.applemarketingtools.com/api/v2/in/music/most-played/50/albums.json")!)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: Feed.self, decoder: JSONDecoder())
            .sink { result in
                switch result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .finished:
                    print("You successfully got result!")
                }
            } receiveValue: { jsonFeed  in
                self.feed = jsonFeed
            }.store(in: &cancellables)
    }
}
