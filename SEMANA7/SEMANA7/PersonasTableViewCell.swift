//
//  PersonasTableViewCell.swift
//  SEMANA7
//
//  Created by Tecsup on 27/04/26.
//

import UIKit

class PersonasTableViewCell: UITableViewCell {
    @IBOutlet weak var PersonaImagen: UIImageView!
    @IBOutlet weak var personaNombre: UILabel!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
