//
//  LaunchDetailView.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 01/06/25.
//

import SwiftUI
import SafariServices

struct LaunchDetailView: View {
    let launch: LaunchEntity
    @State private var showSafari = false
    @State private var selectedURL: URL? = nil

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Details")
                    .font(.title2).bold()
                    .foregroundColor(Color(red: 0, green: 0.2, blue: 0.45))
                    .padding(.top)

                VStack(alignment: .leading, spacing: 8) {
                    Label("Date: \(formatDate(from: launch.launchDate))", systemImage: "calendar")
                    Label("Site: \(launch.siteNameLong)", systemImage: "mappin.and.ellipse")
                    Label("Rocket name: \(launch.rocketName)", systemImage: "paperplane")
                    Label("Rocket type: \(launch.rocketType)", systemImage: "gearshape")
                }
                .font(.subheadline)
                .foregroundColor(.gray)

                if !launch.flickrImages.isEmpty {
                    TabView {
                        ForEach(launch.flickrImages, id: \.self) { imageUrl in
                            if let url = URL(string: imageUrl) {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 200)
                                        .clipped()
                                        .cornerRadius(20)
                                        .padding(.horizontal)
                                } placeholder: {
                                    ZStack {
                                        Color.gray.opacity(0.1)
                                        ProgressView()
                                    }
                                    .frame(height: 200)
                                    .cornerRadius(20)
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .frame(height: 220)
                }

                if let details = launch.details {
                    Text(details)
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                }

                VStack {
                    if let videoLink = launch.videoLink,
                       let url = URL(string: videoLink) {
                        Link(destination: url) {
                            HStack {
                                Image(systemName: "play.circle.fill")
                                Spacer()
                                Text("YT Video")
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.pink)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }
                    }

                    if let articleLink = launch.articleLink {
                        Button(action: {
                            selectedURL = URL(string: articleLink)
                            showSafari = true
                        }) {
                            HStack {
                                Image(systemName: "info.circle.fill")
                                Spacer()
                                Text("Launch Info")
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0, green: 0.2, blue: 0.45))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle(launch.missionName)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showSafari) {
            if let url = selectedURL {
                SafariView(url: url)
            }
        }
    }

    func formatDate(from dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = formatter.date(from: dateString) else { return "Invalid date" }

        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "MMM d, h:mm a"
        displayFormatter.locale = Locale(identifier: "en_US")

        return displayFormatter.string(from: date)
    }
}
