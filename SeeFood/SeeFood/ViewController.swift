//
//  ViewController.swift
//  SeeFood
//
//  Created by Jerry on 10/27/18.
//  Copyright © 2018 AppTweaker. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            imageView.image = userPickedImage
            imagePicker.dismiss(animated: true, completion: nil)
            
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("Couldn't convert UIImage to CIImage!")
            }
            
            detect(image: ciImage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(image: CIImage) {
        guard let vmodel = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Cannot load ML model")
        }
        
        let request = VNCoreMLRequest(model: vmodel){
            request, error in
            
            guard let results = request.results as? [VNClassificationObservation], let topResult = results.first
                else {
                    fatalError("Unexpected result type from VNCoreMLRequest")
            }
            
            if topResult.identifier.count > 0 {
                DispatchQueue.main.async {
                    self.navigationItem.title = topResult.identifier
                    self.navigationController?.navigationBar.barTintColor = UIColor.blue
                    self.navigationController?.navigationBar.isTranslucent = false
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
}

