//
//  ContactTableViewCell.swift
//  PicPaymentMVVM
//
//  Created by Hundily Cerqueira on 18/02/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var labelNickName: UILabel!
    @IBOutlet weak var labelUserName: UILabel!
    
    var data: Contact? {
        didSet {
            if let data = data {
                imageProfile.imageFromURL(urlString: data.img)
                labelNickName.text = data.name
                labelUserName.text = data.username
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        imageProfile.layer.cornerRadius = imageProfile.bounds.size.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
