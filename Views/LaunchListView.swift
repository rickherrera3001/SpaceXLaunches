//
//  APIRequestValidator.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 01/06/25.
//

import SwiftUI
import SwiftData

struct LaunchListView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: LaunchListViewModel
    
    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: LaunchListViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                header
                Group {
                    contentView()
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
    
    private var header: some View {
        Text("Launches Past")
            .font(.title)
            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
            .fontWeight(.bold)
            .padding(.top, 16)
            .padding(.leading, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func contentView() -> some View {
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
                    LaunchRowView(launch: launch)
                }
            }
            .listStyle(PlainListStyle())
        }
    }
    
    struct LaunchRowView: View {
        let launch: LaunchEntity
        
        var body: some View {
            HStack(alignment: .center, spacing: 12) {
                AsyncImage(url: URL(string: launch.missionPatchSmall ?? "")) { image in
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
                    Text(launch.siteName)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(launch.launchDate.formattedAsSpanishDate())
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 6)
        }
    }
}
