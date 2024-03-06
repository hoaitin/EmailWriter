//
//  EmailCollectionViewCell.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 20/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import UIKit

class EmailCollectionViewCell: UITableViewCell {
    static let id = "EmailCollectionViewCell"
    public lazy var containerView = UIView()
    private lazy var nameLabel = UILabel()
    private lazy var titleLabel =  UILabel()
    private lazy var timeLabel = UILabel()
    public lazy var popButton = UIButton()
    
    var buttonActionHandler: ((String, Int) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        setUpConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(name: String, title: String , time: String){
        nameLabel.text = name
        titleLabel.text = title
        timeLabel.text = time
    }
    
    func setUpViews(){
        
        self.selectionStyle = .none
        
        contentView.backgroundColor = .black
        containerView.layer.cornerRadius = 20
        containerView.backgroundColor = UIColor(hex: 0x0a0f17)
        
        nameLabel.font = UIFont.appFont(weight: .regular, size: 14)
        nameLabel.textColor = .white
        
        titleLabel.font = UIFont.appFont(weight: .regular, size: 14)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail
        
        timeLabel.font = UIFont.appFont(weight: .regular, size: 13)
        timeLabel.textColor = ConfigColor.main_setting2
        
        popButton.setImage(UIImage(named: "pop_button"), for: .normal)
        popButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
    }
    
    func setUpConstraints(){
        contentView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(popButton)
        
        
        containerView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(122)
        }
        
        nameLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(16)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
        }
        
        timeLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(16)
            $0.size.equalTo(CGSize(width: 150, height: 20))
        }
        
        popButton.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.right.equalToSuperview().offset(-16)
            $0.size.equalTo(CGSize(width: 50, height: 20))
        }
        
        
    }
    
    @objc func addButtonTapped() {
        if let text = nameLabel.text {
            let globalFrame = popButton.convert(popButton.bounds, to: nil)
            let buttonY = globalFrame.origin.y
            buttonActionHandler?(text, Int(buttonY))
        }
       
    }
}
