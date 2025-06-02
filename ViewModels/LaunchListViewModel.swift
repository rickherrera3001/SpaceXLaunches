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
    @Published var launches: [RocketElement] = []
    @Published var isLoading = false
    @Published var error: String?

    func loadLaunchesIfNeeded(modelContext: ModelContext) {
        isLoading = true
        error = nil

        LaunchService.shared.fetchLaunchesIfNeeded(modelContext: modelContext) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success:
                self.isLoading = false

                do {
                    let descriptor = FetchDescriptor<LaunchEntity>(
                        sortBy: [.init(\.launchDateUTC, order: .reverse)]
                    )
                    let savedEntities = try modelContext.fetch(descriptor)

                    self.launches = savedEntities.map { entity in
                        RocketElement(
                            flightNumber: entity.id,
                            missionName: entity.missionName,
                            missionID: [],
                            upcoming: false,
                            launchYear: "",
                            launchDateUnix: 0,
                            launchDateUTC: entity.launchDateUTC,
                            launchDateLocal: Date(),
                            isTentative: false,
                            tentativeMaxPrecision: .hour,
                            tbd: false,
                            launchWindow: nil,
                            rocket: RocketRocket(
                                rocketID: .falcon9,
                                rocketName: .falcon9,
                                rocketType: .ft,
                                firstStage: FirstStage(cores: []),
                                secondStage: SecondStage(block: nil, payloads: []),
                                fairings: nil
                            ),
                            ships: [],
                            telemetry: Telemetry(flightClub: nil),
                            launchSite: LaunchSite(
                                siteID: .ccafsSlc40,
                                siteName: .ccafsSlc40,
                                siteNameLong: .capeCanaveralAirForceStationSpaceLaunchComplex40
                            ),
                            launchSuccess: true,
                            launchFailureDetails: nil,
                            links: Links(
                                missionPatch: entity.missionPatch,
                                missionPatchSmall: nil,
                                redditCampaign: nil,
                                redditLaunch: nil,
                                redditRecovery: nil,
                                redditMedia: nil,
                                presskit: nil,
                                articleLink: nil,
                                wikipedia: nil,
                                videoLink: "",
                                youtubeID: "",
                                flickrImages: []
                            ),
                            details: entity.details,
                            staticFireDateUTC: nil,
                            staticFireDateUnix: nil,
                            timeline: nil,
                            lastDateUpdate: nil,
                            lastLlLaunchDate: nil,
                            lastLlUpdate: nil,
                            lastWikiLaunchDate: nil,
                            lastWikiRevision: nil,
                            lastWikiUpdate: nil,
                            launchDateSource: nil
                        )
                    }

                } catch {
                    self.error = "Failed to load saved launches"
                }

            case .failure(let err):
                self.isLoading = false
                self.error = err.localizedDescription
            }
        }
    }
}
