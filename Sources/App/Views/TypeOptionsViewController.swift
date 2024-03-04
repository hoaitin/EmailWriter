//
//  TypeOptionsViewController.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 26/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//



import UIKit
import SnapKit
import StoreKit
import PanModal

class TypeOptionsViewController: UIViewController {
    private lazy var dragIndicator = UIView()
    private lazy var headerLabel = UILabel()
    private lazy var iconUserImage = UIImageView()
    private lazy var nameUserLabel = UILabel()
    private lazy var descriptionUserLabel = UILabel()
    private lazy var createbutton = UIButton()
    private lazy var typeTableView = UITableView()
    private var typeOptions:[TypeOptions] = []
    
    //as
    override func viewDidLoad() {
        
        setUpViews()
        setUpConstraints()
        setData()
        
      
    }
    
        
    func setUpViews() {
        view.backgroundColor =  .black

        dragIndicator.backgroundColor =  ConfigColor.gray_tab
        dragIndicator.layer.cornerRadius = 2.5
        
        headerLabel.text = "Writing Options"
        headerLabel.textColor = .white
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.appFont(weight: .medium, size: 16)
        
        iconUserImage.image = R.image.icon_options_user()
        iconUserImage.contentMode = .scaleAspectFill
        
        nameUserLabel.text = "Your profile"
        nameUserLabel.font = UIFont.appFont(weight: .regular, size: 15)
        nameUserLabel.textColor = .white
        
        descriptionUserLabel.text = "Personalize your writing"
        descriptionUserLabel.font = UIFont.appFont(weight: .regular, size: 12)
        descriptionUserLabel.textColor = ConfigColor.gray_tab
        
        createbutton.setTitle("Create", for: .normal)
        createbutton.setTitleColor(.white, for: .normal)
        createbutton.titleLabel?.font = UIFont.appFont(weight: .medium, size: 15)
        createbutton.backgroundColor  = ConfigColor.green_main_app
        createbutton.layer.cornerRadius = 17.5
        createbutton.addTarget(self, action: #selector(handleViewProfile), for: .touchUpInside)
        
        self.setTableView()
        
        
    }
        
    func setUpConstraints() {
        view.addSubview(dragIndicator)
        view.addSubview(headerLabel)
        view.addSubview(iconUserImage)
        view.addSubview(nameUserLabel)
        view.addSubview(descriptionUserLabel)
        view.addSubview(createbutton)
        view.addSubview(typeTableView)
        
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
        
        iconUserImage.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(headerLabel.snp.bottom).offset(20)
            $0.size.equalTo(CGSize(width: 35, height: 35))
        }
        
        nameUserLabel.snp.makeConstraints{
            $0.leading.equalTo(iconUserImage.snp.trailing).offset(12)
            $0.top.equalTo(headerLabel.snp.bottom).offset(20)
            $0.height.equalTo(18)
        }
        
        descriptionUserLabel.snp.makeConstraints{
            $0.leading.equalTo(iconUserImage.snp.trailing).offset(12)
            $0.top.equalTo(nameUserLabel.snp.bottom).offset(2)
            $0.height.equalTo(15)
        }
        
        createbutton.snp.makeConstraints{
            $0.top.equalTo(headerLabel.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().offset(-16)
            $0.size.equalTo(CGSize(width: 80, height: 35))
        }
        
        typeTableView.snp.makeConstraints{
            $0.top.equalTo(createbutton.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    func setData() {
        if let data =  RequestApi.share.getFileJsonTypeOptions() {
            self.typeOptions = data
            self.typeTableView.reloadData()
        }else {
            
        }
    }
    
    @objc func handleViewProfile(){
        let view = ProfileViewController()
        presentPanModal(view)
    }
 
    
        

}

extension TypeOptionsViewController: PanModalPresentable {
    
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

extension TypeOptionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setTableView(){
        
        self.typeTableView.backgroundColor = .black
        self.typeTableView.isScrollEnabled = false
        self.typeTableView.separatorStyle = .none
        self.typeTableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: OptionsTableViewCell.id)
        self.typeTableView.dataSource = self
        self.typeTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OptionsTableViewCell.id, for: indexPath) as? OptionsTableViewCell else {
            return .init()
        }
        cell.setData(typeOption: typeOptions[indexPath.row] )
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let options:[Option] = typeOptions[indexPath.row].data
        return calculateHeight(forOptionsCount: options.count)
    }

 
    
    func calculateHeight(forOptionsCount optionsCount: Int) -> CGFloat {
            if optionsCount % 3 != 0 {
                return CGFloat(45 * (optionsCount / 3 + 1) + 50)
            } else {
                return CGFloat(45 * (optionsCount / 3 ) + 50)
            }
    }

    
    
    
   
    
    
}


