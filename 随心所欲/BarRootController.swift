//
//  BarRootController.swift
//  随心所欲
//
//  Created by Tgs on 16/6/14.
//  Copyright © 2016年 Tgs. All rights reserved.
//

import UIKit

class BarRootController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let vcFirst = ViewController()
        let ncFirst = UINavigationController.init(rootViewController: vcFirst)
        ncFirst.title = "Laugh"
        
        let robertCon = RobertViewController()
        let robertNav = UINavigationController.init(rootViewController: robertCon)
        robertNav.title = "rebert"
        
        self.viewControllers = [ncFirst,robertNav]
        
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
