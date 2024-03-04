//
//  ViewControllerA.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 01/03/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//


import UIKit
import RxSwift

class ViewControllerA: UIViewController {
    let disposeBag = DisposeBag()
//    let subject = PublishSubject<String>()
    
    let modelManager = ModelManagerImpl.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Phát ra sự kiện từ ViewControllerA
  
        print("====== vào")
        // Chuyển sang ViewControllerB khi nhấn nút
        let button = UIButton(type: .system)
        button.setTitle("Go to ViewControllerB", for: .normal)
        button.addTarget(self, action: #selector(goToViewControllerB), for: .touchUpInside)
        button.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        view.addSubview(button)
        
        setupRx()
    }
    
    @objc func goToViewControllerB() {
        modelManager.testPublishSubjectPublisher.onNext("New value")
//        modelManager.testBehaviorRelayPublisher.accept("New value")
        let viewControllerB = ViewControllerB()
//        viewControllerB.subject = subject // Chuyển đối tượng PublishSubject sang ViewControllerB
        navigationController?.pushViewController(viewControllerB, animated: true)
    }
    
    private func setupRx() {
        modelManager.testPublishSubjectPublisher
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, value in
                print("======> 1: \(value)")
            })
            .disposed(by: disposeBag)
        
//        modelManager.testBehaviorRelayPublisher
//            .withUnretained(self)
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { owner, value in
//                print("======> Behavior 1: \(value)")
//            })
//            .disposed(by: disposeBag)
    }
}
