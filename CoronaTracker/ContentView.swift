//
//  ContentView.swift
//  CoronaTracker
//
//  Created by Lucas Stettner on 3/6/20.
//  Copyright © 2020 Lucas Stettner. All rights reserved.
//

import SwiftUI
import MapKit

let screen = UIScreen.main.bounds

struct ContentView: View {
    @State var showFull = false
    @State var selectedPoint: MKAnnotation?
    
    var body: some View {
        TabView {
            ZStack(alignment: .bottom) {
                MapView(selectedAnnotation: $selectedPoint)
                    .edgesIgnoringSafeArea(.all)
                
                Color.black
                    .opacity(showFull ? 0.4 : 0)
                    .animation(.default)
                
                CardView(showFull: $showFull, selectedPoint: $selectedPoint)

            }
            .tabItem {
                Image(systemName: "map")
                    .frame(width: 65, height: 65)
                Text("Map")
            }
            
            InfoView()
                .tabItem {
                    Image(systemName: "info.circle")
                        .frame(width: 65, height: 65)
                    Text("Info")
                }
            
            Text("Messages")
            .tabItem {
                Image(systemName: "message")
                    .frame(width: 65, height: 65)
                Text("Chat")
            }
            .disabled(true)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .colorScheme(.dark)
    }
}
