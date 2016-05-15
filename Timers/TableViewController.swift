//
//  TableViewController.swift
//  Timers
//
//  Created by Alexander Prendota on 11.05.16.
//  Copyright © 2016 Alexander Prendota. All rights reserved.
//

import UIKit
import AVFoundation

class TableViewController: UITableViewController {
  
    var music = AVAudioPlayer()
    private var timers: [Timer] = []
    var tmpString : String = ""
    

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
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default)  {
            (action) -> Void in
            self.music.stop()
            }

        alert.addAction(ok)
        navigationController?.presentViewController(alert, animated: true, completion: nil)
        
        let filePathString = NSBundle.mainBundle().pathForResource("Music", ofType: "mp3")
        
        if let filePathString = filePathString {
            
            let pathURL = NSURL(fileURLWithPath: filePathString)
            do {
                
                try music = AVAudioPlayer(contentsOfURL: pathURL)
                music.play()
            } catch {
                print("music error")
            }
        }
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timers.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell
        //cell.textLabel?.text = "Timer" // \(indexPath.row)
        //cell.textLabel!.text = self.timers[indexPath.row].name
        cell.textLabel!.text  = tmpString
        cell.renameButton.addTarget(self, action: #selector(TableViewController.rename), forControlEvents: .TouchUpInside)
        cell.renameButton.tag = indexPath.row
        return cell
    }
    
    func rename() {
        let alert = UIAlertController(title: "Rename", message: "Enter your sweet name", preferredStyle: UIAlertControllerStyle.Alert)
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            (action) -> Void in
            if let textFieled = (alert.textFields?.first) {
                self.tmpString = "\(textFieled.text!)"
                print("\(self.tmpString)")
                self.tableView.reloadData()
            }
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        alert.addTextFieldWithConfigurationHandler { (textFiled) -> Void in
            textFiled.placeholder = "Enter your new name"
        }
        self.presentViewController(alert, animated: true, completion: nil)
        print("done")
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
