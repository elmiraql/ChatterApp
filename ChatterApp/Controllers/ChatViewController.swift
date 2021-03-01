//
//  ChatViewController.swift
//  ChatterApp
//
//  Created by Elmira on 27.02.21.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellidentifier)
        loadMessages()
    }
    
    func loadMessages () {
        
        db.collection(Constants.Firestore.collectionName)
            .order(by: Constants.Firestore.dateField)
             .addSnapshotListener { (querySnapshot, error) in
            self.messages = []
            if let e = error {
                print(e)
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let sender = data[Constants.Firestore.senderField] as? String, let message = data[Constants.Firestore.bodyField] as? String {
                            let newMessage = Message(sender: sender, body: message)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                         }
                    }
                }
            }
        }
    }
    
    
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
    navigationController?.popToRootViewController(animated: true)
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
   }
    
    
    @IBAction func sendMessageButtonPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(Constants.Firestore.collectionName).addDocument(data: [
                 Constants.Firestore.senderField:messageSender,
                 Constants.Firestore.bodyField: messageBody,
                 Constants.Firestore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print(e)
                } else {
                    self.messageTextField.text = ""
                }
            }
        }
     }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellidentifier, for: indexPath) as! MessageCell
        let message = messages[indexPath.row]
        let sender = message.sender
        cell.messageLabel.text = message.body
        if sender == Auth.auth().currentUser?.email {
            cell.messageLeftAvatar.isHidden = true
            cell.messageRightAvatar.isHidden = false
            cell.messageLabel.textColor = UIColor(named: "BlackColor")
            cell.messageBubble.backgroundColor = UIColor(named: "GrayColor")
        } else {
            cell.messageLeftAvatar.isHidden = false
            cell.messageRightAvatar.isHidden = true
            cell.messageLabel.textColor = UIColor(named: "WhiteColor")
            cell.messageBubble.backgroundColor = UIColor(named: "GreenColor")
        }
        
        
        return cell
   }
}


