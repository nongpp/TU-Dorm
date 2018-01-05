//
//  EmergencyCallViewController.swift
//  TU Dorm
//
//  Created by Pattranit Pisantanaroj on 12/21/2560 BE.
//  Copyright © 2560 Pattranit Pisantanaroj. All rights reserved.
//

import UIKit

class EmergencyCallViewController: UIViewController {

    @IBAction func Call(_ sender: Any) {
        var url = NSURL(string: "tel://0835024918")!
        UIApplication.shared.openURL(url as URL)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
