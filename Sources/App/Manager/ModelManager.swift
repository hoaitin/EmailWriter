import RxSwift
import RxCocoa



final class ModelManagerImpl {
    
    static let shared: ModelManagerImpl = .init()
    
    let testPublishSubjectPublisher: PublishSubject<String> = {
        .init()
    }()
    
    let testBehaviorRelayPublisher: BehaviorRelay<String> = {
        .init(value: "Init value")
    }()
    
    let typePublishSubjectPublisher: PublishSubject<[ValueOption]> = {
        .init()
    }()
    
}

// Relay subject


extension ModelManagerImpl {
    
//    func update(data: String) {
//        testBehaviorRelayPublisher.accept(data)
//    }
}
