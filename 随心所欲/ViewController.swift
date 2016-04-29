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
    var netParmas = NSMutableDictionary()
    var dataListArr = NSMutableArray()
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor  = RGBColor(215, green: 245, blue: 45, alpha: 1.0);
        self.mainTableView = UITableView.init(frame: CGRectMake(0, 20, sys_width, sys_height-20), style: UITableViewStyle.Plain)
        self.mainTableView?.delegate = self
        self.mainTableView?.dataSource = self
        self.mainTableView?.separatorColor = RGBColor(250, green: 250, blue: 250, alpha: 1.0)
        self.mainTableView?.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: { 
            self.page = self.page+1;
            self.netParmas.setValue(self.page, forKey: "page")
            self.getNetListData()
        });
        self.mainTableView?.mj_footer.automaticallyChangeAlpha = true;
        
        self.mainTableView?.registerClass(TgsViewTableViewCell.self, forCellReuseIdentifier: "TgsViewTableViewCell")
        self.view.addSubview(self.mainTableView!)
        self.netParmas.setValue(self.page, forKey: "page")
        self.netParmas.setValue(20, forKey: "pagesize")
        self.netParmas.setValue("db3d71ceb08acb7bf6f7eeb17e067755", forKey: "key")
        self.getNetListData()
    }
    func getNetListData(){
        TgsNetHelperShare.sharedNetManager().getGetNetInfoWithUrl("http://japi.juhe.cn/joke/content/text.from", andType: All, andWith: self.netParmas as [NSObject : AnyObject]) { (resultDic) in
            let infoDic = NSDictionary.init(dictionary: resultDic)
            if ((infoDic.valueForKey("info")?.isEqualToString("Success")) != nil)
            {
                let dataDic = infoDic.valueForKey("result")
                if ((dataDic?.valueForKey("reason")?.isEqualToString("Success")) != nil)
                {
                    let listDic = dataDic!.valueForKey("result")
                    let dataArr = NSArray.init(array: listDic!.valueForKey("data") as! NSArray)
                    for  index in 0 ..< dataArr.count {
                        self.dataListArr.addObject(dataArr.objectAtIndex(index))
                    }
                }
                self.mainTableView?.reloadData()
                self.mainTableView?.mj_footer.endRefreshing()
            }
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.dataListArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let strCell = "TgsViewTableViewCell"
//        var cell:TgsViewTableViewCell? = tableView.dequeueReusableCellWithIdentifier(strCell) as? TgsViewTableViewCell
        let  cell = NSBundle.mainBundle().loadNibNamed(strCell, owner: nil, options: nil)[0] as! TgsViewTableViewCell
//        if  cell == nil  {
//            cell = TgsViewTableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: strCell)
//        }
        if self.dataListArr.count>0 {
            let cellDic = NSDictionary.init(dictionary:  dataListArr[indexPath.row] as! NSDictionary)
            let nameStr = cellDic.valueForKey("content") as? String
            let labelFont = UIFont.systemFontOfSize(15)
            let labRect:CGRect = getTextRectSize(nameStr!, font: labelFont, size: CGSizeMake(sys_width-8, 1000))
            cell.contentLabel.frame = CGRectMake(4, 4, sys_width-8, labRect.size.height)
            cell.contentLabel.text = nameStr
            
        }
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if self.dataListArr.count>0 {
            let cellDic = NSDictionary.init(dictionary:  dataListArr[indexPath.row] as! NSDictionary)
            let nameStr = cellDic.valueForKey("content") as! NSString
            let labelFont = UIFont.systemFontOfSize(15)
            let labRect:CGRect = getTextRectSize(nameStr, font: labelFont, size: CGSizeMake(sys_width-8, 1000))
            return labRect.size.height+40
        }
        return 100
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//  自动计算字符串的动态高度
    func getTextRectSize(text:NSString,font:UIFont,size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rect:CGRect = text.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
        //        println("rect:\(rect)");
        return rect;
    }
    
    func RGBColor( red:Float,green:Float,blue:Float,alpha:Float ) -> UIColor {
        return UIColor.init(colorLiteralRed: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }

}

