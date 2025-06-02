//
//  LaunchListView.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 01/06/25.
//

// Lista de lanzamientos
//List of releases

import SwiftUI
import SwiftData

struct LaunchListView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = LaunchListViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading launches...")
                } else if let error = viewModel.error {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                } else {
                    List(viewModel.launches, id: \.id) { launch in
                        VStack(alignment: .leading) {
                            Text(launch.missionName)
                                .font(.headline)
                            Text(launch.siteName)
                                .font(.subheadline)
                            Text(formatDate(launch.launchDateUTC))
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Launches")
        }
        .onAppear {
            viewModel.loadLaunchesIfNeeded(modelContext: modelContext)
        }
    }

    private func formatDate(_ utcString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = formatter.date(from: utcString) {
            formatter.dateFormat = "dd-MM-yyyy"
            return formatter.string(from: date)
        }
        return utcString
    }
}
