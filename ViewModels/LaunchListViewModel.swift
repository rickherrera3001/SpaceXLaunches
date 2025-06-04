//
//  LaunchListViewModel.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 01/06/25.
//

import Foundation
import Combine

class LaunchListViewModel: ObservableObject {
    @Published var launches: [LaunchModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private var cancellables = Set<AnyCancellable>()

    func fetchLaunches() {
        isLoading = true
        errorMessage = nil

        APIService.shared.fetchPastLaunches { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let launches):
                    self?.launches = launches
                    print("\u{2705} Fetched \(launches.count) launches")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("\u{274C} Error fetching launches: \(error.localizedDescription)")
                }
            }
        }
    }
}
