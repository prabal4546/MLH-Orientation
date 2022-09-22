//
//  ContentView.swift
//  OrientationHack
//
//  Created by Prabaljit Walia on 21/09/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Home()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            CanvasView()
                .tabItem {
                    Label("Canvas", systemImage: "pencil")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
