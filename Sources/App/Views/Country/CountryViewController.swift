//
//  LagViewController.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 29/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//



import Foundation
import UIKit
import PanModal
import GrowingTextView
import Speech
import RxSwift

class CountryViewController: UIViewController , SFSpeechRecognizerDelegate, SpeechRecognitionDelegate{
    private lazy var dragIndicator = UIView()
    private lazy var headerLabel = UILabel()
    private lazy var contentSearchView = UIView()
    private lazy var searchTextField = UITextField()
    private lazy var lagTableView = UITableView()
    private var selectedIndexPath: IndexPath?
    private var countries:[Country] = []
    private var country:Country?
    private var dataCountries:[Country] = []
    private var dictationButton = UIButton()
    private let speechManager = SpeechRecognitionManager()
    
    var valueOptions: [ValueOption] = []
    let modelManager = ModelManagerImpl.shared
    let disposeBag = DisposeBag()
   
    override func viewDidLoad() {
        
        setUpViews()
        setUpConstraints()
        setData()
      
    }
    
    func setUpViews() {
        view.backgroundColor = .black
        
        dragIndicator.backgroundColor =  ConfigColor.gray_tab
        dragIndicator.layer.cornerRadius = 2.5
        
        headerLabel.text = "Select language"
        headerLabel.textColor = .white
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.appFont(weight: .medium, size: 16)
        
        contentSearchView.backgroundColor = ConfigColor.main_bg
        contentSearchView.layer.cornerRadius = 10
        
        searchTextField.font = UIFont.appFont(weight: .regular, size: 17)
        searchTextField.textColor = .white
        let attributedPlaceholder = NSAttributedString(string:  "Search", attributes: [NSAttributedString.Key.foregroundColor: ConfigColor.gray_text_app])
        searchTextField.attributedPlaceholder = attributedPlaceholder
        searchTextField.addTarget(self, action: #selector(onChangeSearch(_: )), for: .editingChanged)
        
        let leftImageView = UIImageView(image: UIImage(named: "search_glyph"))
        leftImageView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        leftImageView.contentMode = .scaleAspectFit
        searchTextField.leftView = leftImageView
        searchTextField.leftViewMode = .always
        
        dictationButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        dictationButton.setImage(R.image.search_dictation(), for: .normal)
        dictationButton.addTarget(self, action: #selector(hanleSpeedToText), for: .touchUpInside)
        searchTextField.rightView =  dictationButton
        searchTextField.rightViewMode = .always
       
        self.lagTableView.backgroundColor = .black
        self.lagTableView.separatorStyle = .none
        self.lagTableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.id)
        self.lagTableView.dataSource = self
        self.lagTableView.delegate = self
    }
        
    func setUpConstraints() {
        view.addSubview(dragIndicator)
        view.addSubview(headerLabel)
       
        view.addSubview(contentSearchView)
        contentSearchView.addSubview(searchTextField)
        view.addSubview(lagTableView)
        
        dragIndicator.snp.makeConstraints{
            $0.top.equalToSuperview().inset(15)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 80, height: 5))
        }
        
        headerLabel.snp.makeConstraints{
            $0.top.equalTo(dragIndicator.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        contentSearchView.snp.makeConstraints{
            $0.top.equalTo(headerLabel.snp.bottom).offset(12)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.height.equalTo(36)
        }
        
        searchTextField.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(8)
        }
        
        lagTableView.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(searchTextField.snp.bottom).offset(12)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    func setData(){
        if let countries = RequestApi.share.getFileJsonCountry() {
            self.countries = countries
            self.dataCountries = countries
            if let jsonString = UserDefaults.standard.string(forKey: ConfigKey.typeOptions),
               let jsonData = jsonString.data(using: .utf8),
               let valueOptions = try? JSONDecoder().decode([ValueOption].self, from: jsonData) {
                self.valueOptions = valueOptions
                print(self.valueOptions[0].id)
                if let index = self.countries.firstIndex(where: { $0.name == self.valueOptions[0].option.id }) {
                    self.selectedIndexPath = IndexPath(item: index, section: 0)
                    self.country = countries[index]
                    lagTableView.reloadData()
                }
            }
           
        }
    }
    
    @objc func onChangeSearch(_ textField: UITextField){
        if let searchText = textField.text{
            if(searchText.isEmpty){
                self.countries = self.dataCountries
                self.lagTableView.reloadData()
            }else{
                let dataContriesSearch = self.dataCountries.filter{$0.name.contains(searchText)}
                self.countries = dataContriesSearch
                self.lagTableView.reloadData()
            }
        }
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
    
    func authorizationStatusChanged(isAuthorized: Bool) {
        dictationButton.isEnabled = isAuthorized
    }
    
    func didReceiveTranscription(transcription: String) {
        searchTextField.text = transcription
    }
    
 
    
}



extension CountryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.id, for: indexPath) as? CountryTableViewCell else {
            return .init()
        }
        
        let country = countries[indexPath.row]
        cell.setData(name: "\(country.name) - \(country.language)", icon: country.flag)
        
        if indexPath.item == selectedIndexPath?.item {
            cell.setAction()
        }else{
            cell.hiddenAction()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previousSelectedIndexPath = selectedIndexPath {
            if let previousSelectedCell = tableView.cellForRow(at: previousSelectedIndexPath) as?
                CountryTableViewCell {
                if(!previousSelectedCell.isSelected){
                  previousSelectedCell.hiddenAction()
                }
              
            }
        }
    
        if let newSelectedCell = tableView.cellForRow(at: indexPath) as? CountryTableViewCell {
            if newSelectedCell.isSelected {
               let country = countries[indexPath.row]
                self.country = country
                self.valueOptions[0].option = Option(id: country.name, name: "\(country.name) - \(country.language)", image: country.flag)
               
                ModelManagerImpl.shared.typePublishSubjectPublisher.onNext(self.valueOptions)
                if let jsonData = try? JSONEncoder().encode(valueOptions),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                    // Lưu JSON dưới dạng chuỗi trong UserDefaults
                    UserDefaults.standard.set(jsonString, forKey: ConfigKey.typeOptions)
                }
                newSelectedCell.setAction()
            }
        }
        selectedIndexPath = indexPath
    }
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}

extension CountryViewController: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil // Trả về UIScrollView nếu bạn muốn cho phép cuộn khi modal mở rộng
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(view.frame.height - 50) // Chiều cao của modal khi ở trạng thái short
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(20) // Chiều cao tối đa của modal khi ở trạng thái long
    }
    
    var showDragIndicator: Bool {
        return false
    }
   
}
