//
//  LaunchEntity.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 01/06/25.
//

import Foundation
import SwiftData

@Model
class LaunchEntity {
    @Attribute(.unique) var id: Int               // Equivale a flightNumber
    var missionName: String
    var siteName: String
    var launchDateUTC: String
    var imageUrl: String?
    var videoUrl: String?
    
    // NUEVOS CAMPOS PARA MAPEO COMPLETO
    var missionPatch: String?                     // Para mostrar el parche de misión
    var details: String?                          // Para mostrar la descripción del lanzamiento

    init(
        id: Int,
        missionName: String,
        siteName: String,
        launchDateUTC: String,
        imageUrl: String? = nil,
        videoUrl: String? = nil,
        missionPatch: String? = nil,
        details: String? = nil
    ) {
        self.id = id
        self.missionName = missionName
        self.siteName = siteName
        self.launchDateUTC = launchDateUTC
        self.imageUrl = imageUrl
        self.videoUrl = videoUrl
        self.missionPatch = missionPatch
        self.details = details
    }
}
