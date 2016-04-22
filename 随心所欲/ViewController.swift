//
//  ViewController.swift
//  随心所欲
//
//  Created by Tgs on 15/6/8.
//  Copyright (c) 2015年 Tgs. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    var mainTableView:UITableView? = nil
    var sys_width = UIScreen.mainScreen().bounds.width
    var sys_height = UIScreen.mainScreen().bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor  = RGBColor(215, green: 245, blue: 45, alpha: 1.0);
        mainTableView = UITableView.init(frame: CGRectMake(0, 64, sys_width, sys_height-64), style: UITableViewStyle.Plain)
        mainTableView?.delegate = self
        mainTableView?.dataSource = self
        mainTableView?.separatorColor = RGBColor(250, green: 250, blue: 250, alpha: 1.0)
        self.view.addSubview(mainTableView!)
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 10;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let strCell = "MainCell"
        let cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: strCell)

        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func RGBColor( red:Float,green:Float,blue:Float,alpha:Float ) -> UIColor {
        return UIColor.init(colorLiteralRed: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }

}

