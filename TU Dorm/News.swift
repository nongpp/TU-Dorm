//
//  News.swift
//  TU Dorm
//
//  Created by Pattranit Pisantanaroj on 12/19/2560 BE.
//  Copyright © 2560 Pattranit Pisantanaroj. All rights reserved.
//

import UIKit

class News: NSObject {
    var title : String
    var data : String
    
    override init() {
        self.title = ""
        self.data = ""
    }
    
    init(title : String, data : String) {
        self.title = title
        self.data = data
    }

}
