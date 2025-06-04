//
//  ContentView.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 01/06/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        LoginView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: LaunchEntity.self, inMemory: true)
} 
