//
//  TextToSpeechManager.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 23/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation
import AVFAudio

class TextToSpeechManager {
    public static let share: TextToSpeechManager = TextToSpeechManager()
    
    private init(){}
    
    
    let speechSynthesizer = AVSpeechSynthesizer()

       func speak(text: String) {
           let speechUtterance = AVSpeechUtterance(string: text)
           speechUtterance.rate = AVSpeechUtteranceDefaultSpeechRate
           speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US") // Thiết lập ngôn ngữ của giọng nói
           speechSynthesizer.speak(speechUtterance)
       }

       func stopSpeaking() {
           speechSynthesizer.stopSpeaking(at: .immediate)
       }

       func pauseSpeaking() {
           speechSynthesizer.pauseSpeaking(at: .immediate)
       }

       func continueSpeaking() {
           speechSynthesizer.continueSpeaking()
       }
    
}
