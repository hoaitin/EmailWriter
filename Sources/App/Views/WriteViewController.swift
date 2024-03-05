//
//  WriteViewController.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 20/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import UIKit
import SnapKit
import StoreKit
import PanModal
import GrowingTextView
import Speech
import RxSwift

class WriteViewController: BaseViewController , GrowingTextViewDelegate , SFSpeechRecognizerDelegate, SpeechRecognitionDelegate {
   
     private lazy var segmentedControl = UISegmentedControl(items: ["Write", "Reply"])
     private lazy var contentView = UIView()
     private lazy var numberCharLabel = UILabel()
     private lazy var closeButton = UIButton()
     private lazy var textView = GrowingTextView()
     private lazy var writingOptionView = WritingOptionView()
     private lazy var cameraButton = UIButton()
     private lazy var writeButton = UIButton()
     private lazy var micButton = UIButton()
    
     private let speechManager = SpeechRecognitionManager()
     private let keyboardAlertView = ToolKeyBoardView(frame:CGRectMake(0,0,320,45))
     let cameraToTextManager = CameraToTextManager()
     var valueOptions:[ValueOption] = []
     let maximumCharacterCount = 2500
     let disposeBag = DisposeBag()
     let modelManager = ModelManagerImpl.shared
    
    override func setupViews() {
        super.setupViews()
        
        textView.delegate = self
        speechManager.delegate = self
        
        segmentedControl.selectedSegmentTintColor = ConfigColor.green_main_app
        segmentedControl.backgroundColor = ConfigColor.black_control_app
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        
        numberCharLabel.text = "0/2500"
        numberCharLabel.textColor = ConfigColor.gray_char_app
        numberCharLabel.font = UIFont.appFont(weight: .regular , size: 13)
        
        closeButton.setImage(R.image.icon_close_write(), for: .normal)
        closeButton.isHidden = true
        closeButton.addTarget(self, action: #selector(handleClearText), for: .touchUpInside)
        
        textView.backgroundColor = .black
        textView.placeholder = "Example: \nHi Liam! Let s have a call today and discuss \nabout the progress of the project."
        textView.font = UIFont.appFont(weight: .regular, size: 16)
        textView.textColor = .white
        textView.tintColor = .clear
        textView.trimWhiteSpaceWhenEndEditing = true
        keyboardAlertView.backgroundColor = .black
        keyboardAlertView.doneButton.addTarget(self, action: #selector(handleCloseKeyBoard), for: .touchUpInside)
        textView.inputAccessoryView = keyboardAlertView
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

       
        writingOptionView.backgroundColor = ConfigColor.gray_tab
        writingOptionView.layer.cornerRadius = 20
        writingOptionView.selectTypeButton.addTarget(self, action: #selector(handleViewOptions), for: .touchUpInside)
      
        cameraButton.setImage(R.image.icon_camera(), for: .normal)
        cameraButton.backgroundColor = ConfigColor.gray_tab
        cameraButton.layer.cornerRadius = 25
        
        micButton.setImage(R.image.icon_mic(), for: .normal)
        micButton.backgroundColor = ConfigColor.gray_tab
        micButton.layer.cornerRadius = 25
        micButton.addTarget(self, action: #selector(hanleSpeedToText), for: .touchUpInside)
        
        writeButton.layer.cornerRadius = 25
        writeButton.clipsToBounds = true
        writeButton.setTitle("Write", for: .normal)
        writeButton.titleLabel?.font = UIFont.appFont(weight: .medium, size: 18)
        writeButton.setTitleColor(.white, for: .normal)
        writeButton.setImage(R.image.icon_feature_improve(), for: .normal)
        writeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        writeButton.backgroundColor = ConfigColor.green_main_app
        writeButton.addTarget(self, action: #selector(handleNextViewEmailResult), for: .touchUpInside)
        
        addTabbarHeader()
        view.addSubview(segmentedControl)
        view.addSubview(contentView)
        contentView.addSubview(numberCharLabel)
        contentView.addSubview(closeButton)
        contentView.addSubview(textView)
        view.addSubview(writingOptionView)
        view.addSubview(cameraButton)
        view.addSubview(writeButton)
        view.addSubview(micButton)
        
        segmentedControl.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom).inset(-12)
            $0.size.equalTo(CGSize(width: 250, height: 35))
        }
        
        contentView.snp.makeConstraints{
            $0.top.equalTo(segmentedControl.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(writingOptionView.snp.top).inset(-20)
        }
        
        numberCharLabel.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.equalTo(CGSize(width: 200, height: 20))
        }
        
        closeButton.snp.makeConstraints{
            $0.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        textView.snp.makeConstraints{
            $0.top.equalTo(numberCharLabel.snp.bottom).offset(12)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        
        writingOptionView.snp.makeConstraints{
            $0.bottom.equalTo(writeButton.snp.top).inset(-25)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(80)
        }
        
        cameraButton.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(20)
            $0.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        writeButton.snp.makeConstraints{
            $0.bottom.equalTo(view.snp_bottomMargin).inset(20)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 220, height: 50))
        }
        
        micButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(20)
            $0.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        setData()
    }
    
    func setData(){
        // Nếu có chuỗi JSON đã lưu trong UserDefaults
        if let jsonString = UserDefaults.standard.string(forKey: ConfigKey.typeOptions),
           let jsonData = jsonString.data(using: .utf8),
           let valueOptions = try? JSONDecoder().decode([ValueOption].self, from: jsonData) {
            // Sử dụng giá trị đã giải mã
            self.valueOptions = valueOptions
            writingOptionView.setData(itemLag: valueOptions[0].option,
                                      itemType: valueOptions[1].option,
                                      itemLength: valueOptions[2].option,
                                      itemTone: valueOptions[3].option,
                                      itemEmoji: valueOptions[4].option)
        } else {
            // Nếu không có chuỗi JSON trong UserDefaults, yêu cầu từ API và lưu vào UserDefaults
            if let typeOption = RequestApi.share.getFileJsonTypeOptions() {
                let valueOptions = typeOption.compactMap { item in
                    return item.data.first.map { ValueOption(id: item.id, option: $0) }
                }
                if let jsonData = try? JSONEncoder().encode(valueOptions),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                    UserDefaults.standard.set(jsonString, forKey: ConfigKey.typeOptions)
                }
                writingOptionView.setData(itemLag: valueOptions[0].option,
                                          itemType: valueOptions[1].option,
                                          itemLength: valueOptions[2].option,
                                          itemTone: valueOptions[3].option,
                                          itemEmoji: valueOptions[4].option)
            }
        }

    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
         if let userInfo = notification.userInfo,
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
             // Thay đổi kích thước của GrowingTextView khi bàn phím xuất hiện
//             textView.frame.size.height -= (keyboardSize.height)
             keyboardAlertView.isHidden = false
             
             
         }
        
        contentView.snp.updateConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(writingOptionView.snp.top).inset(-150)
        }
     }

     @objc func keyboardWillHide(notification: NSNotification) {
         if let userInfo = notification.userInfo,
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                     // Thay đổi kích thước của GrowingTextView khi bàn phím biến mất
             keyboardAlertView.isHidden = true
         }
         contentView.snp.updateConstraints {
             $0.top.equalTo(segmentedControl.snp.bottom).offset(15)
             $0.leading.trailing.equalToSuperview().inset(16)
             $0.bottom.equalTo(writingOptionView.snp.top).inset(-20)
         }
     }
    
    func textViewDidChange(_ textView: UITextView) {
         
           
           if let text = textView.text {
               if text.count > maximumCharacterCount {
                 
                   let trimmedText = String(text.prefix(maximumCharacterCount))
                 
                   textView.text = trimmedText
                  
               }else {
                   numberCharLabel.text = "\(text.count)/\(maximumCharacterCount)"
               }
               
               closeButton.isHidden = text.count == 0 ? true : false
           }
       }
    
    @objc func handleClearText(){
        textView.text = ""
        closeButton.isHidden = true
        numberCharLabel.text = "0/\(maximumCharacterCount)"
    }
    
    @objc func handleCloseKeyBoard(){
        view.endEditing(true)
    }
    
    @objc func handleNextViewEmailResult() {
//        let emailVC = EmailResultViewController()
//        navigationController?.pushViewController(emailVC, animated: true)
        
          let countryView = LagViewController()
          presentPanModal(countryView)
    }
    
    @objc func handleViewOptions(){
        let view = TypeOptionsViewController()
        modelManager.typeBehaviorRelayPublisher.accept(valueOptions)
        presentPanModal(view)
    }
    
    @objc func hanleSpeedToText() {
        speechManager.requestAuthorization()
        if speechManager.audioEngine.isRunning {
            speechManager.stopRecording()
        } else {
            do {
                try speechManager.startRecording()
            } catch {
                print("Error starting recording: \(error)")
            }
        }
    }
    
    @objc func handleCameraText() {
        cameraToTextManager.startCameraToText { detectedText in
            if let detectedText = detectedText {
                // Xử lý văn bản đã nhận dạng ở đây
                print("Detected text: \(detectedText)")
            } else {
                // Xử lý trường hợp không nhận dạng được văn bản
                print("Could not recognize text")
            }
        }
    }
    
    
    func authorizationStatusChanged(isAuthorized: Bool) {
        micButton.isEnabled = isAuthorized
    }
    
    func didReceiveTranscription(transcription: String) {
        textView.text = transcription
    }
    
    override func setupRx() {
        super.setupRx()
        
        writeButton.rx.tap
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, _ in
                owner.navigationController?.pushViewController(EmailResultViewController(), animated: true)
            })
            .disposed(by: disposeBag)
        
        modelManager.typeBehaviorRelayPublisher
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, value in
                if value.count > 0 {
                    owner.valueOptions = value
                    owner.writingOptionView.setData(itemLag: owner.valueOptions[0].option, itemType: owner.valueOptions[1].option, itemLength: owner.valueOptions[2].option, itemTone: owner.valueOptions[3].option, itemEmoji: owner.valueOptions[4].option)
                }
                
                
               
            })
            .disposed(by: disposeBag)
    }

}



