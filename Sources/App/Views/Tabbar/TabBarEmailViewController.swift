import Foundation
import RxSwift
import SnapKit
import UIKit


class TabBarEmailViewController: UITabBarController {
//    private lazy var TitleLabel = UILabel()
//    private lazy var rightButton = UIButton()

    
    var isHiddenPopoverView = true
       
    override func viewDidLoad() {
        super.viewDidLoad()
       

//        setUpConstraints()
        
        tabBar.backgroundColor = .black
        tabBar.barTintColor = .black
        tabBar.unselectedItemTintColor = ConfigColor.tabbarTitle
        tabBar.tintColor = ConfigColor.gray_tab_title
//        tabBar.isTranslucent = false
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: ConfigColor.gray_tab_title], for: .normal)
        
//        self.delegate = self
        setViews()
    }
    
    func setViews(){
    // Do any additional setup after loading the view.
//    self.setViewControllers([writeEmailTab,myEmailTab,setingsTab], animated: true)
        
        viewControllers = [writeEmailTab,myEmailTab,setingsTab]
        
//        TitleLabel.text = "Em@il Write"
//        TitleLabel.textColor = .white
//        TitleLabel.font = UIFont.appFont(weight: .bold, size: 20)
//        
//        rightButton.layer.cornerRadius = 20
//        rightButton.clipsToBounds = true
//        rightButton.setTitle("Upgrade", for: .normal)
//        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
//        rightButton.setTitleColor(UIColor(hex: 0xFFDC6D), for: .normal)
//        rightButton.setImage(UIImage(named: "icon_tool_translate"), for: .normal)
//        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
//        rightButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
//        // Đặt hình ảnh và tiêu đề cho UIButton
//        rightButton.backgroundColor = UIColor(hex: 0xFFDF80 , alpha: 0.2) // Màu nền của UIButton
//        
    }
    
    func setUpConstraints(){
//        view.addSubview(TitleLabel)
//        view.addSubview(rightButton)
//     
//        
//        TitleLabel.snp.makeConstraints{
//            $0.top.equalToSuperview().offset(60)
//            $0.left.equalToSuperview().offset(20)
//            $0.size.equalTo(CGSize(width: 140, height: 20))
//            
//        }
//        
//       rightButton.snp.makeConstraints{
//            $0.top.equalToSuperview().offset(50)
//            $0.right.equalToSuperview().offset(-20)
//            $0.size.equalTo(CGSize(width: 106, height: 40))
//        }
        
     
        
    }
    
    // CODE REVIEW: Check lai code, xai tabbar nhu the nay. Remove nhung doan code k xai
    lazy var writeEmailTab: UIViewController = {
        let stylesTabItem = UITabBarItem(title: "Write", image: R.image.tabbar_model_light(), selectedImage: R.image.tabbar_explore_dark()?.withRenderingMode(.alwaysOriginal))
        let stylesNavTab = WriteViewController()
        stylesNavTab.tabBarItem = stylesTabItem
        return stylesNavTab
    }()
    
    lazy var myEmailTab: UIViewController = {
        let stylesTabItem = UITabBarItem(title: "Write", image: R.image.tabbar_model_light(), selectedImage: R.image.tabbar_explore_dark()?.withRenderingMode(.alwaysOriginal))
        let stylesNavTab = WriteViewController()
        stylesNavTab.tabBarItem = stylesTabItem
        return stylesNavTab
    }()
    
    lazy var setingsTab: UIViewController = {
        let stylesTabItem = UITabBarItem(title: "Write", image: R.image.tabbar_model_light(), selectedImage: R.image.tabbar_explore_dark()?.withRenderingMode(.alwaysOriginal))
        let stylesNavTab = WriteViewController()
        stylesNavTab.tabBarItem = stylesTabItem
        return stylesNavTab
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
    
//    lazy var myEmailTab: UIViewController = {
//        let tabItem = UITabBarItem(title: "My Email", image: UIImage(named: "tabbar_email"), selectedImage: UIImage(named: "tabbar_email"))
//           let viewController = MyEmailViewController()
//           
//           // Tạo một UINavigationController và đặt WriteViewController làm root view controller của nó
//           let navController = UINavigationController(rootViewController: viewController)
//           
//           // Thiết lập tab bar item cho UINavigationController
//           navController.tabBarItem = tabItem
//        navController.navigationBar.isTranslucent = false
//        navController.navigationBar.barTintColor = .black
//           
//           return navController
//    }()
//    
//    lazy var setingsTab: UIViewController = {
//        let tabItem = UITabBarItem(title: "Setings", image: UIImage(named: "tabbar_setting_dark"), selectedImage: UIImage(named: "tabbar_setting_dark"))
//           let viewController = SettingsViewController()
//           
//           // Tạo một UINavigationController và đặt WriteViewController làm root view controller của nó
//           let navController = UINavigationController(rootViewController: viewController)
//           
//           // Thiết lập tab bar item cho UINavigationController
//           navController.tabBarItem = tabItem
//           navController.navigationBar.isTranslucent = false
//           navController.navigationBar.barTintColor = .black
//         
//           return navController
//    }()
    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//            // Handle tab change event here
//        TextToSpeechManager.share.pauseSpeaking()
////            if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
////                print("Selected tab index: \(index)")
////                // You can perform any actions you need based on the selected tab index
////            }
//    }
 

    
    

}


