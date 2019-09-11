//
//  ViewController.swift
//  SeeFood
//
//  Created by Artem Lyksa on 9/10/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {

    @IBOutlet weak var resultImageView: UIImageView!
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        imagePickerController.allowsEditing = false
    }

    @IBAction func cameraBarButtonAction(_ sender: UIBarButtonItem) {
        present(imagePickerController, animated: true, completion: nil)
    }
    
    private func detect(image: UIImage) {
        guard
            let ciImage = CIImage(image: image),
            let model = try? VNCoreMLModel(for: Inceptionv3().model)
        else {
            fatalError("Could not convert picked image to CIImage")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Failed to proccess request results")
            }
            print(results)
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage)
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let pickedImage = info[.originalImage] as? UIImage else { return }
        resultImageView.image = pickedImage
        detect(image: pickedImage)
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UINavigationControllerDelegate {
    
}
