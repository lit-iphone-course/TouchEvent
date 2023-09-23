//
//  ViewController.swift
//  TouchEvent
//
//  Created by Owner on 2023/09/24.
//

import UIKit
import PhotosUI

class ViewController: UIViewController, PHPickerViewControllerDelegate {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var changeBackgroundButton: UIButton!
    
    var selectedImageName: String = ""
    var imageViewArray: [UIImageView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeBackgroundButton.layer.cornerRadius = 6
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let location: CGPoint = touch.location(in: self.view)
        
        if selectedImageName != "" {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
            imageView.image = UIImage(named: selectedImageName)
            imageView.center = CGPoint(x: location.x, y: location.y)
            self.view.addSubview(imageView)
            imageViewArray.append(imageView)
        }
    }
    
    @IBAction func selectImage1() {
        selectedImageName = "flower"
    }
    
    @IBAction func selectImage2() {
        selectedImageName = "cloud"
    }
    
    @IBAction func selectImage3() {
        selectedImageName = "heart"
    }
    
    @IBAction func selectImage4() {
        selectedImageName = "star"
    }
    
    @IBAction func changeBackground() {
        var configuration = PHPickerConfiguration()
        let filter = PHPickerFilter.images
        configuration.filter = filter
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @IBAction func save() {
        UIGraphicsBeginImageContextWithOptions(backgroundImageView.frame.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: -backgroundImageView.frame.origin.x, y: -backgroundImageView.frame.origin.y)
        self.view.layer.render(in: context)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
    }
    
    @IBAction func undo() {
        if !imageViewArray.isEmpty {
            imageViewArray.last!.removeFromSuperview()
            imageViewArray.removeLast()
        }
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        self.backgroundImageView.image = image
                    }
                }
            }
        }
        
        self.dismiss(animated: true)
    }

}

