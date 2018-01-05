//
//  RepairItem.swift
//  TU Dorm
//
//  Created by Pattranit Pisantanaroj on 12/20/2560 BE.
//  Copyright © 2560 Pattranit Pisantanaroj. All rights reserved.
//

import UIKit

class RepairedItem: NSObject {
    var repairItem : String
    var room : String
    var phoneNumber : String
    var dateAndTime : String
    
    override init() {
        self.repairItem = ""
        self.room = ""
        self.phoneNumber = ""
        self.dateAndTime = ""
    }
    
    init(repairItem : String, room : String, phoneNumber : String, dateAndTime : String) {
        self.repairItem = repairItem
        self.room = room
        self.phoneNumber = phoneNumber
        self.dateAndTime = dateAndTime
    }
}
