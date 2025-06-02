//
//  LaunchListViewModel.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 01/06/25.
//

import Foundation
import SwiftData

@MainActor
class LaunchListViewModel: ObservableObject {
    @Published var launches: [LaunchEntity] = []
    @Published var isLoading = false
    @Published var error: String?

    func loadLaunchesIfNeeded(modelContext: ModelContext) {
        isLoading = true
        error = nil

        LaunchService.shared.fetchLaunchesIfNeeded(modelContext: modelContext) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    do {
                        let descriptor = FetchDescriptor<LaunchEntity>(sortBy: [.init(\.launchDateUTC, order: .reverse)])
                        self?.launches = try modelContext.fetch(descriptor)
                    } catch {
                        self?.error = "Failed to load saved launches"
                    }
                case .failure(let err):
                    self?.error = err.localizedDescription
                }
            }
        }
    }
}
