//
//  GoMoneyTabBar.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import UIKit

class GoMoneyTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabs()
        // Do any additional setup after loading the view.
    }
    
    func tabs() {
        // Create View Controllers
        let firstVC = createNavController(tabIconName: "soccer", vc: CurrentFixtureVC())
        
        let secondVC = createNavController(tabIconName: "soccer-field", vc: CompetitionsVC())
        
        self.setViewControllers([firstVC, secondVC], animated: false)
        self.tabBar.backgroundColor = .white
    }
    
    func createTabBarItem(title: String? = nil, icon: UIImage? = nil, tag: Int = 0) -> UITabBarItem {
        if let originalImage = icon {
            let resizedImage = resizeImage(image: originalImage, targetSize: CGSize(width: 24, height: 24)) // Adjust size as needed
            let tabBarItem = UITabBarItem(title: "", image: resizedImage, tag: tag)
            return tabBarItem
        }
        return UITabBarItem(title: "", image: UIImage(systemName: "globe"), tag: 0)
    }
    
    func createNavController(tabIconName: String, vc: UIViewController) -> UINavigationController {
        let navVC = NavVC(rootViewController: vc)
        navVC.tabBarItem = createTabBarItem(icon: UIImage(named: tabIconName))
        return navVC
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}
