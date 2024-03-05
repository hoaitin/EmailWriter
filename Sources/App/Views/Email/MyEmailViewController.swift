//
//  MyEmailViewController.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 20/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation

class MyEmailViewController: BaseViewController , UIPopoverPresentationControllerDelegate{
    private lazy var recentsTable = UITableView(frame: .zero, style: .grouped)
    private var emailSection:[EmailSection] = []
    
    override func setupViews() {
        super.setupViews()
        // Mark: setupViews
        addTabbarHeader()
        self.recentsTable.backgroundColor = .black
        self.recentsTable.separatorStyle = .none
        self.recentsTable.tableHeaderView = nil
        self.recentsTable.sectionHeaderTopPadding = 0
        self.recentsTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        self.recentsTable.register(EmailCollectionViewCell.self, forCellReuseIdentifier: EmailCollectionViewCell.id)
        self.recentsTable.dataSource = self
        self.recentsTable.delegate = self
        
        // Mark: setupContraints
        view.addSubview(recentsTable)

        recentsTable.snp.makeConstraints{
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
        }
        
        getData()
        
        
    }
    

    func getData(){
        if let emails = RequestApi.share.getFileJsonEmail() {
            self.emailSection =  emails
            recentsTable.reloadData()
        }else {
            
        }
    }

    func addButtonTapped(y: Int) {
        let popoverContent =  PopViewController()
        let nav = UINavigationController(rootViewController: popoverContent)
        nav.modalPresentationStyle = .popover
        let popover = nav.popoverPresentationController
        popoverContent.preferredContentSize = CGSizeMake(184, 118)
        popover?.permittedArrowDirections = .init()
        popover?.delegate = self
        popover?.sourceView = self.view
        popover?.sourceRect = CGRectMake(self.view.frame.width - 80 , CGFloat(y + 10),0,0)
        self.present(nav, animated: true, completion: nil)
       
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
      return .none // Bắt buộc popover hiển thị trên màn hình
    }

}

extension MyEmailViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return emailSection.count
    }
    	
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailSection[section].data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmailCollectionViewCell.id, for: indexPath) as? EmailCollectionViewCell else {
            return .init()
        }
        
        let email = emailSection[indexPath.section].data[indexPath.row]
        cell.setData(name: email.name, title: email.content, time: email.time)
//        cell.popButton.addTarget(self, action: #selector(self.addButtonTapped), for: .touchUpInside )
         cell.buttonActionHandler = { cellText, y in
             self.addButtonTapped(y: y)
            print("===>\(cellText)")
             
         }
        return cell
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = UIView()
           let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.frame.width - 30, height: 50))
           label.textColor = ConfigColor.main_setting2
           label.font = UIFont.appFont(weight: .regular, size: 16)
  
           // Thiết lập nội dung của header cho từng section
          label.text = emailSection[section].name
           
           
           headerView.addSubview(label)
           
        //. sticky header code
        
           return headerView
       }
    
    
    
      func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 50 // Chiều cao của header
      }
    
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
       }
    
  

    
   
}


