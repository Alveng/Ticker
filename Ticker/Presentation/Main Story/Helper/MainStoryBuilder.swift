//
//  MainStoryBuilder.swift
//  Ticker
//
//  Created by Sergey Klimov on 18.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit


class MainStoryBuilder {
    
    static func tabBar() -> TabBarViewController {
        let tabBarVC = TabBarViewController()
        tabBarVC.viewControllers = [tickerVC(), emptyVC()]
        if let items = tabBarVC.tabBar.items {
            let images = tabBarImages()
            for i in 0..<items.count {
                let tabBarItem = items[i]
                let tabBarImage = images[i]
                tabBarItem.image = tabBarImage.withRenderingMode(.alwaysOriginal)
                tabBarItem.selectedImage = tabBarImage
            }
        }
        return tabBarVC
    }
    
    static func tickerVC() -> TickerViewController {
        return TickerViewController()
    }
    
    static func emptyVC() -> EmptyViewController {
        let vc = EmptyViewController()
        vc.view.backgroundColor = .white
        return vc
    }
    
    
    private static func tabBarImages() -> [UIImage] {
        return [#imageLiteral(resourceName: "tab1"), #imageLiteral(resourceName: "tab2")]
    }
}
