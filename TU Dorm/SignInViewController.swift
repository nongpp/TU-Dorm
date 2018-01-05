//
//  SignInViewController.swift
//  TU Dorm
//
//  Created by Pattranit Pisantanaroj on 12/19/2560 BE.
//  Copyright © 2560 Pattranit Pisantanaroj. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    func saveUserName(){
        let defaults : UserDefaults = UserDefaults.standard
        defaults.set(txtUserName.text!, forKey: "myUserName")
        defaults.synchronize()
    }
    
    @IBAction func loginMethod() {
        self.saveUserName()
        //HTTP request initialization
        let myURL : URL = URL(string: "http://www.worasit.com/iosbuilder/login.php")!
        var myRequest : URLRequest = URLRequest(url: myURL)
        let mySession = URLSession.shared
        myRequest.httpMethod = "POST"
        //Initialized parameter
        let params = ["username":"\(txtUserName.text!)", "password":"\(txtPassword.text!)"] as Dictionary<String, String>
        myRequest.httpBody = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        
        myRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        myRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let myTask = mySession.dataTask(with: myRequest){(responseData, responseStatus, error) in
            //ใช้กับการกํากับ Operation ลงไปใน Main Queue
            OperationQueue.main.addOperation({
                print("responseStatus = \(responseStatus!)")
                print("responseData = \(responseData!)")
                self.parseJSON(myData: responseData!)
            })
        }
        myTask.resume()
    }
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    func adjustingHeight(_ show:Bool, notification:NSNotification) {
        
        var userInfo = notification.userInfo!
        //อ่านขนาดของ Virtual Keyboard
        let keyboardFrame:CGSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as!NSValue).cgRectValue.size
        
        if show {
            bottomConstraint.constant += keyboardFrame.height
        }
        else{
            bottomConstraint.constant -= keyboardFrame.height
        }
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        adjustingHeight(true, notification: notification)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        adjustingHeight(false, notification: notification)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name:Notification.Name.UIKeyboardWillShow, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name:Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event:UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        txtUserName.text = defaults.string(forKey: "myUserName")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parseJSON(myData : Data){
        let json = try! JSONSerialization.jsonObject(with: myData,options: .mutableContainers)
        let loginResults = json as! [[String : String]]
        var myResult : String = ""
        if loginResults.count > 0 {
            myResult = loginResults.first!["myResult"]!
            if myResult == "OK" {
                let vc = self.storyboard?.instantiateViewController(withIdentifier:"Home") as! TUDormViewController
                let navitationController = UINavigationController(rootViewController: vc)
                self.present(navitationController, animated: true,completion: nil)
            } else {
                let alertController = UIAlertController(title: "เกิดข้อผิดพลาด", message: "กรุณาตรวจสอบ Username และ Password ให้ถูกต้อง", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okButton)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

}
