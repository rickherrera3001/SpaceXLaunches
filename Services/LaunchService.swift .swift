//
//  LaunchService.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 01/06/25.
//

import Foundation
import Alamofire
import SwiftData


class LaunchService {
    static let shared = LaunchService()
    
    private init() {}

    private let url = "https://api.spacexdata.com/v3/launches/past"

    func fetchLaunchesIfNeeded(modelContext: ModelContext, completion: @escaping (Result<[LaunchEntity], Error>) -> Void) {
        guard APIRequestValidator.shouldFetchData() else {
            print("✅ Los datos ya fueron cargados hoy")
            completion(.success([])) // Puedes cargar desde SwiftData si lo deseas
            return
        }

        AF.request(url).responseDecodable(of: [LaunchModel].self) { response in
            switch response.result {
            case .success(let launches):
                // Mapea y guarda
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

                for entity in entities {
                    modelContext.insert(entity)
                }
                APIRequestValidator.markAPICallDone()

                completion(.success(entities))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
