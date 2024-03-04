//
//  LagViewController.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 29/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//



import Foundation
import UIKit
import PanModal
import GrowingTextView

class LagViewController: UIViewController {
    private lazy var dragIndicator = UIView()
    private lazy var headerLabel = UILabel()
    private lazy var contentSearchView = UIView()
    private lazy var searchTextField = UITextField()
    private lazy var lagTableView = UITableView()
    private var selectedIndexPath: IndexPath?
    private var countries:[Country] = []
    private var country:Country?
   
    override func viewDidLoad() {
        
        setUpViews()
        setUpConstraints()
        setData()
        
    }
        
    func setUpViews() {
        view.backgroundColor = .black
        
        dragIndicator.backgroundColor =  ConfigColor.gray_tab
        dragIndicator.layer.cornerRadius = 2.5
        
        headerLabel.text = "Select language"
        headerLabel.textColor = .white
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.appFont(weight: .medium, size: 16)
        
        contentSearchView.backgroundColor = ConfigColor.main_bg
        contentSearchView.layer.cornerRadius = 10
        
        searchTextField.font = UIFont.appFont(weight: .regular, size: 17)
        searchTextField.textColor = .white
        let attributedPlaceholder = NSAttributedString(string:  "Search", attributes: [NSAttributedString.Key.foregroundColor: ConfigColor.gray_text_app])
        searchTextField.attributedPlaceholder = attributedPlaceholder
        
        let leftImageView = UIImageView(image: UIImage(named: "search_glyph"))
        leftImageView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        leftImageView.contentMode = .scaleAspectFit
        searchTextField.leftView = leftImageView
        searchTextField.leftViewMode = .always
        
        let rightImageView = UIImageView(image: UIImage(named: "search_dictation"))
        rightImageView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        rightImageView.contentMode = .scaleAspectFit
        searchTextField.rightView = rightImageView
        searchTextField.rightViewMode = .always
       
        self.lagTableView.backgroundColor = .black
        self.lagTableView.separatorStyle = .none
        self.lagTableView.register(LagTableViewCell.self, forCellReuseIdentifier: LagTableViewCell.id)
        self.lagTableView.dataSource = self
        self.lagTableView.delegate = self
    }
        
    func setUpConstraints() {
        view.addSubview(dragIndicator)
        view.addSubview(headerLabel)
       
        view.addSubview(contentSearchView)
        contentSearchView.addSubview(searchTextField)
        view.addSubview(lagTableView)
        
        dragIndicator.snp.makeConstraints{
            $0.top.equalToSuperview().inset(15)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 80, height: 5))
        }
        
        headerLabel.snp.makeConstraints{
            $0.top.equalTo(dragIndicator.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        contentSearchView.snp.makeConstraints{
            $0.top.equalTo(headerLabel.snp.bottom).offset(12)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.height.equalTo(36)
        }
        
        searchTextField.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(8)
        }
        
        lagTableView.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(searchTextField.snp.bottom).offset(12)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    func setData(){
        if let countries = RequestApi.share.getFileJsonCountry() {
            self.countries = countries
            self.country = countries.first
            selectedIndexPath = IndexPath(item: 0, section: 0)
            lagTableView.reloadData()
            
        }else {
            
        }
    }
    
}

extension LagViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LagTableViewCell.id, for: indexPath) as? LagTableViewCell else {
            return .init()
        }
        
        let country = countries[indexPath.row]
        
        cell.setData(name: "\(country.name) - \(country.language)", icon: country.flag)
        
        if indexPath.item == selectedIndexPath?.item {
            cell.setAction()
        }else{
            cell.hiddenAction()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previousSelectedIndexPath = selectedIndexPath {
            if let previousSelectedCell = tableView.cellForRow(at: previousSelectedIndexPath) as?
                LagTableViewCell {
                if(!previousSelectedCell.isSelected){
                  previousSelectedCell.hiddenAction()
                }
              
            }
        }
    
        if let newSelectedCell = tableView.cellForRow(at: indexPath) as? LagTableViewCell {
            if newSelectedCell.isSelected {
                self.country = countries[indexPath.row]
                newSelectedCell.setAction()
            }
        }
      
        selectedIndexPath = indexPath
        
    }
    
}

extension LagViewController: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil // Trả về UIScrollView nếu bạn muốn cho phép cuộn khi modal mở rộng
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(view.frame.height - 50) // Chiều cao của modal khi ở trạng thái short
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(20) // Chiều cao tối đa của modal khi ở trạng thái long
    }
    
    var showDragIndicator: Bool {
        return false
    }
   
}

