//
//  GetDataTableViewCell.swift
//  Get Information
//
//  Created by Shakhawat Hossain Shakib on 8/12/20.
//

import UIKit

class GetDataTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "userCellInfo"

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
}
