//
//  CustomTableViewCell.swift
//  FitnessApp
//
//  Created by miguelh on 6/3/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var hrvcelllabel: UILabel!
    @IBOutlet weak var datecelllabel: UILabel!
    @IBOutlet weak var hrcelllabel: UILabel!
    @IBOutlet weak var contentview: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
