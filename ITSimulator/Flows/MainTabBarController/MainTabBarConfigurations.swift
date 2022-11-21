//
//  MainTabBarConfigurations.swift
//  ITSimulator
//
//  Created by Евгений Васильев on 21.11.2022.
//

import UIKit

enum TabItem: CaseIterable {

    case newsAndGuidesIcon
    case collegsList
    case play
    case porfolio
    case settings

    // MARK: - Typealias

    typealias Titles = L10n.MainTabBar.Titles

    // MARK: - Properties

    var viewController: UIViewController {
        switch self {
        case .newsAndGuidesIcon:
            return UIViewController()
        case .collegsList:
            return UIViewController()
        case .play:
            return UIViewController()
        case .porfolio:
            return UIViewController()
        case .settings:
            return UIViewController()
        }
    }

    var icon: UIImage {
        switch self {
        case .newsAndGuidesIcon:
            return Resources.Assets.newsAndGuidesIcon.image
        case .collegsList:
            return Resources.Assets.collegsList.image
        case .play:
            return Resources.Assets.play.image
        case .porfolio:
            return Resources.Assets.porfolio.image
        case .settings:
            return Resources.Assets.settings.image
        }
    }

    var displayTitle: String {
        switch self {
        case .newsAndGuidesIcon:
            return Titles.newsAndGuides
        case .collegsList:
            return Titles.collegsList
        case .play:
            return Titles.play
        case .porfolio:
            return Titles.porfolio
        case .settings:
            return Titles.settings
        }
    }
}
