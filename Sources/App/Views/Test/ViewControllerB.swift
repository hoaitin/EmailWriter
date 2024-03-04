//
//  ViewControllerB.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 01/03/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ViewControllerB: UIViewController {
//    var subject: PublishSubject<String>? 
    private lazy var tittLabel = UILabel()
    private lazy var backView = UIButton()
    
    let modelManager = ModelManagerImpl.shared
    // Subject để nhận dữ liệu từ ViewControllerA
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        backView.setTitle("back", for: .normal)
        backView.setTitleColor(.white, for: .normal)
        backView.addTarget(self, action: #selector(backViewButton), for: .touchUpInside)
        
        view.addSubview(tittLabel)
        view.addSubview(backView)
        
        tittLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 100, height: 30))
        }
        
        backView.snp.makeConstraints{
            $0.top.equalTo(tittLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 100, height: 30))
        }
        
//        // Đăng ký để nhận dữ liệu từ ViewControllerA
//        subject?.subscribe(onNext: { [weak self] data in
//            print("Received data in ViewControllerB: \(data)")
//            self?.tittLabel.text = data
//          }).disposed(by: disposeBag)
        
        setupRx()
    }
    
    @objc func backViewButton() {
        modelManager.testPublishSubjectPublisher.onNext("Publish new value")
//        modelManager.testBehaviorRelayPublisher.accept("Behavior new value")
        navigationController?.popViewController(animated: true)
    }
    
    private func setupRx() {
        modelManager.testPublishSubjectPublisher
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, value in
                owner.tittLabel.text = value
                print("======> 2: \(value)")
            })
            .disposed(by: disposeBag)
      
        
//        modelManager.testBehaviorRelayPublisher
//            .withUnretained(self)
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { owner, value in
//                print("======> Behavior 2: \(value)")
//            })
//            .disposed(by: disposeBag)
    }
}
