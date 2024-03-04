import SnapKit
import RxSwift
import UIKit

class TestViewController: BaseViewController {
    // Khoi tao bien, views
    
    private lazy var label = UILabel()
    private lazy var labelButton1 = UIButton()
    private lazy var labelButton2 = UIButton()
    
    private lazy var newView = UIView()
    
    var isTruth = false
}

extension TestViewController {
    
    override func setupViews() {
        super.setupViews()
        
        // MARK: Setup views
        label.text = "sda"
        
        newView.backgroundColor = .purple
        
        // MARK: Setup constraints
        addTabbarHeader()
        view.addSubview(label)
        view.addSubview(newView)
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        newView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    override func setupRx() {
        super.setupRx()
        
        labelButton1.rx.tap
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, _ in
                
            })
            .disposed(by: dispose)
        
        labelButton2.rx.tap
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, _ in
                
            })
            .disposed(by: dispose)
    }
}
