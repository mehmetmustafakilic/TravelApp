//
//  DetailListTableViewCell.swift
//  TravelApp
//
//  Created by Mehmet Mustafa Kılıç on 4.10.2022.
//

import UIKit

class DetailListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var detailListCellimage: UIImageView!
    @IBOutlet weak var detailListCellName: UILabel!
    @IBOutlet weak var detailsListCellCommit: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
