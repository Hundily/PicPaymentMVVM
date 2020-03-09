//
//  ContactTableViewCell.swift
//  PicPaymentMVVM
//
//  Created by Hundily Cerqueira on 18/02/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var labelNickName: UILabel!
    @IBOutlet weak var labelUserName: UILabel!
    
    var data: Contact? {
        didSet {
            if let data = data {
                img.imageFromURL(urlString: data.img)
                labelNickName.text = data.name
                labelUserName.text = data.username
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        img.layer.cornerRadius = img.bounds.size.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
