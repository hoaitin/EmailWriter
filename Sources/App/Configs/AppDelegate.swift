import Foundation
import AVFAudio
import UIKit
import Firebase
import CoreLocation

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var rootViewController: UIViewController? {
        return window?.rootViewController
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        Configs.ATT()
        
        _ = RemoteConfigManager.share
        AIPManager.share.configure(){ success in
            if success {
                print("===> liên kết thành công")
            }
        }
    
        // MARK: Initialize views
        self.window = UIWindow(frame: UIScreen.main.bounds)
      
        let nav = UINavigationController(rootViewController: SplashViewController())
        nav.setNavigationBarHidden(true, animated: false)
//        let tabBarController = TabBarEmailViewController()
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
        // MARK: Prevent app's screen lock
        UIApplication.shared.isIdleTimerDisabled = true
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        TextToSpeechManager.share.pauseSpeaking()
    }
    

}
