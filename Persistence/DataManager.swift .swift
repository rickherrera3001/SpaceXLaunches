//
//  DataManager.swift .swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 01/06/25.
//

//Centraliza la lógica de guardado, fetch, delete, etc.
//Centralizes the logic of saving, fetching, deleting, etc.

import Foundation
import SwiftData

class LaunchDataManager {
    static let shared = LaunchDataManager()
    private let lastFetchKey = "lastLaunchFetchDate5"
    
    private init() {}
    
    func shouldFetchData() -> Bool {
        guard let lastDate = UserDefaults.standard.object(forKey: lastFetchKey) as? Date else {
            return true
        }
        return !Calendar.current.isDateInToday(lastDate)
    }
    
    func updateFetchDate() {
        UserDefaults.standard.set(Date(), forKey: lastFetchKey)
    }
    
    func syncDataIfNeeded(modelContext: ModelContext, completion: @escaping (Result<[LaunchEntity], Error>) -> Void) {
        if shouldFetchData() {
            APIService.shared.fetchPastLaunches { result in
                switch result {
                case .success(let launches):
                    DispatchQueue.main.async {
                        do {
                            let oldData = try modelContext.fetch(FetchDescriptor<LaunchEntity>())
                            oldData.forEach { modelContext.delete($0) }
                            
                            for launch in launches {
                                let entity = LaunchEntity(from: launch)
                                modelContext.insert(entity)
                            }
                            
                            try modelContext.save()
                            try modelContext.save()
                            print("Datos guardados correctamente")
                            self.updateFetchDate()
                            
                            let updatedData = try modelContext.fetch(FetchDescriptor<LaunchEntity>())
                            print("Total en base local después del guardado: \(updatedData.count)")
                            completion(.success(updatedData))
                            
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            do {
                let cachedData = try modelContext.fetch(FetchDescriptor<LaunchEntity>())
                completion(.success(cachedData))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
