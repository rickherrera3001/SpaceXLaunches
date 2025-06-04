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
    @Attribute(.unique) var id: Int
    var missionName: String
    var launchDate: String
    var details: String?
    
    var rocketName: String
    var rocketType: String
    
    var siteName: String
    var siteNameLong: String

    var missionPatch: String?
    var missionPatchSmall: String?
    var flickrImages: [String]
    var youtubeID: String?
    var videoLink: String?
    var wikipedia: String?
    var articleLink: String?
    var presskit: String?

    init(from model: LaunchModel) {
        self.id = model.id
        self.missionName = model.missionName
        self.launchDate = model.launchDate
        self.details = model.details
        self.rocketName = model.rocket.rocketName
        self.rocketType = model.rocket.rocketType
        self.siteName = model.launchSite.siteName
        self.siteNameLong = model.launchSite.siteNameLong
        self.missionPatch = model.links.missionPatch
        self.missionPatchSmall = model.links.missionPatchSmall
        self.flickrImages = model.links.flickrImages
        self.youtubeID = model.links.youtubeID
        self.videoLink = model.links.videoLink
        self.wikipedia = model.links.wikipedia
        self.articleLink = model.links.articleLink
        self.presskit = model.links.presskit
    }
}
