//
//  NewsDataViewController.swift
//  TU Dorm
//
//  Created by Pattranit Pisantanaroj on 12/19/2560 BE.
//  Copyright © 2560 Pattranit Pisantanaroj. All rights reserved.
//

import UIKit

class NewsDataViewController: UIViewController {
    
    @IBOutlet weak var NewsDetail: UILabel!
    var newsData : News = News()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = newsData.title
        NewsDetail.text = "\(newsData.data)!"
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
