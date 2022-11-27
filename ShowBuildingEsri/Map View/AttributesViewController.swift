//
//  AttributesViewController.swift
//  ShowBuildingEsri
//
//  Created by Mohamed Ali on 24/11/2022.
//

import UIKit

class AttributesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var arr = Array<(String,String)>()
    // static var attributes: NSMutableDictionary!
    
    let cellIdentifier = "Cell"
    let nibFileName = "DetailsTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        ConvertDictionaryToArray()
    }
    
    func ConvertDictionaryToArray() {
        for (key,value) in DetailsViewController.attributes {
            let k = key as! String
            if k.contains("-attach") {
                continue
            }
            else {
                let str = String(describing: value)
                arr.append((k,str))

            }
        }
        
        arr = arr.sorted(by: {$0.0 < $1.0})
        
        ConfigureCell()
    }
    
    func ConfigureCell() {
        tableView.register(UINib(nibName: nibFileName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
}

extension AttributesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DetailsTableViewCell
        
        cell.ConfigureCellI(attributes: arr[indexPath.row].0, values: arr[indexPath.row].1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.0
    }
    
}
