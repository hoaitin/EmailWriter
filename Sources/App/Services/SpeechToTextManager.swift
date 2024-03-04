//
//  SpeechToTextManager.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 22/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//
import UIKit
import AVFoundation
import Speech

protocol SpeechRecognitionDelegate: AnyObject {
    func authorizationStatusChanged(isAuthorized: Bool)
    func didReceiveTranscription(transcription: String)
}

class SpeechRecognitionManager: NSObject {
    weak var delegate: SpeechRecognitionDelegate?
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
     let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioSession = AVAudioSession.sharedInstance()
    
    override init() {
        super.init()
        speechRecognizer.delegate = self
    }
    
    func requestAuthorization() {
        SFSpeechRecognizer.requestAuthorization { [weak self] authStatus in
            guard let self = self else { return }
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.delegate?.authorizationStatusChanged(isAuthorized: true)
                default:
                    self.delegate?.authorizationStatusChanged(isAuthorized: false)
                }
            }
        }
    }
    
    func startRecording() throws {
           if audioEngine.isRunning {
               audioEngine.stop()
               recognitionRequest?.endAudio()
           }
           
           try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
           try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
           
           recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
           
           guard let recognitionRequest = recognitionRequest else {
               fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
           }
           
           recognitionRequest.shouldReportPartialResults = true
           
           let inputNode = audioEngine.inputNode
           recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self] result, error in
               guard let self = self else { return }
               
               var isFinal = false
               
               if let result = result {
                   self.delegate?.didReceiveTranscription(transcription: result.bestTranscription.formattedString)
                   isFinal = result.isFinal
               }
               
               if error != nil || isFinal {
                   inputNode.removeTap(onBus: 0)
                   self.audioEngine.stop()
                   recognitionRequest.endAudio()
                   self.recognitionRequest = nil
                   self.recognitionTask = nil
               }
           }
           
           let recordingFormat = inputNode.outputFormat(forBus: 0)
           inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
               self.recognitionRequest?.append(buffer)
           }
           
           audioEngine.prepare()
           try audioEngine.start()
       }
       
       func stopRecording() {
           audioEngine.stop()
           recognitionRequest?.endAudio()
       }
}

extension SpeechRecognitionManager: SFSpeechRecognizerDelegate {
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        // Handle availability changes if needed
    }
}
