    //
    //  LaunchService.swift
    //  SpaceXLaunches
    //
    //  Created by Ricardo Ivan Herrera Rocha on 01/06/25.
    //


//
//  LaunchService.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 01/06/25.
//

import Foundation
import SwiftData

class LaunchService {
    static let shared = LaunchService()
    
    private init() {}

    func fetchLaunchesIfNeeded(modelContext: ModelContext, completion: @escaping (Result<[LaunchEntity], Error>) -> Void) {
        
        // 🔄 Llama a la nueva APIService
        APIService.shared.fetchPastLaunches { result in
            switch result {
            case .success(let launches):
                // 🧠 Mapea los datos a entidades locales
                let entities = launches.map {
                    LaunchEntity(
                        id: $0.id,
                        missionName: $0.missionName,
                        siteName: $0.launchSite.siteName,
                        launchDateUTC: $0.launchDate,
                        imageUrl: $0.links.flickrImages.first,
                        videoUrl: $0.links.videoLink
                    )
                }

                // 💾 Guarda en SwiftData
                for entity in entities {
                    modelContext.insert(entity)
                }

                completion(.success(entities))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
