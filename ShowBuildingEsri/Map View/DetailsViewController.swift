//
//  DetailsViewController.swift
//  ShowBuildingEsri
//
//  Created by Mohamed Ali on 24/11/2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UINavigationItem!
    @IBOutlet weak var segement: UISegmentedControl!
    
    @IBOutlet weak var attributesContainer: UIView!
    @IBOutlet weak var attachmentContainer: UIView!

    
    static var attributes: NSMutableDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let attributes = DetailsViewController.attributes else { return }
        
        // print(attributes["name"] as! String?)
        titleLabel.title = attributes["name"] as! String?
        
    }
    
    @IBAction func DoneButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func SegmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            attributesContainer.alpha = 0
            attachmentContainer.alpha = 1
        }
        else {
            attachmentContainer.alpha = 0
            attributesContainer.alpha = 1
        }
    }
}
