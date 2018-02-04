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

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

