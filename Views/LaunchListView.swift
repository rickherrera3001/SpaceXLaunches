//
//  LaunchListView.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 01/06/25.
//

import SwiftUI
import SwiftData

struct LaunchListView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = LaunchListViewModel()

    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView("Cargando lanzamientos...")
                    .navigationTitle("Launches")
            } else if let error = viewModel.error {
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .navigationTitle("Launches")
            } else {
                List(viewModel.launches) { launch in
                    HStack(alignment: .top, spacing: 12) {
                        // Imagen del parche de misión
                        if let patchUrl = launch.links.missionPatch,
                           let url = URL(string: patchUrl) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 60, height: 60)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(8)
                                case .failure:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.gray)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text(launch.missionName)
                                .font(.headline)
                            Text(launch.launchSite.siteName.rawValue)
                                .font(.subheadline)
                            Text(formatDate(launch.launchDateUTC))
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemBackground))
                            .shadow(radius: 1)
                    )
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Launches")
            }
        }
        .onAppear {
            viewModel.loadLaunchesIfNeeded(modelContext: modelContext)
        }
    }

    // 🗓️ Formatea fecha tipo: lunes, ene. 6, 2014
    private func formatDate(_ utcString: String) -> String {
        let inputFormatter = ISO8601DateFormatter()
        inputFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "es_MX")
        outputFormatter.dateFormat = "EEEE, MMM. d, yyyy"

        if let date = inputFormatter.date(from: utcString) {
            return outputFormatter.string(from: date).capitalized
        }
        return "Fecha desconocida"
    }
}
