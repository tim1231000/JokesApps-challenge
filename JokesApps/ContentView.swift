//
//  ContentView.swift
//  JokesApps
//
//  Created by 최욱진 on 9/8/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var jokeText = "Click Button"
    
    var body: some View {
        
        VStack {
            Text("Random Joke!")
                .font(.largeTitle)
                .bold()
                .padding()
            
            Spacer()
            Text(jokeText)
                .padding()
                .frame(maxWidth: 400)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.orange)
                        .opacity(0.4)
                )
            
            Spacer()
            Button {
                getRandomJoke()
            } label: {
                Text("Get Random Joke")
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.blue)
                            .opacity(0.4)
                    )
            }
            .foregroundColor(.black)

        }
        .padding()
    }
    
    func getRandomJoke() {
        
        Task {
            if let url = URL(string: "https://v2.jokeapi.dev/joke/Any") {
                
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    
                    let decoder = JSONDecoder()
                    let joke = try decoder.decode(JokeResponse.self, from: data)
                    
                    jokeText = joke.joke
                }
                catch {
                    print(error)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
