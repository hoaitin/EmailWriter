//
//  OBViewController.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 27/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation
import SwiftUI

class OBViewController: UIViewController{
    private lazy var continueButton = UIButton()
    private lazy var obColectionView = UICollectionView()
    
    private var obNumber = 1
    var currentIndex = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpViews()
        setUpConstraints()
        getData()
    }
    
    func setUpViews() {
        view.backgroundColor = .black
        
        continueButton.setImage(R.image.icon_scan(), for: .normal)
        continueButton.backgroundColor = ConfigColor.green_main_app
        continueButton.layer.cornerRadius = 20
        continueButton.addTarget(self, action: #selector(handleClickNextView), for: .touchUpInside)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: view.frame.width , height: view.frame.height)
        layout.scrollDirection = .horizontal
        self.obColectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        self.obColectionView.register(OBCollectionViewCell.self, forCellWithReuseIdentifier: OBCollectionViewCell.id)
        self.obColectionView.isScrollEnabled = false
        self.obColectionView.contentMode = .scaleAspectFill
        self.obColectionView.backgroundColor = ConfigColor.main_bg
        self.obColectionView.dataSource = self
        self.obColectionView.delegate = self
        self.obColectionView.contentInsetAdjustmentBehavior = .never
        obColectionView.allowsMultipleSelection = false
        obColectionView.isPagingEnabled = true
    }
    
    func setUpConstraints() {
    
        view.addSubview(obColectionView)
        view.addSubview(continueButton)
        
        continueButton.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-90)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 100, height: 60))
        }
        
        obColectionView.snp.makeConstraints{
            $0.edges.size.equalToSuperview()
        }
        
    }

    @objc func handleClickNextView(){
        
        currentIndex += 1
        if obNumber < 3 {
            obNumber += 1
        
        let index = IndexPath(row: currentIndex, section: 0)
        obColectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }else{
           let view = DSViewController()
            navigationController?.pushViewController(view, animated: true)
        }
    }
    func getData(){
      
    }
    
}
extension OBViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OBCollectionViewCell.id, for: indexPath) as? OBCollectionViewCell else {
                return .init()
            }
            return cell
       
    }
    
}
