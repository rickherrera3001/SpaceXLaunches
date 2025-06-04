//
//  Launch.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 01/06/25.
//

import Foundation

struct LaunchModel: Identifiable, Codable {
    let id: Int
    let missionName: String
    let launchDate: String
    let launchSite: LaunchSite
    let links: LaunchLinks
    let rocket: Rocket
    let details: String?

    enum CodingKeys: String, CodingKey {
        case id = "flight_number"
        case missionName = "mission_name"
        case launchDate = "launch_date_utc"
        case launchSite = "launch_site"
        case links = "links"
        case rocket
        case details
    }
}

struct Rocket: Codable {
    let rocketName: String
    let rocketType: String

    enum CodingKeys: String, CodingKey {
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
    }
}


struct LaunchSite: Codable {
    let siteName: String
    let siteNameLong: String

    enum CodingKeys: String, CodingKey {
        case siteName = "site_name"
        case siteNameLong = "site_name_long"
    }
}

struct LaunchLinks: Codable {
    let missionPatch: String?
    let missionPatchSmall: String?
    let flickrImages: [String]
    let youtubeID: String?
    let videoLink: String?
    let wikipedia: String?
    let articleLink: String?
    let presskit: String?

    enum CodingKeys: String, CodingKey {
        case missionPatch = "mission_patch"
        case missionPatchSmall = "mission_patch_small"
        case flickrImages = "flickr_images"
        case youtubeID = "youtube_id"
        case videoLink = "video_link"
        case wikipedia
        case articleLink = "article_link"
        case presskit
    }
}
