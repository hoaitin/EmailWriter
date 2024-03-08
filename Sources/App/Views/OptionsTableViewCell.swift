//
//  OptionsTableViewCell.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 26/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import RxSwift
import PanModal

class OptionsTableViewCell: UITableViewCell {
    static let id = "OptionsTableViewCell"
    private lazy var titleLabel = UILabel()
    private lazy var iconImage = UIImageView()
    private lazy var contentCollecttionView = UIView()
    private lazy var optionsCollectionView = UICollectionView()
    var typeOption: TypeOptions?
    var options: [Option] = []
    var option: Option?
    var valueOptions: [ValueOption] = []
    var delegate: CellDelegate?
    private var selectedIndexPath: IndexPath?
    
    let modelManager = ModelManagerImpl.shared
    let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        setUpConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(typeOption: TypeOptions){
        titleLabel.text = typeOption.name
        self.typeOption = typeOption
        self.options = typeOption.data
        if typeOption.icon  != "" {
            iconImage.image = UIImage(named: typeOption.icon)
        }
        
        if let jsonString = UserDefaults.standard.string(forKey: ConfigKey.typeOptions),
           let jsonData = jsonString.data(using: .utf8),
           let valueOptions = try? JSONDecoder().decode([ValueOption].self, from: jsonData) {
            self.valueOptions = valueOptions
            if typeOption.id == "output_language" {
                self.options = [valueOptions[0].option]
                self.option =   valueOptions[0].option
                self.selectedIndexPath = IndexPath(item: 0, section: 0)
            }  else {
                if let index = self.valueOptions.firstIndex(where: { $0.id == self.typeOption?.id }) {
                    if let indexPath = self.options.firstIndex(where: { $0.id == self.valueOptions[index].option.id }) {
                        self.selectedIndexPath = IndexPath(item: indexPath, section: 0)
                    }
                }
            }
        }
      
        optionsCollectionView.reloadData()
        setUpRx()
       
    }
    
    func setUpViews(){
        contentView.backgroundColor = .black

        titleLabel.textColor = .white
        titleLabel.font = UIFont.appFont(weight: .medium, size: 15)
        iconImage.contentMode = .scaleAspectFill

        let layout = AlignLeftFlowLayout()
//        layout.scrollDirection =  .vertical
//        layout.minimumLineSpacing = 12
//        layout.minimumInteritemSpacing = 8
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
//        layout.itemSize = CGSize(width: 120, height: 35)
              
        self.optionsCollectionView = UICollectionView(frame: contentView.frame, collectionViewLayout: layout)
        self.optionsCollectionView.backgroundColor = .black
        self.optionsCollectionView.register(OptionCollectionViewCell.self, forCellWithReuseIdentifier: OptionCollectionViewCell.id)
        self.optionsCollectionView.register(OptionCountryCollectionViewCell.self, forCellWithReuseIdentifier: OptionCountryCollectionViewCell.id)
        self.optionsCollectionView.showsHorizontalScrollIndicator = false
        self.optionsCollectionView.dataSource = self
        self.optionsCollectionView.delegate = self
    }
    
    func setUpConstraints(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(iconImage)
        contentView.addSubview(contentCollecttionView)
        contentCollecttionView.addSubview(optionsCollectionView)
        
        titleLabel.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(18)
        }
        
        iconImage.snp.makeConstraints{
            $0.leading.equalTo(titleLabel.snp.trailing).inset(-5)
            $0.top.equalToSuperview()
            $0.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        contentCollecttionView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        optionsCollectionView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
    
    }
    private func setUpRx() {
        modelManager.typePublishSubjectPublisher
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, value in
                if value.count > 0 {
                    owner.valueOptions = value
                    if owner.typeOption?.id == "output_language" {
                        owner.options = [ owner.valueOptions[0].option]
                        owner.option =    owner.valueOptions[0].option
                        owner.optionsCollectionView.reloadData()
                      
                    }
                }
               
            })
            .disposed(by: disposeBag)
    }
    
}

extension OptionsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if typeOption?.id == "output_language"  {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionCountryCollectionViewCell.id, for: indexPath) as? OptionCountryCollectionViewCell else {
                        return .init()
                }
            let item = options[indexPath.row]
            cell.setData(icon: item.image, name: item.name)
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionCollectionViewCell.id, for: indexPath) as? OptionCollectionViewCell else {
                    return .init()
            }
                
        let item = options[indexPath.row]
        cell.setData(icon: item.image, name: item.name)
        
        if indexPath.item == selectedIndexPath?.item {
            cell.setAction()
        }else{
            cell.hiddenAction()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if typeOption?.id == "output_language"  {
             delegate?.presentPanModal()
            
        }else {
            if let previousSelectedIndexPath = selectedIndexPath,
               let previousSelectedCell = collectionView.cellForItem(at: previousSelectedIndexPath) as? OptionCollectionViewCell {
                if !previousSelectedCell.isSelected {
                    previousSelectedCell.hiddenAction()
                }
            }

            // Xử lý lựa chọn mới
            if let newSelectedCell = collectionView.cellForItem(at: indexPath) as? OptionCollectionViewCell {
                if newSelectedCell.isSelected {
                    let option = options[indexPath.item]
                    self.option = option
                    if let index = valueOptions.firstIndex(where: { $0.id == typeOption?.id }) {
                        self.valueOptions[index].option = option
                        modelManager.typePublishSubjectPublisher.onNext(valueOptions)
                        if let jsonData = try? JSONEncoder().encode(valueOptions),
                           let jsonString = String(data: jsonData, encoding: .utf8) {
                            // Lưu JSON dưới dạng chuỗi trong UserDefaults
                            UserDefaults.standard.set(jsonString, forKey: ConfigKey.typeOptions)
                        }
                    }
                    newSelectedCell.setAction()
                }
            }

            selectedIndexPath = indexPath
        }
        
        // Huỷ bỏ lựa chọn trước đó nếu có
       

    }
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let label = UILabel(frame: CGRect.zero)
            label.text = options[indexPath.row].name
            label.sizeToFit()
            return CGSize(width: label.frame.width + 46, height: 35)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//           return 1
//    }
    
}
