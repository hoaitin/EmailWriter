import Foundation
import RxSwift
import SnapKit
import UIKit


class TabBarViewController: UITabBarController {

       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .black
        tabBar.barTintColor = .black
        tabBar.unselectedItemTintColor = ConfigColor.gray_text_app
        tabBar.tintColor = ConfigColor.green_main_app

        tabBar.isTranslucent = false
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: ConfigColor.gray_text_app], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: ConfigColor.green_main_app], for: .selected)
        
        setViews()
    }
    
    func setViews(){
        
        viewControllers = [writeEmailTab,myEmailTab,setingsTab]
    }
    
    func setUpConstraints(){
        
     
    }
    
    // CODE REVIEW: Check lai code, xai tabbar nhu the nay. Remove nhung doan code k xai
    lazy var writeEmailTab: UIViewController = {
        let writeEmailTabItem = UITabBarItem(title: "Write", image: R.image.tabbar_explore_dark(), selectedImage: R.image.tabbar_explore_dark())
        let writeEmailNavTab = WriteViewController()
        writeEmailNavTab.tabBarItem = writeEmailTabItem
        return writeEmailNavTab
    }()
    
    lazy var myEmailTab: UIViewController = {
        let myEmailTabItem = UITabBarItem(title: "My Email", image: R.image.tabbar_email(), selectedImage: R.image.tabbar_email())
        let myEmailNavTab = MyEmailViewController()
        myEmailNavTab.tabBarItem = myEmailTabItem
        return myEmailNavTab
    }()
    
    lazy var setingsTab: UIViewController = {
        let setingsTabItem = UITabBarItem(title: "Settings", image: R.image.tabbar_setting_dark(), selectedImage: R.image.tabbar_setting_dark())
        let setingsNavTab = SettingsViewController()
        setingsNavTab.tabBarItem = setingsTabItem
        return setingsNavTab
    }()
    
    
//    lazy var writeEmailTab: UINavigationController = {
//        // CODE REVIEW: xai R.imgae., k sai named
//        let tabItem = UITabBarItem(title: "Write", image: R.image.tabbar_explore_dark(), selectedImage: UIImage(named: "tabbar_explore_dark"))
//           let viewController = WriteViewController()
//           // Tạo một UINavigationController và đặt WriteViewController làm root view controller của nó
//           let navController = UINavigationController(rootViewController: viewController)
//           
//           // Thiết lập tab bar item cho UINavigationController
//           navController.tabBarItem = tabItem
//        navController.navigationBar.isTranslucent = false
//        navController.navigationBar.barTintColor = .black
//           
//           return navController
//        }()
    
    @objc func addButtonTapped() {
        let view = LagViewController()
        presentPanModal(view)
    }
    


}


