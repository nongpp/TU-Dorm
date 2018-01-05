//
//  MaintenanceCallViewController.swift
//  TU Dorm
//
//  Created by Pattranit Pisantanaroj on 12/20/2560 BE.
//  Copyright © 2560 Pattranit Pisantanaroj. All rights reserved.
//

import UIKit

class MaintenanceCallListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RepairedItemViewControllerDelegate {
    
    var myRepairedList  : [RepairedItem] = []

    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Repaired Item List"
        myTableView.delegate = self
        myTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func addRepairedItem(newRepairItem : RepairedItem, newItem : Int) {
        if newItem == -1 {
            myRepairedList.append(newRepairItem)
        } else {
            myRepairedList[newItem] = newRepairItem
        }
        
        myTableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    func cancelRepairedItem() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tempRepairedItem = myRepairedList[sourceIndexPath.row]
        myRepairedList.remove(at: sourceIndexPath.row)
        myRepairedList.insert(tempRepairedItem, at: destinationIndexPath.row)
    }
    
    func  tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myRepairedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let myRepairedItemDetail = "วัน - เวลา \(myRepairedList[indexPath.row].dateAndTime)"
        
        cell.textLabel?.text = myRepairedList[indexPath.row].repairItem
        cell.detailTextLabel?.text = myRepairedItemDetail
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //(segue.destination as! RepairedViewController).delegate = self
        
        let myVC = segue.destination as! RepairedViewController
        if segue.identifier == "NewItem" {
            myVC.myNewItem = -1
        }
        else {
            let indexPath = myTableView.indexPathForSelectedRow!
            myVC.myRepairedItem = myRepairedList[indexPath.row]
            myVC.myNewItem = indexPath.row
        }
        myVC.delegate = self
    }
    
    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
