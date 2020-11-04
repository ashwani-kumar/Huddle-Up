//
//  ScreenTimeline.swift
//  Huddlup
//
//  Created by Ashwani Kumar on 2020-08-17.
//  Copyright © 2020 Ashwani Kumar. All rights reserved.
//

import SwiftUI
import UIKit

extension UINavigationBar {
    var largeTitleHeight: CGFloat {
        let maxSize = subviews
            .filter { $0.frame.origin.y > 0 }
            .max { $0.frame.origin.y < $1.frame.origin.y }
            .map { $0.frame.size }
        return maxSize?.height ?? 0
    }
}

class ScreenGoalsViewController: UIViewController {
    private var screenGoals: ScreenGoals?
    private var swiftUIViewController: UIViewController?
    
    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)

        self.view = view

        navigationItem.title = ""

        // Prefer large titles to get nav bar scroll/fade effect
        navigationController?.navigationBar.prefersLargeTitles = true

        addNavBarProfileButton(targetNavigationItem: navigationItem, target: self, action: #selector(onProfileButtonPressed))

        screenGoals = ScreenGoals()

        swiftUIViewController = UIHostingController(rootView: screenGoals.environmentObject(uiState).environmentObject(vaultItemSate))

        if let hostingController = swiftUIViewController {
            addChildViewController(hostingController)
            hostingController.view.frame = view.frame
        }
        addEventHandlers()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func addEventHandlers() {
        NotificationCenter.default.addObserver(self, selector: #selector(onRequestNavBarTextColor), name: Notification.requestNavBarTextColor, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onRequestPackItemBackground), name: Notification.requestPackItemBackground, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // This must be called in viewDidAppear because the large title element is only rendered after appearing
        // This currently gets the right value, but ScreenGoals does not reflect the change
        if let largeTitleHeight = navigationController?.navigationBar.largeTitleHeight {
            screenGoals?.navHeight = largeTitleHeight
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // for ipad
        updateFrame(parentVC: swiftUIViewController, tab: .tab1)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // Trait collection has already changed
        swiftUIViewController?.setGradientBackground(tab: .tab1)
    }

    func customizeNavBarHeader(color: UIColor) {
        let font = UIFont.preferredFont(forTextStyle: .largeTitle)
        let attributesLarge = [NSAttributedString.Key.font: UIFont(name: "value serif", size: font.pointSize)!,
                               NSAttributedString.Key.foregroundColor: color]
        navigationController?.navigationBar.largeTitleTextAttributes = attributesLarge
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc func onRequestNavBarTextColor(notification: Notification) {
        if let color = notification.userInfo!["color"] as? UIColor {
            customizeNavBarHeader(color: color)
        } else {
            print("Something went wrong. Trying to requestNavBarTextColor with an invalid color.")
        }
    }

    @objc func onRequestPackItemBackground(notification: Notification) {
        if let imageName = notification.userInfo!["imageName"] as? String {
            var mode: UIUserInterfaceStyle = .light
            if traitCollection.userInterfaceStyle == .dark {
                mode = .dark
            }

            let bgImage = ScreenGoalsViewController.getPackItemImage(imageName, mode: mode)
//            let bgView = UIImageView(image: bgImage)
//            bgView.frame = CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: UIScreen.screenHeight)

            navigationController?.viewControllers.forEach { vc in
//                vc.view.backgroundColor = UIColor(patternImage: bgImage)
                vc.view.backgroundColor = UIColor(patternImage: bgImage.resized(to: view.frame.size, mode: .fill))
                // vc.view.addSubview(bgView)
                // vc.view.sendSubviewToBack(bgView)
            }
        }
    }

    static func getPackItemImage(_ imageName: String, mode: UIUserInterfaceStyle) -> UIImage {
        let bgImage: UIImage = UIImage(contentsOfFile: Bundle.main.path(forResource: imageName, ofType: "jpg")!) ?? UIImage()
        return bgImage.applyWhiteGradient(mode: mode)
    }

//    private func setBackground() {
//        var bg: UIImage?
//        switch traitCollection.userInterfaceStyle {
//        case .light, .unspecified:
//            bg = UIImage(named: "bg.light.tab.one")?.resized(to: view.frame.size)
//        case .dark:
//            bg = UIImage(named: "bg.dark.tab.one")?.resized(to: view.frame.size)
//        @unknown default:
//            print("WARNING: Unknown userInterfaceStyle trait")
//        }
//        if let bg = bg, let hostingController = swiftUIViewController {
//            hostingController.view.backgroundColor = UIColor(patternImage: bg)
//        }
//    }

    @objc func onProfileButtonPressed() {
        ScreenFlowManager.shared.showProfileMenuScreen()
    }
}

extension UIImage {
    /**
     * Applies a linear white gradient from top to bottom
     */
    func applyWhiteGradient(mode: UIUserInterfaceStyle = .light) -> UIImage {
        let img = self

        UIGraphicsBeginImageContext(img.size)
        let context = UIGraphicsGetCurrentContext()

        img.draw(at: CGPoint(x: 0, y: 0))

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations: [CGFloat] = [0.0, 0.47, 1.0]

        var top: CGColor
        var middle: CGColor
        var bottom: CGColor

        if mode == .dark {
            top = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
            middle = UIColor(red: 0, green: 0, blue: 0, alpha: 0.72).cgColor
            bottom = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        } else {
            top = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).cgColor
            middle = UIColor(red: 1, green: 1, blue: 1, alpha: 0.72).cgColor
            bottom = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1).cgColor
        }

        let colors = [top, middle, bottom] as CFArray

        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations)

        let startPoint = CGPoint(x: img.size.width / 2, y: 0)
        let endPoint = CGPoint(x: img.size.width / 2, y: img.size.height)

        context!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))

        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image!
    }
}

struct ScreenGoalsViewController_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
