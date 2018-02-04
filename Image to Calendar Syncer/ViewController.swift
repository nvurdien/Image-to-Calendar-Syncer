//
//  ViewController.swift
//  Image to Calendar Syncer
//
//  Created by Navie Vurdien on 2/3/18.
//  Copyright © 2018 Vurdien-Bucher-Software. All rights reserved.
//

import UIKit
//
//  ViewController.swift
//  Image to Calendar Syncer
//
//  Created by Navie Vurdien on 2/3/18.
//  Copyright © 2018 Vurdien-Bucher-Software. All rights reserved.
//

struct Event {
    var location: String
    var title: String
}

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var capturedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // When view appears, skip loading the image picker if there is a saved image
        if capturedImage.image == nil {
        
            let imagePicker = UIImagePickerController()
            
            // If the device has a camera, take a picture, otherwise,
            // just pick from photo library
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
            } else {
                imagePicker.sourceType = .photoLibrary
            }
            
            imagePicker.delegate = self
            
            // Place image picker on the screen
            present(imagePicker, animated: true, completion: nil)
            print("Present 1")
        } else {
            
            if let result = processImage(image: capturedImage.image) {
            
                for event in result {
                    
                    // Present a editable view
                    
                }
            } else {
                
                let badImageAlert = UIAlertController(title: "Unable to parse an event from the photo.",
                                                      message: "Please try again.",
                                                      preferredStyle: .alert)
                
                badImageAlert.addAction(UIAlertAction(title: "Ok", style: .default,
                                                      handler:
                    { (action: UIAlertAction!) in
                        self.capturedImage.image = nil
                        
                        let imagePicker = UIImagePickerController()
                        
                        // If the device has a camera, take a picture, otherwise,
                        // just pick from photo library
                        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                            imagePicker.sourceType = .camera
                        } else {
                            imagePicker.sourceType = .photoLibrary
                        }
                        
                        imagePicker.delegate = self
                        
                        // Place image picker on the screen
                        self.present(imagePicker, animated: true, completion: nil)
                }))
                
                present(badImageAlert, animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String: Any]) {
        
        // Get picked image from info dictionary
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage

        // Put that image onto the screen in our image view
        capturedImage.image = image
        
        // Take image picker off the screen -
        // you must call this dismiss method
        dismiss(animated: true, completion: nil)
        print("Dismissal 1")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func processImage(image: UIImage?) -> [Event]? {
        
        
        return nil
    }
}

