//
//  EventAdderViewController.swift
//  Image to Calendar Syncer
//
//  Created by Charles Bucher on 2/3/18.
//  Copyright © 2018 Vurdien-Bucher-Software. All rights reserved.
//

import UIKit

class EventAdderViewController: UIViewController {

    @IBOutlet weak var NavigationView: UIView!
    @IBOutlet weak var titleText: UITextView!
    @IBOutlet weak var monthText: UITextField!
    @IBOutlet weak var dayText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var hourText: UITextField!
    @IBOutlet weak var ampmText: UITextField!
    @IBOutlet weak var locationText: UITextView!
    @IBOutlet weak var nextOrOKButton: UIButton!
    
    let monthOrHourPicker = UIPickerView()
    let dayPicker = UIPickerView()
    let yearPicker = UIPickerView()
    let AMPMPicker = UIPickerView()
    
    var possibleHoursAndMonths = [1,2,3,4,5,6,7,8,9,10,11,12]
    var possibleDays = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,
                        18,19,20,21,22,23,24,25,26,27,28,29,30,31]
    var possibleYears = arrayFromRange()
    var possibleAMPM = ["AM", "PM"]
    var events = [Event]()
    var eventID: Int = 0
    var segueToMainVC: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eventID = 0
        
        titleText.text = events[eventID].title
        locationText.text = events[eventID].location
        
        nextOrOKButton.setTitle(events.count > 1 ? "Next" : "OK", for: .normal)
        
        // Make the UI look nice
        NavigationView.layer.cornerRadius = 15
        titleText.layer.cornerRadius = 15
        locationText.layer.cornerRadius = 15
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if pickerView == monthOrHourPicker {
            return "\(possibleHoursAndMonths[row])"
        } else if pickerView == dayPicker {
            return "\(possibleDays[row])"
        } else if pickerView == yearPicker {
            return "\(possibleYears[row])"
        } else if pickerView == AMPMPicker {
            return "\(possibleAMPM[row])"
        } else {
            return "Error"
        }
    }
    
    func initializePickers() {
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /*
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if NavigationView.frame.contains(touch.location(in: view)) {
            return false
        }
        return true
    }
    */
    
    @IBAction func pressDeleteButton(_ sender: UIButton) {
        
        if events.count > 1 {
            // Delete the event and cycle to the next one in the list
            events.remove(at: eventID)
            
            eventID -= (eventID > 0) ? 1 : 0
            
            titleText.text = events[eventID].title
            locationText.text = events[eventID].location
        } else {
            // User is deleting the last event
            segueToMainVC = true
            self.performSegue(withIdentifier: "segueFromDelete", sender: nil)
        }
    }
    
    @IBAction func pressNextOrOKButton(_ sender: UIButton) {
        
        // TODO: Save event to calendar
        
        // Increase index
        eventID += 1
        
        if eventID == events.count {
            // We have exhaused all events. Segue back to Main.
            segueToMainVC = true
            self.performSegue(withIdentifier: "segueFromOK", sender: nil)
            return
        } else if eventID == events.count - 1 {
            // We are on the last event. Update next/OK button.
            nextOrOKButton.setTitle("OK", for: .normal)
        }
        
        // Update data seen by user
        titleText.text = events[eventID].title
        locationText.text = events[eventID].location
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.destination
        {
        case is MainViewController:
            
            // VC is segueing into the Event-Adder dialog VC. Ensure that VC is
            // working with the correct events list
            let destination = segue.destination as! MainViewController
            
            // Reset info in Main
            destination.events = [Event]()
            destination.capturedImage = nil
            break;
            
        default:
            if segue.identifier == "segueFromOK" {
                // VC is segueing into the Event-Adder dialog VC. Ensure that VC is
                // working with the correct events list
                let destination = segue.destination as! MainViewController
                
                // Reset info in Main
                destination.events = [Event]()
                destination.capturedImage = nil
            }
            break;
        }
    }
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        self.locationText.resignFirstResponder()
        self.titleText.resignFirstResponder()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return segueToMainVC
    }
}

func arrayFromRange() -> [Int] {
    
    var retVal = [Int]()
    
    for year in 1990...2050 {
        retVal.append(year)
    }
    
    return retVal
}
