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

import UIKit

class MainViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var capturedImage: UIImageView!
    
    var events: [Event]?
    
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
        } else {
            
            if let _ = processImage(image: capturedImage.image) {
                
                showEventAdderView()
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func processImage(image: UIImage?) -> [Event]? {
        
        var retVal = [Event]()
        
        retVal.append(Event(location: "Hey boi", title: "Hey boi"))
        retVal.append(Event(location: "Hey boi 2", title: "Hey boi 2"))
        retVal.append(Event(location: "Hey boi 3", title: "Hey boi 3"))
        retVal.append(Event(location: "Hey boi 4", title: "Hey boi 4"))
        
        events = retVal
        
        return retVal
        //return nil
    }
    
    func showEventAdderView() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Present the Event-Adder dialog above the taken image!
        let eventAdder = storyboard.instantiateViewController(withIdentifier: "EventAdderVC") as! EventAdderViewController
        eventAdder.modalTransitionStyle = .crossDissolve
        eventAdder.modalPresentationStyle = .overCurrentContext
        eventAdder.events = (self.events != nil) ? self.events! : [Event]()
        
        self.present(eventAdder, animated: true, completion: nil)
    }
}


