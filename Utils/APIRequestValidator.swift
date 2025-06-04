//
//  APIRequestValidator.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 01/06/25.
//


import Foundation
import Alamofire

class APIService {
    static let shared = APIService()
    private init() {}

    func fetchPastLaunches(completion: @escaping (Result<[LaunchModel], Error>) -> Void) {
        let url = "https://api.spacexdata.com/v3/launches/past"
        
        AF.request(url).validate().responseDecodable(of: [LaunchModel].self) { response in
            switch response.result {
            case .success(let launches):
                completion(.success(launches))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
