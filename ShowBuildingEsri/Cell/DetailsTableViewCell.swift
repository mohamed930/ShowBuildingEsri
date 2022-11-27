//
//  DetailsTableViewCell.swift
//  ShowBuildingEsri
//
//  Created by Mohamed Ali on 24/11/2022.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var AttributeTitleLabel: UILabel!
    @IBOutlet weak var AttributeValueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func ConfigureCellI(attributes: String , values: String) {
        AttributeTitleLabel.text = attributes
        AttributeValueLabel.text = values
    }
    
}
