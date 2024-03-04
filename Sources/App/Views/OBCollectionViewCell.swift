//
//  OBCollectionViewCell.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 27/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import UIKit

class OBCollectionViewCell: UICollectionViewCell {
    static var id = "OBCollectionViewCell"
    private lazy var titleLabel = UILabel()
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
        setUpConstraints()
    }
    
    
    func setUpView(){
        contentView.backgroundColor = .black
        
        titleLabel.text = "Learn \n with example"
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.appFont(weight: .semibold, size: 28)
     
    }
    
    func setUpConstraints(){
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-180)
            $0.height.equalTo(80)
        }
        
      
    }
  
     
}
