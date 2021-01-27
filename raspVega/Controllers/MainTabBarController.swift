//
//  MainTabBarController.swift
//  raspVega
//
//  Created by Peter Kvasnikov on 23.11.2020.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            createNewViewController(viewController: ScheduleViewController(), title: "Расписание", imageName: "book.fill"),
            createNewViewController(viewController: SearchViewController(), title: "Поиск", imageName: "magnifyingglass"),
            createNewViewController(viewController: NotificationsViewController(), title: "Уведомления", imageName: "bell.fill"),
            createNewViewController(viewController: SettingsViewController(), title: "Настройки", imageName: "gearshape.fill"),

        ]
    }
    

    private func createNewViewController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: imageName), selectedImage: nil)
        navController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        return navController
        
    }

}
