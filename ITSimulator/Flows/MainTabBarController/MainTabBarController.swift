//
//  MainTabBarController.swift
//  ITSimulator
//
//  Created by Евгений Васильев on 21.11.2022.
//

import UIKit

final class MainTabBarController: UITabBarController {

    // MARK: - Constants

    private enum Constants {
        static let tabBarHeight: CGFloat = 67.0
    }

    // MARK: - Properties

    var customTabBar: MainTabBar?

    // MARK: - Private Properties

    let items: [TabItem] = [.newsAndGuidesIcon, .porfolio, .play, .collegsList, .settings]

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTabBar()
    }

    // MARK: - Methods

    func loadTabBar() {
        self.setupCustomTabMenu(items) { (controllers) in
            self.viewControllers = controllers
        }
        self.selectedIndex = 0
    }

    func setupCustomTabMenu(_ menuItems: [TabItem], completion: @escaping ([UIViewController]) -> Void) {
        let frame = tabBar.frame
        var controllers = [UIViewController]()
        customTabBar = MainTabBar(menuItems: items, frame: frame)

        guard let customTabBar = customTabBar else { return }

        tabBar.isHidden = true

        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.clipsToBounds = true
        customTabBar.itemTapped = changeTab

        view.addSubview(customTabBar)

        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor
                .constraint(equalTo: tabBar.leadingAnchor),
            customTabBar.trailingAnchor
                .constraint(equalTo: tabBar.trailingAnchor),
            customTabBar.widthAnchor
                .constraint(equalToConstant: tabBar.frame.width),
            customTabBar.heightAnchor
                .constraint(equalToConstant: Constants.tabBarHeight),
            customTabBar.bottomAnchor
                .constraint(equalTo: tabBar.bottomAnchor)
        ])

        for i in 0 ..< items.count {
            controllers.append(items[i].viewController)
        }

        view.layoutIfNeeded()
        completion(controllers)
    }

    func changeTab(tab: Int) {
        self.selectedIndex = tab
    }

}
