//
//  APIRequestValidator.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 01/06/25.
//

import SwiftUI

struct LaunchListView: View {
    @StateObject private var viewModel = LaunchListViewModel()

    var body: some View {
        NavigationView {
            VStack() {
                Text("Launches Past")
                    .font(.title)
                    .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                    .fontWeight(.bold)
                    .padding(.top, 16)
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Group {
                    if viewModel.isLoading {
                        Spacer()
                        ProgressView("Cargando lanzamientos...")
                        Spacer()
                    } else if let error = viewModel.errorMessage {
                        Spacer()
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                    } else {
                        List(viewModel.launches) { launch in
                            NavigationLink(destination: LaunchDetailView(launch: launch)) {
                                HStack(alignment: .center, spacing: 12) {
                                    AsyncImage(url: URL(string: launch.links.missionPatchSmall ?? "")) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 80, height: 80)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 60, height: 60)
                                    }

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(launch.missionName)
                                            .font(.headline)
                                            .padding(.vertical, 6)
                                        Text(launch.launchSite.siteName)
                                            .font(.subheadline)
                                            .padding(.vertical, 6)
                                            .foregroundColor(.gray)
                                        Text(formatDate(launch.launchDate))
                                            .font(.caption)
                                            .padding(.vertical, 6)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(.vertical, 6)
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Space X 🚀")
                       
                        .foregroundColor(.gray)
                        .bold()
                }
            }
        }
        .onAppear {
            viewModel.fetchLaunches()
        }
    }

    func formatDate(_ isoDate: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = isoFormatter.date(from: isoDate) ??
                         ISO8601DateFormatter().date(from: isoDate) else {
            return isoDate
        }

        let weekdayFormatter = DateFormatter()
        weekdayFormatter.locale = Locale(identifier: "es_ES")
        weekdayFormatter.dateFormat = "EEEE"

        let monthFormatter = DateFormatter()
        monthFormatter.locale = Locale(identifier: "es_ES")
        monthFormatter.dateFormat = "LLL"

        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "d"

        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"

        let weekday = weekdayFormatter.string(from: date).capitalized
        let month = monthFormatter.string(from: date).lowercased()
        let day = dayFormatter.string(from: date)
        let year = yearFormatter.string(from: date)

        return "\(weekday), \(month) \(day), \(year)"
    }
}

struct LaunchListView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchListView()
    }
}
