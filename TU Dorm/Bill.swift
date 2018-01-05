//
//  Bill.swift
//  TU Dorm
//
//  Created by Pattranit Pisantanaroj on 12/20/2560 BE.
//  Copyright © 2560 Pattranit Pisantanaroj. All rights reserved.
//

import UIKit

class Bill: NSObject {
    var Month : String
    var ElectricBill : String
    var WaterBill : String
    
    init(Month : String, ElectricBill : String, WaterBill : String) {
        self.Month = Month
        self.ElectricBill = ElectricBill
        self.WaterBill = WaterBill
    }

}
