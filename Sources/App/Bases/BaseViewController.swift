import SnapKit
import RxSwift
import UIKit
import PanModal

class BaseViewController: UIViewController {
    public lazy var headerView = TabbarHeaderView()
    
    let dispose = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.navigationController?.navigationBar.isHidden = true
        setupViews()
        setupRx()
    }
    
    @objc dynamic func setupViews() {
        
    }
    
    @objc dynamic func setupRx() {
        
    }
    
    func addTabbarHeader() {
        headerView.rightButton.addTarget(self, action: #selector(nextUpGrade), for: .touchUpInside)
        
        view.addSubview(headerView)
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.snp_topMargin)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
    @objc func nextUpGrade(){
        let viewDS = DSViewController()
        present(viewDS, animated: true)
    }
}
