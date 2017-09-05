//
//  CountdownView.swift
//  CountdownModule
//
//  Created by Ger on 2017/8/25.
//  Copyright © 2017年 UEZ. All rights reserved.
//

import UIKit

class CountdownView: UIView {

    fileprivate var timeStamp:Int64?
    fileprivate var timer :DispatchSourceTimer?
    fileprivate lazy var leftLabel:UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width:50, height: 17))
        label.text = "距结束："
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.gray
        return label
    }()
    
    convenience init(view_X:CGFloat,view_Y:CGFloat){
        self.init(frame: CGRect(x: view_X, y: view_Y, width: 76, height: 17))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   //Sets the start and end times of the timer view
    func setActiveTimePeriods(starTime:Int64,endTime:Int64){
        activeTimePeriods(starTime:starTime,endTime:endTime)
    }
    
    fileprivate func activeTimePeriods(starTime:Int64,endTime:Int64){
        //已经开始
        if isNowBefore(starTime) == true {
            self.timeStamp = endTime
            leftLabel.text = "距结束："
            executeCountDown(initialTime: endTime, hasBegun: true)
        }else{
            self.timeStamp = starTime
            leftLabel.text = "距开始："
            executeCountDown(initialTime: starTime, hasBegun: false)
        }
        configSubviews()
    }

    fileprivate func configSubviews(){
        
        self.addSubview(leftLabel)
        self.addSubview(dayButton)
        self.addSubview(leftColonLabel)
        self.addSubview(hourButton)
        self.addSubview(frontColonLabel)
        self.addSubview(minuteButton)
        self.addSubview(backColonLabel)
        self.addSubview(secondButton)
    }
    
    fileprivate lazy var dayButton :UIButton = {
        let dayBtn = self.setDayButtonContent()
        dayBtn.setTitle(self.getTitleOfCountDownButton(self.getTimeDifferenceDateComponents(self.timeStamp).day), for: .normal)
        return dayBtn
    }()
    
    fileprivate lazy var leftColonLabel :UIView = {
        let label = UILabel(frame: CGRect(x: 70, y: 0, width: 7, height: 17))
        label.text = "："
        return label
    }()

    fileprivate lazy var hourButton :UIButton = {
        let hourBtn = self.setHourButtonContent()
        hourBtn.setTitle(self.getTitleOfCountDownButton(self.getTimeDifferenceDateComponents(self.timeStamp).hour), for: .normal)
        return hourBtn
    }()
    
    fileprivate lazy var frontColonLabel :UIView = {
        let label = UILabel(frame: CGRect(x: 85, y: 0, width: 7, height: 17))
        label.text = "："
        return label
    }()
    fileprivate lazy var minuteButton :UIButton = {
        let muniteBtn = self.setMinuteButtonContent()
        muniteBtn.setTitle(self.getTitleOfCountDownButton(self.getTimeDifferenceDateComponents(self.timeStamp).minute), for: .normal)
        return muniteBtn
    } ()
    
    fileprivate lazy var backColonLabel: UIView = {
        let label = UILabel(frame: CGRect(x: 100, y: 0, width: 7, height: 17))
        label.text = "："
        return label
    }()
    
    fileprivate lazy var secondButton :UIButton = {
        let secondBtn = self.setSecondButtonContent()
        secondBtn.setTitle(self.getTitleOfCountDownButton(self.getTimeDifferenceDateComponents(self.timeStamp).second), for: .normal)
        return secondBtn
    } ()
    
   
    
    deinit {
        cancelTimer()
    }
}

extension CountdownView{
    
    fileprivate func setDayButtonContent() -> UIButton {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 2
        button.frame = CGRect(x: 50, y: 0, width: 20, height: 17)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.isUserInteractionEnabled = false
        return button
    }
    
    fileprivate func setHourButtonContent() -> UIButton {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 2
        button.frame = CGRect(x: 76, y: 0, width: 14, height: 17)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.isUserInteractionEnabled = false
        return button
    }
    fileprivate func setMinuteButtonContent() -> UIButton {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 2
        button.frame = CGRect(x: 97, y: 0, width: 14, height: 17)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.isUserInteractionEnabled = false
        return button
    }
    fileprivate func setSecondButtonContent() -> UIButton {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 2
        button.frame = CGRect(x: 118, y: 0, width: 14, height: 17)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.isUserInteractionEnabled = false
        return button
    }
}

extension CountdownView {
    
    fileprivate func getTitleOfCountDownButton(_ value:Int?) -> String {
        if value! < 10 && value! >= 0{
            return "0" + String(stringInterpolationSegment: value!)
        }else if value! < 0 && value! > -10 {
            return "0" + String(stringInterpolationSegment: (0 - value!))
        }else if value! < -10{
            return String(stringInterpolationSegment: (0 - value!))
        }
        return String(stringInterpolationSegment: value!)
    }

    fileprivate func executeCountDown(initialTime:Int64,hasBegun:Bool){
        
        //目标日期
        let endDate = getDateFromTimeStamp(timeStamp: initialTime)
        //当前日期
        let currentDate = Date()
        //时间间隔
        var timeInterval = TimeInterval()
        if hasBegun {
            timeInterval = endDate.timeIntervalSince(currentDate)
        }else{
            timeInterval = currentDate.timeIntervalSince(endDate)
        }
        
        var timeout = timeInterval > 0 ? timeInterval :(0 - timeInterval)
        
        let queue = DispatchQueue.global()
        //在全局队列下创建一个时间源
        timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
        //设定循环的间隔是一秒,并且立即开始
        timer?.scheduleRepeating(wallDeadline: DispatchWallTime.now(), interval: 1.0)
        //时间源发出事件
        timer?.setEventHandler { 
            if timeout <= 0 {
                self.timer?.cancel()
                self.timer = nil
                DispatchQueue.main.async(execute: { 
                    self.hourButton.setTitle("00", for: .normal)
                    self.minuteButton.setTitle("00", for: .normal)
                    self.secondButton.setTitle("00", for: .normal)
                })
            }else{
                let days = Int(timeout) / (3600 * 24)
                let hours = (Int(timeout) - Int(days) * 24 * 3600) / 3600
                let minutes = (Int(timeout) - Int(days) * 24 * 3600 - Int(hours) * 3600) / 60
                let seconds = Int(timeout) - Int(days) * 24 * 3600 - Int(hours) * 3600 - Int(minutes) * 60
                DispatchQueue.main.async(execute: {
                    if hours < 10 {
                        self.hourButton.setTitle("0" + "\(hours)", for: .normal)
                    } else {
                        self.hourButton.setTitle("\(hours)", for: .normal)
                    }
                    if minutes < 10 {
                        self.minuteButton.setTitle("0" + "\(minutes)", for: .normal)
                    } else {
                        self.minuteButton.setTitle("\(minutes)", for: .normal)
                    }
                    if seconds < 10 {
                        self.secondButton.setTitle("0" + "\(seconds)", for: .normal)
                    } else {
                        self.secondButton.setTitle("\(seconds)", for: .normal)
                    }
                })
                timeout -= 1
            }
        }
        
        timer?.resume()
    }
    
    func cancelTimer(){
        self.timer?.cancel()
        self.timer = nil
    }
}

extension CountdownView {
    
    fileprivate func isNowBefore(_ startTime:Int64) -> Bool {
        let dateCompos = getTimeDifferenceDateComponents(startTime)
        if dateCompos.hour! < 0 || dateCompos.minute! < 0 || dateCompos.second! < 0 {
            return true
        }
        return false
    }
    
    fileprivate func isMoreThanOneDay(_ startTime:Int64) -> Bool {
        let dateCompos = self.getTimeDifferenceDateComponents(startTime)
        if dateCompos.day! > 0 {
            return true
        }
        return false
    }
    
    fileprivate func getDateFromTimeStamp(timeStamp:Int64?) -> Date {
        let stamp = ( timeStamp ?? 0)/1000 //过滤毫秒
        //转换为时间
        let timeInterval:TimeInterval = TimeInterval(stamp)
        let date = Date.init(timeIntervalSince1970: timeInterval)
        return date
    }
    
    fileprivate func getTimeDifferenceDateComponents(_ timeStamp: Int64?) -> DateComponents{
        let date = getDateFromTimeStamp(timeStamp: timeStamp)
        let currentDate = Date()
        
        let calendar = NSCalendar.current
        
        let compo = calendar.dateComponents([.year,.day,.hour,.minute,.second], from: currentDate, to: date)
        return compo
    }
}








