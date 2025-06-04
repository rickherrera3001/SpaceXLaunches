//
//  LaunchListViewModel.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 01/06/25.
//

import Foundation
import Combine
import SwiftData

class LaunchListViewModel: ObservableObject {
    @Published var launches: [LaunchEntity] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchLaunches() {
        isLoading = true
        errorMessage = nil
        
        LaunchDataManager.shared.syncDataIfNeeded(modelContext: modelContext) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let launches):
                    self?.launches = launches
                    print("✅ Launches fetched or loaded from cache: \(launches.count)")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("❌ Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
