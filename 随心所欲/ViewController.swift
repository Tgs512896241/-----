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
    var sys_height = UIScreen.mainScreen().bounds.height-64
    var netParmas = NSMutableDictionary()
    var dataListArr = NSMutableArray()
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTopNavInfo()
                // Do any additional setup after loading the view, typically from a nib.
        self.mainTableView = UITableView.init(frame: CGRectMake(0, 0, sys_width, sys_height), style: UITableViewStyle.Plain)
        self.mainTableView?.delegate = self
        self.mainTableView?.dataSource = self
        self.mainTableView?.separatorColor = RGBColor(250, green: 250, blue: 250, alpha: 1.0)
        self.mainTableView?.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { 
            self.page = 1;
            self.dataListArr = NSMutableArray()
            self.netParmas.setValue(self.page, forKey: "page")
            self.getNetListData()
        })
        self.mainTableView?.mj_header.automaticallyChangeAlpha = true

        self.mainTableView?.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            self.page = self.page+1;
            self.netParmas.setValue(self.page, forKey: "page")
            self.getNetListData()
        });
        self.mainTableView?.mj_footer.automaticallyChangeAlpha = true
        
        self.mainTableView?.registerClass(TgsViewTableViewCell.self, forCellReuseIdentifier: "TgsViewTableViewCell")
        self.view.addSubview(self.mainTableView!)
        self.netParmas.setValue(self.page, forKey: "page")
        self.netParmas.setValue(20, forKey: "pagesize")
        self.netParmas.setValue("db3d71ceb08acb7bf6f7eeb17e067755", forKey: "key")
        self.getNetListData()
    }
    func setTopNavInfo(){
        let backImage = TgsNetHelperShare .sharedNetManager().imageWithColor(RGBColor(255, green: 87, blue: 34, alpha: 1.0))
        self.navigationController?.navigationBar.setBackgroundImage(backImage, forBarMetrics: UIBarMetrics.Default)

        self.view.backgroundColor  = RGBColor(255, green: 255, blue: 255, alpha: 1.0);
        let titleLabel:UILabel = UILabel.init(frame: CGRectMake(0, 0, sys_width*0.4, 44))
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.text = "开心一刻"
        titleLabel.font = UIFont.systemFontOfSize(15)
        titleLabel.textColor = RGBColor(255, green: 255, blue: 255, alpha: 1.0)
        self.navigationItem.titleView = titleLabel
        
    }
//    获取网络数据
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
            }
            self.mainTableView?.reloadData()
            self.mainTableView?.mj_footer.endRefreshing()
            self.mainTableView?.mj_header.endRefreshing()
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.dataListArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let strCell = "TgsViewTableViewCell"
        let  cell = NSBundle.mainBundle().loadNibNamed(strCell, owner: nil, options: nil)[0] as! TgsViewTableViewCell
        if self.dataListArr.count>0 {
            let cellDic = NSDictionary.init(dictionary:  dataListArr[indexPath.row] as! NSDictionary)
            let nameStr = cellDic.valueForKey("content") as? String
            let timeStr = String.init(format: "更新:%@", (cellDic.valueForKey("updatetime") as! String))

            let labelFont = UIFont.systemFontOfSize(15)
            let labRect:CGRect = getTextRectSize(nameStr!, font: labelFont, size: CGSizeMake(sys_width-8, 1000))
            cell.contentLabel.frame = CGRectMake(4, 4, sys_width-8, labRect.size.height)
            cell.contentLabel.text = nameStr
            cell.timeLabel.frame = CGRectMake(sys_width*0.15, CGRectGetMaxY(cell.contentLabel.frame)+10, sys_width*0.85, 35);
            cell.timeLabel.text = timeStr
        }
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if self.dataListArr.count>0 {
            let cellDic = NSDictionary.init(dictionary:  dataListArr[indexPath.row] as! NSDictionary)
            let nameStr = cellDic.valueForKey("content") as! NSString
            let labelFont = UIFont.systemFontOfSize(15)
            let labRect:CGRect = getTextRectSize(nameStr, font: labelFont, size: CGSizeMake(sys_width-8, 1000))
            return labRect.size.height+45
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

