//
//  ContentView.swift
//  AppleTVNews
//
//  Created by Sraavan Chevireddy on 05/02/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var contentDownloader = ContentDownloader()
    
    var body: some View {
        NavigationStack {
            LazyVStack {
                LazyHStack {
                    ScrollView {
                        AsyncImage(url: URL(string: "https://is5-ssl.mzstatic.com/image/thumb/Music116/v4/9c/d3/44/9cd34457-1d8e-4d37-ca49-008aa083d652/859770181552_cover.jpg/100x100bb.jpg")) { downloadedImage in
                            downloadedImage
                                .resizable()
                                .frame(width: 130, height: 130)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                        } placeholder: {
                            Image(systemName: "gamecontroller.fill")
                                .resizable()
                                .frame(width: 130, height: 130)
                                .foregroundColor(.secondary)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                        }
                    }

                }
                
                LazyVGrid(columns: [GridItem(.flexible()),
                                    GridItem(.flexible())
                                    ,GridItem(.flexible()),GridItem(.flexible())]) {
                    ForEach(0..<100) { _ in
                        Text("HELLO WORLD")
                    }
                }
            }.padding()
                .navigationTitle("Games")
        }.task {
            print("Task Called")
            try? await contentDownloader.downloadContent()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
