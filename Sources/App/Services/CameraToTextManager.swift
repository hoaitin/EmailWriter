//
//  CameraToTextManager.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 01/03/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation
import UIKit
import Vision

import UIKit
import Vision

import UIKit
import Vision

class CameraToTextManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private var imagePicker: UIImagePickerController?
    private var completion: ((String?) -> Void)?

    override init() {
        super.init()
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
    }

    func startCameraToText(completion: @escaping (String?) -> Void) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            completion(nil)
            return
        }
        self.completion = completion
        imagePicker?.sourceType = .camera
        UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker!, animated: true, completion: nil)
    }

    private func recognizeText(in image: UIImage) {
        guard let cgImage = image.cgImage else {
            completion?(nil)
            return
        }

        let request = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                self.completion?(nil)
                return
            }

            var detectedText = ""
            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else { continue }
                detectedText += topCandidate.string + "\n"
            }

            self.completion?(detectedText)
        }

        request.recognitionLevel = .accurate

        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try requestHandler.perform([request])
        } catch {
            self.completion?(nil)
            print("Error recognizing text: \(error.localizedDescription)")
        }
    }

    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)

        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            completion?(nil)
            return
        }

        recognizeText(in: image)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        completion?(nil)
    }
}
