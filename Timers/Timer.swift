//
//  Timer.swift
//  Timers
//
//  Created by Alexander Prendota on 11.05.16.
//  Copyright © 2016 Alexander Prendota. All rights reserved.
//

import Foundation

class Timer {
    
    var name: String
    var interval = 0
    var updateInterval: ((timer: Timer) -> ())?
    
    private var timer: NSTimer?
    
    init(name: String) {
        self.name = name
    }
    
      @objc func update() {
        if interval <= 0 {
            NSNotificationCenter.defaultCenter().postNotificationName("timerCompleted", object: nil, userInfo: ["name": name])
            stop()
        }
        updateInterval?(timer: self)
    }
    
    func start() {
        if timer != nil {
            stop()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
}