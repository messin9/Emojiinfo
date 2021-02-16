//
//  EmojiTableViewController.swift
//  EmojiInfo
//
//  Created by Алексей on 27.01.2021.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    var emojiArray = [
        EmojiModel(emoji: "😁", name: "Улыбка", description: "Улыбающееся лицо", isFavourite: false),
        EmojiModel(emoji: "🤠", name: "Ковбой", description: "Ковбой с дикого запада" , isFavourite: false),
        EmojiModel(emoji: "🧑‍🚀", name: "Космонавт", description: "Вперед к звездам", isFavourite: false),
        EmojiModel(emoji: "🐶", name: "Собака", description: "лучший друг человека", isFavourite: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Emoji Info"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "editEmoji" else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let emoji = emojiArray[indexPath.row]
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let newEmojiVC = navigationVC.topViewController as? TableViewAddController else { return }
        newEmojiVC.emoji = emoji
        newEmojiVC.title = "Edit"
        
        
    }
    
    @IBAction func unwindSegue (segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSeque" else { return }
        guard let sourceVC = segue.source as? TableViewAddController else { return }
        let emoji = sourceVC.emoji
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emojiArray[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let newIndexPath = IndexPath.init(row: emojiArray.count, section: 0)
            emojiArray.append(emoji)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
        
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return emojiArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        
        let object = emojiArray[indexPath.row]
        cell.Set(object: object)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojiArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = emojiArray.remove(at: sourceIndexPath.row)
        emojiArray.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let like = likeAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, like]) }
    
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let actionDone = UIContextualAction(style: .destructive, title: nil) { (action, view, completion) in
            self.emojiArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        actionDone.backgroundColor = .systemGreen
        actionDone.image = UIImage.init(systemName: "checkmark.circle")
        return actionDone
    }
    
    func likeAction(at indexPath: IndexPath) -> UIContextualAction {
        var emojis = emojiArray[indexPath.row]
        let actionLike = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
            emojis.isFavourite = !emojis.isFavourite
            self.emojiArray[indexPath.row] = emojis
            completion(true)
        }
        actionLike.backgroundColor = emojis.isFavourite ? .systemRed : .systemGray
        if emojis.isFavourite == false {
            actionLike.image = UIImage.init(systemName: "heart") }
        else { actionLike.image = UIImage (systemName: "heart.fill") }
        return actionLike
    }
}
