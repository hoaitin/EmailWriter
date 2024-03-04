import SnapKit
import RxSwift
import UIKit

class BaseViewController: UIViewController {
    
    public lazy var headerView = UIView()
    
    let dispose = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupRx()
        
        view.backgroundColor = ConfigColor.backgroundView
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc dynamic func setupViews() {
        
    }
    
    @objc dynamic func setupRx() {
        
    }
    
    func addTabbarHeader() {
        headerView.backgroundColor = .orange
        
        view.addSubview(headerView)
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.snp_topMargin)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}
