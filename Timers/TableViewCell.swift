//
//  TableViewCell.swift
//  Timers
//
//  Created by Александр Прендота on 15.05.16.
//  Copyright © 2016 Alexander Naumov. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var renameButton: UIButton!

  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      //  textLabel.text = "Code"
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
