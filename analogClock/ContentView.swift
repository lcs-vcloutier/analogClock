//
//  ContentView.swift
//  analogClock
//
//  Created by Cloutier, Vincent on 2020-10-27.
//

import SwiftUI

struct ContentView: View {
    @State var isDark = false
    var body: some View {
        NavigationView {
            Home(isDark: $isDark)
                .navigationBarHidden(true)
                .preferredColorScheme(isDark ? .dark : .light)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    @Binding var isDark : Bool
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            // Top Bar & color button
            HStack {
                Text("Analog Clock")
                    .font(.title)
                    .fontWeight(.heavy)
                Spacer(minLength: 0)
                
                Button(action: {isDark.toggle()}) {
                    
                    Image(systemName: isDark ? "sun.min.fill" : "moon.fill")
                        .font(.system(size: 22))
                        .foregroundColor(isDark ? .black : .white)
                        .padding()
                        .background(Color.primary)
                        .clipShape(Circle())
                }
            }
            .padding()
            
            Spacer(minLength: 0)
            
            ZStack {
                
                Circle()
                    .fill(Color("Color").opacity(0.1))
                
                //Minutes and Seconds Markers
                ForEach(0..<60,id: \.self){i in
                    
                    Rectangle()
                        .fill(Color.primary)
                        // 60/12 = 5
                        .frame(width: 2, height: (i % 5) == 0 ? 15 : 5)
                        .offset(y: (width - 110) / 2)
                        .rotationEffect(.init(degrees: Double(i) * 6))
                }
            }
            .frame(width: width - 80, height: width - 80)
            
            Spacer(minLength: 0)
            
        }
    }
}
