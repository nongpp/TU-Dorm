//
//  RepairViewController.swift
//  TU Dorm
//
//  Created by Pattranit Pisantanaroj on 12/20/2560 BE.
//  Copyright © 2560 Pattranit Pisantanaroj. All rights reserved.
//

import UIKit

protocol RepairedItemViewControllerDelegate {
    func addRepairedItem(newRepairItem : RepairedItem, newItem : Int)
    func cancelRepairedItem()
}

class RepairedViewController: UIViewController {
    
    var delegate : RepairedItemViewControllerDelegate?
    
    var myRepairedItem : RepairedItem?
    var myNewItem : Int = 0
    
    @IBOutlet weak var repairedItem: UITextField!
    @IBOutlet weak var RoomNumber: UITextField!
    @IBOutlet weak var PhoneNumber: UITextField!
    
    @IBOutlet weak var datePickerTxt: UITextField!
    
    let datePicker = UIDatePicker()
   
    @IBAction func saveMethod() {
        repairedItem.resignFirstResponder()
        RoomNumber.resignFirstResponder()
        PhoneNumber.resignFirstResponder()
        
        let trimRepairedItemName = repairedItem.text?.trimmingCharacters(in: .whitespaces)
        let trimRoomNumber = RoomNumber.text?.trimmingCharacters(in: .whitespaces)
        let trimPhoneNumber = PhoneNumber.text?.trimmingCharacters(in: .whitespaces)
        let trimDateAndTime = datePickerTxt.text?.trimmingCharacters(in: .whitespaces)
        
        if ((trimRepairedItemName?.characters.isEmpty)! || (trimRoomNumber?.characters.isEmpty)! || (trimPhoneNumber?.characters.isEmpty)! || (trimDateAndTime?.characters.isEmpty)!){
            let alertController = UIAlertController(title: "Repaired Item", message: "กรุณากรอกข้อมูลให้ครบถ้วน", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            let clearButton = UIAlertAction(title: "Clear", style: .default, handler: { (action) in
                self.repairedItem.text = ""
                self.RoomNumber.text = ""
                self.PhoneNumber.text = ""
                self.datePickerTxt.text = ""
            })
            
            alertController.addAction(cancelButton)
            alertController.addAction(clearButton)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            if myRepairedItem == nil {
                myRepairedItem = RepairedItem()
            }
            
            myRepairedItem?.repairItem = repairedItem.text!
            myRepairedItem?.room = RoomNumber.text!
            myRepairedItem?.phoneNumber = PhoneNumber.text!
            myRepairedItem?.dateAndTime = datePickerTxt.text!
            
            delegate?.addRepairedItem(newRepairItem: myRepairedItem!, newItem: myNewItem)
        }
    }
    
    @IBAction func cancelMethod() {
        delegate?.cancelRepairedItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createDatePicker()
        
        if let v = myRepairedItem {
            repairedItem.text = v.repairItem
            RoomNumber.text = v.room
            PhoneNumber.text = v.phoneNumber
            datePickerTxt.text = v.dateAndTime
        }
        // Do any additional setup after loading the view.
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        datePickerTxt.inputAccessoryView = toolbar
        
        datePickerTxt.inputView = datePicker
    }
    
    @objc func donePressed() {
        //format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        datePickerTxt.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
