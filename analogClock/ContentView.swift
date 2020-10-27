//
//  ContentView.swift
//  analogClock
//
//  Created by Cloutier, Vincent on 2020-10-27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    var body: some View {
        VStack{
            HStack{
                Text("Analog Clock")
                    .font(.title)
                    .fontWeight(.heavy)
            }
        }
    }
}
