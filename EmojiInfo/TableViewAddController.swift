//
//  TableViewAddController.swift
//  EmojiInfo
//
//  Created by Алексей on 03.02.2021.
//

import UIKit

class TableViewAddController: UITableViewController {
    
    var emoji = EmojiModel(emoji: "", name: "", description: "", isFavourite: false)
    
    @IBOutlet weak var emojiTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var descritpionTF: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    private func saveButtonState() {
        
        let emojiText = emojiTF.text ?? ""
        let nameText = nameTF.text ?? ""
        let descriptionText = descritpionTF.text ?? ""
        
        saveButton.isEnabled = !emojiText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty && emojiText.isSingleEmoji == true
    }
    
    private func updateUI() {
        emojiTF.text = emoji.emoji
        nameTF.text = emoji.name
        descritpionTF.text = emoji.description
    }
    
    @IBAction func textChanged(_ sender: Any) {
        saveButtonState()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        saveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveSeque" else { return }
        let emoji = emojiTF.text ?? ""
        let name = nameTF.text ?? ""
        let description = descritpionTF.text ?? ""
        self.emoji = EmojiModel(emoji: emoji, name: name, description: description, isFavourite: self.emoji.isFavourite)
        
    }
}
