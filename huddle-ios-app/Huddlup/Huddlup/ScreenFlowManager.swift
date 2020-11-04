//
//  ScreenFlowManager.swift
//  Huddlup
//
//  Created by Ashwani Kumar on 2020-08-15.
//  Copyright © 2020 Ashwani Kumar. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

class ScreenFlowManager: NSObject, ObservableObject {
    public static let shared = ScreenFlowManager()
    @Published public var mMainUIWindow: UIWindow?
    private var mCurrentRootVC: UIViewController?
    
    func setMainUIWindow(window: UIWindow) {
        mMainUIWindow = window
    }

private func getMainVaultViewController() -> UIViewController {
        UINavigationBar.appearance().setBackgroundImage(nil, for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = nil
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().tintColor = nil
        UINavigationBar.appearance().backgroundColor = nil

        let tabBarController: CustomTabBarController = CustomTabBarController()

        mCurrentRootVC = tabBarController
        return tabBarController
    }
    
    func exitLoadingScreen() {
           print("exitLoadingScreen()")
           let vc = getMainVaultViewController()
               (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc)
           
       }
}

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    // var goalsVC: UIViewController!
    var goalScreenNC: UINavigationController!
    var quickAddVC: UIViewController!
    var homeScreenNC: UINavigationController!

    override func loadView() {
        super.loadView()
        addEventHandlersForIpad()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

        // Create UIKit View Controllers

        let goalsVC = ScreenGoalsViewController()
        goalScreenNC = UINavigationController(rootViewController: goalsVC)
        let goalsScreenIcon = UIImage(systemName: "checkmark.circle.fill")
        goalScreenNC.tabBarItem = UITabBarItem(title: nil, image: goalsScreenIcon, tag: 1)

        // Vault Screen uses a Nav Controller, ScreenHomeViewController is the root of the Nav
        let vaultHomeVC = ScreenHomeViewController()
        // let nc = UINavigationController(rootViewController: vaultHomeVC)
        // mHomeScreenNC = nc
        // let homeScreenNC = ScreenFlowManager.shared.createHomeScreenRootNavigationController()
        homeScreenNC = UINavigationController(rootViewController: vaultHomeVC)
        let homeScreenIcon = UIImage(systemName: "archivebox.fill")
        /* ?.tintedWithLinearGradientColors(colorsArr: [UIColor.purple.cgColor, UIColor.red.cgColor]).withRenderingMode(UIImage.RenderingMode.alwaysOriginal) */
        homeScreenNC.tabBarItem = UITabBarItem(title: nil, image: homeScreenIcon, tag: 2)

        quickAddVC = ScreenQuickAddViewControllerDummy()
        // let quickAddScreenIcon = UIImage(systemName: "plus")
        let quickAddScreenIcon = UIImage(named: "tabIcon.quickAdd.light")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        quickAddVC.tabBarItem = UITabBarItem(title: nil, image: quickAddScreenIcon, selectedImage: quickAddScreenIcon)
        // quickAddVC.tabBarItem.selectedImage = quickAddScreenIcon

        // let tabBarController: CustomTabBarController = CustomTabBarController()
        // let tabBarVCList = [goalScreenNC, homeScreenNC, quickAddVC]
        // delegate = self

        // we don't use navigation view controller for ipad to use swiftui split view
        if DeviceUtils.isIpad {
            goalsVC.tabBarItem = UITabBarItem(title: nil, image: homeScreenIcon, tag: 1)
            vaultHomeVC.tabBarItem = UITabBarItem(title: nil, image: homeScreenIcon, tag: 2)
            viewControllers = [goalsVC, vaultHomeVC, quickAddVC]
        } else {
            viewControllers = [goalScreenNC, homeScreenNC, quickAddVC]
        }

        selectedIndex = 1

        setTabIcons()
    }

    private func setTabIcons() {
        let goalTab = viewControllers?[0].tabBarItem
        let homeTab = viewControllers?[1].tabBarItem
        let quickAddTab = viewControllers?[2].tabBarItem

        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            let quickAddIcon = UIImage(named: "tabIcon.quickAdd.light")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)

            quickAddTab?.image = quickAddIcon
            quickAddTab?.selectedImage = quickAddIcon

            // TODO: explore later: Programatic gradient application.. would be better than images, i think.
//            let homeScreenIcon = UIImage(systemName: "archivebox.fill")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
//            let homeScreenIconSelected = UIImage(systemName: "archivebox.fill")?.tintedWithLinearGradientColors(colorsArr: [UIColor.purple.cgColor, UIColor.blue.cgColor]).withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
//            homeScreenNC.tabBarItem.image = homeScreenIcon
//            homeScreenNC.tabBarItem.selectedImage = homeScreenIconSelected

            homeTab?.image = UIImage(named: "tabIcon.home.unselected.light")?.withRenderingMode(.alwaysOriginal)
            homeTab?.selectedImage = UIImage(named: "tabIcon.home.selected.light")?.withRenderingMode(.alwaysOriginal)

            goalTab?.image = UIImage(named: "tabIcon.goals.unselected.light")?.withRenderingMode(.alwaysOriginal)
            goalTab?.selectedImage = UIImage(named: "tabIcon.goals.selected.light")?.withRenderingMode(.alwaysOriginal)
        case .dark:
            let quickAddIcon = UIImage(named: "tabIcon.quickAdd.dark")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            let quickAddIconSelected = quickAddIcon?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            quickAddTab?.image = quickAddIcon
            quickAddTab?.selectedImage = quickAddIconSelected

            homeTab?.image = UIImage(named: "tabIcon.home.unselected.dark")?.withRenderingMode(.alwaysOriginal)
            homeTab?.selectedImage = UIImage(named: "tabIcon.home.selected.dark")?.withRenderingMode(.alwaysOriginal)

            goalTab?.image = UIImage(named: "tabIcon.goals.unselected.dark")?.withRenderingMode(.alwaysOriginal)
            goalTab?.selectedImage = UIImage(named: "tabIcon.goals.selected.dark")?.withRenderingMode(.alwaysOriginal)
        @unknown default:
            print("WARNING: Unknown userInterfaceStyle trait")
        }

//        for tabBarItem in tabBar.items! {
//            tabBarItem.title = ""
        let iconOffset: CGFloat = 6.0
        goalTab?.imageInsets = UIEdgeInsets(top: iconOffset, left: 0, bottom: -iconOffset, right: 0)
        quickAddTab?.imageInsets = UIEdgeInsets(top: iconOffset, left: 0, bottom: -iconOffset, right: 0)
        homeTab?.imageInsets = UIEdgeInsets(top: iconOffset, left: 0, bottom: -iconOffset, right: 0)
//        }

        // JL: This results in a hard crash.. not sure why
        /* var fontAttributes: [NSAttributedString.Key: Any] = [:]
         fontAttributes[NSAttributedString.Key.foregroundColor] = Color.clear
         UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal) */

        // JL: This is a bit (alot) hacky, but it works...
        let tabTextOffset: CGFloat = 100
        goalTab?.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: tabTextOffset)
        quickAddTab?.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: tabTextOffset)
        homeTab?.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: tabTextOffset)
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        switch viewController {
        case goalScreenNC:
            Tracking.logEvent("Goals", "Dashboard")
            return true
        case homeScreenNC:
            Tracking.logEvent("Home", "Dashboard")
            return true
        case is ScreenQuickAddViewControllerDummy:
            Tracking.logEvent("Vault Item", "Quick Add Clicked")
            ScreenFlowManager.shared.showQuickAddModal()
            return false
        default:
            return true
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // Trait collection has already changed
        setTabIcons()
    }

    // for ipad
    func addEventHandlersForIpad() {
        if DeviceUtils.isIpad {
            NotificationCenter.default.addObserver(self, selector: #selector(onOrientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
            onOrientationChanged() // update for inital orientation
        }
    }

    @objc func onOrientationChanged() {
        DataStoreManager.shared.uiState.orientationPortrait = UIApplication.shared.isPortrait
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
