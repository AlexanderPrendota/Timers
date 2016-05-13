//
//  TableViewController.swift
//  Timers
//
//  Created by Alexander Prendota on 11.05.16.
//  Copyright © 2016 Alexander Prendota. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    private var timers: [Timer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<4 {
            timers.append(Timer(name: "Timer \(i)"))
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(timerCompleted), name: "timerCompleted", object: nil)
    }
    
    func timerCompleted(notification: NSNotification) {
        let name = notification.userInfo!["name"] as! String
        let alert = UIAlertController(title: "Timer", message: "\(name) Completed", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        navigationController?.presentViewController(alert, animated: true, completion: nil)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timers.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = "Timer \(indexPath.row)"
        return cell
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Detail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let vc = segue.destinationViewController as! ViewController
                vc.timer = timers[indexPath.row]
            }
        }
    }
}
