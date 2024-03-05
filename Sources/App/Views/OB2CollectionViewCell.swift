//
//  OB2CollectionViewCell.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 05/03/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation
import UIKit

class OB2CollectionViewCell: UICollectionViewCell {
    static var id = "OB2CollectionViewCell"
    private lazy var backgroundImage = UIImageView()
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
        
        backgroundImage.image = R.image.image_ob_2()
        backgroundImage.contentMode = .scaleAspectFill
        
        titleLabel.text = "Advanced writing \noptions"
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.appFont(weight: .semibold, size: 28)
     
    }
    
    func setUpConstraints(){
        addSubview(backgroundImage)
        addSubview(titleLabel)
        
        backgroundImage.snp.makeConstraints{
            $0.top.equalToSuperview().inset(90)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(452)
        }
        
        titleLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-180)
            $0.height.equalTo(80)
        }
        
      
    }
  
     
}
