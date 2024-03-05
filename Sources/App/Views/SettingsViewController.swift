

import UIKit
import SnapKit
import CoreLocation
import AppTrackingTransparency
import AdSupport
import Speech
import SafariServices
import StoreKit

class SettingsViewController: BaseViewController, SKStoreProductViewControllerDelegate{
    private lazy var settingTableView = UITableView(frame: .zero, style: .grouped)

    private let abouts:[About] = [
        About(name: "Share Anime Wallpaper",icon: "icon_setting_share" , link: ""),
        About(name: "Term Of Use", icon: "icon_setting_term" ,link: "https://sites.google.com/tinyleo.com/terms-of-use"),
        About(name: "Privacy & Security",icon: "icon_setting_privacy" , link: "https://sites.google.com/tinyleo.com/privacy-policy"),
        About(name: "Contact", icon: "icon_setting_contact" ,link: "https://sites.google.com/tinyleo.com/contact-us"),
        About(name: "Email Us",icon: "icon_setting_email" , link: ""),
        About(name: "About Us", icon: "icon_setting_about" ,link: "https://sites.google.com/tinyleo.com/about-us")
    ]
    
  
   //as
    override func setupViews() {
        super.setupViews()
        // Mark: setupViews
        
        settingTableView.backgroundColor = .black
        settingTableView.separatorStyle = .none
        settingTableView.showsVerticalScrollIndicator = false
//        settingTableView.tableHeaderView = nil
//        settingTableView.sectionHeaderTopPadding = 0
        settingTableView.register(AboutTableViewCell.self, forCellReuseIdentifier: AboutTableViewCell.id)
        settingTableView.register(OurAppItemVIewCell.self, forCellReuseIdentifier: OurAppItemVIewCell.id)
        settingTableView.register(ProfileViewTableViewCell.self, forCellReuseIdentifier: ProfileViewTableViewCell.id)
        settingTableView.dataSource = self
        settingTableView.delegate = self
        addTabbarHeader()
        
        // Mark: setConstraints
        
        view.addSubview(settingTableView)
        
        settingTableView.snp.makeConstraints{
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
   
    


}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
      
       func numberOfSections(in tableView: UITableView) -> Int {
          
           return 3
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           if section == 0 {
               return 2
           } else if section == 1 {
               return 4
           }
    
           return abouts.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let section = indexPath.section
           let row = indexPath.row
           if section == 0 {
               if row == 0 {
                   guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileViewTableViewCell.id , for: indexPath) as? ProfileViewTableViewCell else {
                       return .init()
                   }
                   
                   cell.setData(name: "Your profile", description: "Personalize your writing")
                   return cell
                   
               }else {
                   guard let cell = tableView.dequeueReusableCell(withIdentifier: AboutTableViewCell.id , for: indexPath) as? AboutTableViewCell else {
                       return .init()
                   }
                   
                   cell.setData(icon: "icon_star", text: "Change app icon")
                   return cell
               }
               
               
           }else if section == 1 {
               guard let cell = tableView.dequeueReusableCell(withIdentifier: OurAppItemVIewCell.id , for: indexPath) as? OurAppItemVIewCell else {
                   return .init()
               }
                              
               cell.setData(icon: "icon_app_test", text: "AI Grammar Check for English")
               return cell
           }
           
           
           guard let cell = tableView.dequeueReusableCell(withIdentifier: AboutTableViewCell.id , for: indexPath) as? AboutTableViewCell else {
               return .init()
           }
           
           let about = abouts[row]
           
           cell.setData(icon: about.icon, text: about.name)
           return cell
       }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        if section == 0 {
            if row == 0 {
               
                
            }else {
                let view = ListLogoViewController()
                navigationController?.pushViewController(view, animated: true)
            }
            
        }else if section == 1 {
            let vc = SKStoreProductViewController()
            vc.delegate = self // Bạn cần gán delegate để bắt sự kiện khi người dùng đóng cửa sổ App Store.

            let parameters = [SKStoreProductParameterITunesItemIdentifier: "6471563037"]
            vc.loadProduct(withParameters: parameters) { [weak self] (success, error) in
                if !success {
                    print("Error loading product: \(error?.localizedDescription ?? "Unknown error")")
                }
            }

            present(vc, animated: true)
            
        }else {
            let about = abouts[row]
            if about.link != "" {
                if let url = URL(string: about.link) {
                    let safariViewController = SFSafariViewController(url: url)
                    present(safariViewController, animated: true, completion: nil)
                }
            }else {
                if indexPath.row == 0 {
                    let textToShare = "https://apps.apple.com/vn/app/id6471563037"
                    let itemsToShare = [textToShare]

                           // Tạo UIActivityViewController
                    let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
                    present(activityViewController, animated: true, completion: nil)
                }else {
               
                }
                
            }
        }
       
        
    }

       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           // Set the height of each cell
           return 60
       }
    
       
       func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           // Customize the appearance of each cell
           if indexPath.row != 0 {
            let separatorView = UIView(frame: CGRect(x: 16, y: 0, width: tableView.bounds.width - 32, height: 1))
               separatorView.backgroundColor = ConfigColor.gray_tab
            cell.contentView.addSubview(separatorView)
            }
           
           if indexPath.row == 0 {
               cell.roundCorners(corners: [.topLeft, .topRight], radius: 15)
           } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
               cell.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15)
           } else {
               cell.roundCorners(corners: [], radius: 0)
           }
       }
   
         func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
             let headerView = UIView()
             let label = UILabel(frame: CGRect(x: 0, y: -5, width: tableView.frame.width - 32, height: 50))
             label.textColor = ConfigColor.main_setting2
             label.font = UIFont.appFont(weight: .bold, size: 16)
    
             if section == 0 {
                 label.text = "App"
             } else if section == 1 {
                 label.text = "Our app"
             }else {
                 label.text = "Abouts"
             }
             
             
             headerView.addSubview(label)
            return headerView
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
        }
    
}

extension UITableViewCell {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
