//
//  LaunchDetailView.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 01/06/25.
//

// Detalle del lanzamiento
// Release details

import Foundation
import SwiftUI

struct LaunchDetailView: View {
    let launch: RocketElement

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Imagen principal
                if let urlString = launch.links.missionPatch, let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(12)
                    } placeholder: {
                        ProgressView()
                    }
                }

                Text(launch.missionName)
                    .font(.title)
                    .bold()

                Text("Site: \(launch.launchSite.siteNameLong.rawValue)")
                    .font(.subheadline)

                Text("Date: \(launch.launchDateUTC)")
                    .font(.subheadline)

                if let details = launch.details {
                    Text(details)
                        .padding(.top, 8)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
