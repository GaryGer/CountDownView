//
//  ViewController.swift
//  CountdownModule
//
//  Created by Ger on 2017/8/25.
//  Copyright © 2017年 UEZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate lazy var countDownView:CountdownView = {
        let subView = CountdownView(view_X: 20, view_Y: 100)
        return subView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        countDownView.setActiveTimePeriods(starTime: 1504233000000, endTime: 1504600200000)
        view.addSubview(countDownView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

