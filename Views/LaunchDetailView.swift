//
//  LaunchDetailView.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 01/06/25.
//

import SwiftUI

struct LaunchDetailView: View {
    let launch: LaunchEntity

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let imageUrl = launch.imageUrl,
                   let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(12)
                        default:
                            ProgressView()
                        }
                    }
                }

                Text("🚀 \(launch.missionName)")
                    .font(.title)
                    .bold()

                Text("📍 Lugar de lanzamiento:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(launch.siteName)
                    .font(.body)

                Text("🗓 Fecha:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(launch.launchDateUTC)
                    .font(.body)

                if let video = launch.videoUrl,
                   let url = URL(string: video) {
                    Link("🎥 Ver video del lanzamiento", destination: url)
                        .padding(.top, 10)
                }
            }
            .padding()
        }
        .navigationTitle("Detalles")
        .navigationBarTitleDisplayMode(.inline)
    }
}
