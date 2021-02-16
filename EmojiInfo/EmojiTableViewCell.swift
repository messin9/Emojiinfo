//
//  EmojiTableViewCell.swift
//  EmojiInfo
//
//  Created by Алексей on 02.02.2021.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    func Set(object: EmojiModel) {
        self.emojiLabel.text = object.emoji
        self.nameLabel.text = object.name
        self.DescriptionLabel.text = object.description

    }


}
