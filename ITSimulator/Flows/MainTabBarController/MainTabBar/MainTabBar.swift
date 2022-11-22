//
//  MainTabBar.swift
//  ITSimulator
//
//  Created by Евгений Васильев on 21.11.2022.
//

import UIKit

final class MainTabBar: UIView {

    // MARK: - Constants

    private enum Constants {
        static let imageIconHeight: CGFloat = 25
        static let imageIconWeidth: CGFloat = 25
        static let imageTopAnchor: CGFloat = 8
        static let imageLeadingAnchor: CGFloat = 35
        static let imageLabelHeightAnchor: CGFloat = 13
        static let imageLabelTopAnchor: CGFloat = 4
        static let borderMinusConstant: CGFloat = 20
        static let borderHeight: CGFloat = 2
        static let borderXPosition: CGFloat = 10
        static let animationActiveDuration = 0.8
        static let animationDeactiveDuration = 0.4
    }

    // MARK: - Properties

    var itemTapped: ((_ tab: Int) -> Void)?
    var activeItem: Int = 0

    // MARK: - UIView

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    // MARK: - Initialization

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    convenience init(menuItems: [TabItem], frame: CGRect) {
        self.init(frame: frame)
        self.layer.backgroundColor = UIColor.white.cgColor
        for i in 0 ..< menuItems.count {
            let itemWidth = self.frame.width / CGFloat(menuItems.count)
            let leadingAnchor = itemWidth * CGFloat(i)

            let itemView = self.createTabItem(item: menuItems[i])
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.clipsToBounds = true
            itemView.tag = i
            self.addSubview(itemView)
            NSLayoutConstraint.activate([
                itemView.heightAnchor.constraint(equalTo: self.heightAnchor),
                itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchor),
                itemView.topAnchor.constraint(equalTo: self.topAnchor)
            ])
        }
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.activateTab(tab: 0) // activate the first tab
    }

    // MARK: - Methods

    func createTabItem(item: TabItem) -> UIView {
        let tabBarItem = UIView(frame: CGRect.zero)
        let itemTitleLabel = UILabel(frame: CGRect.zero)
        let itemIconView = UIImageView(frame: CGRect.zero)

        itemTitleLabel.text = item.displayTitle
        itemTitleLabel.textAlignment = .center
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTitleLabel.clipsToBounds = true

        itemIconView.image = item.icon.withRenderingMode(.automatic)
        itemIconView.translatesAutoresizingMaskIntoConstraints = false
        itemIconView.clipsToBounds = true

        tabBarItem.layer.backgroundColor = UIColor.white.cgColor
        tabBarItem.addSubview(itemIconView)
        tabBarItem.addSubview(itemTitleLabel)
        tabBarItem.translatesAutoresizingMaskIntoConstraints = false
        tabBarItem.clipsToBounds = true

        NSLayoutConstraint.activate([
            itemIconView.heightAnchor
                .constraint(equalToConstant: Constants.imageIconHeight),
            itemIconView.widthAnchor
                .constraint(equalToConstant: Constants.imageIconHeight),
            itemIconView.centerXAnchor
                .constraint(equalTo: tabBarItem.centerXAnchor),
            itemIconView.topAnchor
                .constraint(equalTo: tabBarItem.topAnchor, constant: Constants.imageTopAnchor),
            itemIconView.leadingAnchor
                .constraint(equalTo: tabBarItem.leadingAnchor, constant: Constants.imageLeadingAnchor),
            itemTitleLabel.heightAnchor
                .constraint(equalToConstant: Constants.imageLabelHeightAnchor),
            itemTitleLabel.widthAnchor
                .constraint(equalTo: tabBarItem.widthAnchor),
            itemTitleLabel.topAnchor
                .constraint(equalTo: itemIconView.bottomAnchor, constant: Constants.imageLabelTopAnchor)
        ])

        tabBarItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)))
        return tabBarItem
    }

    func switchTab(from: Int, to: Int) {
        self.deactivateTab(tab: from)
        self.activateTab(tab: to)
    }

    func activateTab(tab: Int) {
        let tabToActivate = self.subviews[tab]
        let borderWidth = tabToActivate.frame.size.width - Constants.borderMinusConstant
        let borderLayer = CALayer()
        borderLayer.backgroundColor = UIColor.green.cgColor
        borderLayer.name = "active border"
        borderLayer.frame = CGRect(
            x: Constants.borderXPosition,
            y: .zero,
            width: borderWidth,
            height: Constants.borderHeight
        )
        DispatchQueue.main.async {
            UIView.animate(
                withDuration: Constants.animationActiveDuration,
                delay: .zero,
                options: [.curveEaseIn, .allowUserInteraction],
                animations: {
                    tabToActivate.layer.addSublayer(borderLayer)
                    tabToActivate.setNeedsLayout()
                    tabToActivate.layoutIfNeeded()
                }
            )
            self.itemTapped?(tab)
        }
        self.activeItem = tab
    }

    func deactivateTab(tab: Int) {
        let inactiveTab = self.subviews[tab]
        let layersToRemove = inactiveTab.layer.sublayers?.filter({ $0.name == "active border" })
        DispatchQueue.main.async {
            UIView.animate(
                withDuration: Constants.animationDeactiveDuration,
                delay: .zero,
                options: [.curveEaseIn, .allowUserInteraction],
                animations: {
                    layersToRemove?.forEach({ $0.removeFromSuperlayer() })
                    inactiveTab.setNeedsLayout()
                    inactiveTab.layoutIfNeeded()
                }
            )
        }
    }

}

@objc
private extension MainTabBar {

    func handleTap(_ sender: UIGestureRecognizer) {
        self.switchTab(from: self.activeItem, to: sender.view?.tag ?? 0)
    }

}
