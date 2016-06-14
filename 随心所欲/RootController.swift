//
//  RootController.swift
//  随心所欲
//
//  Created by Tgs on 16/6/14.
//  Copyright © 2016年 Tgs. All rights reserved.
//

import UIKit

class RootController: UIViewController {
    var sys_width = UIScreen.mainScreen().bounds.width
    var sys_height = UIScreen.mainScreen().bounds.height-64
    override func viewDidLoad() {
        super.viewDidLoad()
        let backImage = TgsNetHelperShare .sharedNetManager().imageWithColor(RGBColor(255, green: 87, blue: 34, alpha: 1.0))
        self.navigationController?.navigationBar.setBackgroundImage(backImage, forBarMetrics: UIBarMetrics.Default)
        // Do any additional setup after loading the view.
    }
//   获取颜色
    func RGBColor( red:Float,green:Float,blue:Float,alpha:Float ) -> UIColor {
        return UIColor.init(colorLiteralRed: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
//  自动计算字符串的动态高度
    func getTextRectSize(text:NSString,font:UIFont,size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rect:CGRect = text.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
        //        println("rect:\(rect)");
        return rect;
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
