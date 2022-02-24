//
//  ViewController.swift
//  Navigation
//
//  Created by Арсений Корнилов on 22.02.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private enum Index: Int {
        case none = 0
        case first
        case second
        
        var title: String {
            switch self {
            case .first:
                return "Лента"
            case .second:
                return "Профиль"
            case .none:
                return ""
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()

    }
    
    func setupTabBar() {
        
        self.viewControllers?.enumerated().forEach({ (index, vc) in
            let title: String
            switch index {
            case 0:
                title = Index.first.title
            case 1:
                title = Index.second.title
            default:
                title = Index.none.title
            }
            vc.tabBarItem.title = title
        })
        
        
    
    }
}

