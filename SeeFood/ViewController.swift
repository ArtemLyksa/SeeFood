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
}

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
         let pickedImage = info[.originalImage] as? UIImage
        resultImageView.image = pickedImage
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UINavigationControllerDelegate {
    
}
