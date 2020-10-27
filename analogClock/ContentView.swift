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
    @State var current_Time = Time(min: 0, sec: 0, hour: 0)
    @State var receiver = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    
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
                // Seconds hand
                
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 2, height: (width - 180) / 2)
                    .offset(y: -(width - 180) / 4)
                    .rotationEffect(.init(degrees: Double(current_Time.sec) * 6))
                
                // Minute hand
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 4, height: (width - 200) / 2)
                    .offset(y: -(width - 200) / 4)
                    .rotationEffect(.init(degrees: Double(current_Time.min) * 6))
                
                // Hour hand
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 4.5, height: (width - 240) / 2)
                    .offset(y: -(width - 240) / 4)
                    .rotationEffect(.init(degrees: (Double(current_Time.hour) + (Double(current_Time.min) / 60)) * 30))
                
                // Center Circle
                Circle()
                    .fill(Color.primary)
                    .frame(width: 15, height: 15)
            }
            .frame(width: width - 80, height: width - 80)
            
            Spacer(minLength: 0)
            
        }
        .onAppear(perform: {
                    
                    let calender = Calendar.current
                    
                    let min = calender.component(.minute, from: Date())
                    let sec = calender.component(.second, from: Date())
                    let hour = calender.component(.hour, from: Date())
                    
                    withAnimation(Animation.linear(duration: 0.01)){
                        
                        self.current_Time = Time(min: min, sec: sec, hour: hour)
                    }
                })
        .onReceive(receiver) { (_) in
            
            let calender = Calendar.current
            
            let min = calender.component(.minute, from: Date())
            let sec = calender.component(.second, from: Date())
            let hour = calender.component(.hour, from: Date())
            
            withAnimation(Animation.linear(duration: 0.01)){
                
                self.current_Time = Time(min: min, sec: sec, hour: hour)
            }
        }
    }
}
    // Calculating time
    
    struct Time {
        var min : Int
        var sec : Int
        var hour : Int
    }
