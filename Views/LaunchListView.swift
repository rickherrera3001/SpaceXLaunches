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
    @Query(sort: \LaunchEntity.launchDateUTC, order: .reverse) private var launches: [LaunchEntity]

    var body: some View {
        NavigationStack {
            List(launches) { launch in
                NavigationLink(destination: LaunchDetailView(launch: launch)) {
                    HStack {
                        if let imageUrl = launch.imageUrl,
                           let url = URL(string: imageUrl) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                default:
                                    ProgressView()
                                }
                            }
                        } else {
                            Image(systemName: "photo")
                                .frame(width: 60, height: 60)
                                .foregroundColor(.gray)
                        }

                        VStack(alignment: .leading) {
                            Text(launch.missionName)
                                .font(.headline)
                            Text(launch.siteName)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Lanzamientos SpaceX")
        }
    }
}
