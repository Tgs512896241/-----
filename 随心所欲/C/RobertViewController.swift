//
//  RobertViewController.swift
//  随心所欲
//
//  Created by Tgs on 16/6/14.
//  Copyright © 2016年 Tgs. All rights reserved.
//

import UIKit

class RobertViewController: RootController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTopNavInfo()
        // Do any additional setup after loading the view.
    }
    func setTopNavInfo(){
        self.view.backgroundColor  = RGBColor(255, green: 255, blue: 255, alpha: 1.0);
        let titleLabel:UILabel = UILabel.init(frame: CGRectMake(0, 0, sys_width*0.4, 44))
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.text = "问答机器人"
        titleLabel.font = UIFont.systemFontOfSize(15)
        titleLabel.textColor = RGBColor(255, green: 255, blue: 255, alpha: 1.0)
        self.navigationItem.titleView = titleLabel
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
