//
//  SafariView.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 02/06/25.
//

import SafariServices
import SwiftUI

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}
