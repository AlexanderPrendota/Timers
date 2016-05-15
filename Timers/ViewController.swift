//
//  ViewController.swift
//  UIPickerViewExample
//
//  Created by Alexander Prendota on 11.05.16.
//  Copyright © 2016 Alexander Prendota. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var nameOfTimer: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    private var label1: UILabel!
    private var label2: UILabel!
    
    private var hours = 0
    private var minutes = 0
    
    var timer: Timer!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        nameOfTimer.text = timer.name
        
        label1 = UILabel()
        label1.font = UIFont.systemFontOfSize(20)
        pickerView.addSubview(label1)
        
        label2 = UILabel()
        label2.font = UIFont.systemFontOfSize(20)
        pickerView.addSubview(label2)
        
        label1.text = "ч"
        label2.text = "мин"
        
        timer.updateInterval = { [weak self] timer in
            timer.interval -= 1
            
            let hours = timer.interval / 3600
            let min = (timer.interval % 3600) / 60
            let sec = (timer.interval % 3600) % 60
            
            self?.timeLabel.text = String(format: "%02d:%02d:%02d", hours, min, sec)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let space: CGFloat = 22
        let labelHeight: CGFloat = 20
        let labelWidth = pickerView.frame.width / 4
        label1.frame = CGRect(x: labelWidth + space, y: (pickerView.frame.height - labelHeight) / 2, width: labelWidth - space, height: labelHeight)
        label2.frame = CGRect(x: pickerView.frame.width / 2 + labelWidth + space, y: (pickerView.frame.height - labelHeight) / 2, width: labelWidth - space, height: labelHeight)
    }
    
    // MARK: - PickerView
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        case 1:
            return 60
        default:
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row)"
        case 1:
            return "\(row)"
        default:
            return nil
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hours = row
        case 1:
            minutes = row
        default:
            break
        }
    }
    
    // MARK: - Action
    
    @IBAction func startAction(sender: AnyObject) {
        timer.interval = (hours * 3600) + (minutes * 60)
        timer.start()
    }
    
    @IBAction func stopAction(sender: AnyObject) {
        timer.stop()
    }
    
}

