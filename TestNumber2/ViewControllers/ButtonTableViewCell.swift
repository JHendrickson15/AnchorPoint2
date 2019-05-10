//
//  ButtonTableViewCell.swift
//  TestNumber2
//
//  Created by Jordan Hendrickson on 5/10/19.
//  Copyright © 2019 Jordan Hendrickson. All rights reserved.
//

import UIKit

protocol ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}
class ButtonTableViewCell: UITableViewCell {
    
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.buttonCellButtonTapped(self)
    }
    var delegate: ButtonTableViewCellDelegate?
    
    
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    
    func updateButton (_ isComplete: Bool) {
        if isComplete {
            completeButton.setImage(UIImage(named: "Check"), for: .normal)
        }else{
            completeButton.setImage(UIImage(named: "UnCheck"), for: .normal)
        }
    }
}
extension ButtonTableViewCell {
    func update(withList list: List) {
        
        primaryLabel.text = list.name
        updateButton(list.isComplete)
    }
}
