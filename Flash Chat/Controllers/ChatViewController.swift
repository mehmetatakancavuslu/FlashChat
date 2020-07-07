//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Atakan Çavuşlu on 29/06/2020.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        title = K.appName
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
        
    }
    
    func loadMessages() {
        
        db.collection(K.FStore.collectionName).getDocuments { (querySnapshot, error) in
            
            if let e = error {
                print("There was an issue retrieving the data from the Firestore, \(e)")
            } else {
                
                guard let snapshotDocuments = querySnapshot?.documents else { return }
                
                for doc in snapshotDocuments {
                    
                    let data = doc.data()
                    guard let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String else { return }
                    let newMessage = Message(sender: messageSender, body: messageBody)
                    
                    self.messages.append(newMessage)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }
                
            }
            
        }
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        guard let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email else { return }
        
        let messageData = [K.FStore.senderField: messageSender, K.FStore.bodyField: messageBody]
        
        db.collection(K.FStore.collectionName).addDocument(data: messageData) { (error) in
            
            if let e = error {
                print("There was an issue saving the data to the Firestore, \(e)")
            } else {
                print("Successfully saved the data.")
            }
            
        }
        
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {

        do {
            
            try Auth.auth().signOut()
            
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
}

// MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = messages[indexPath.row].body
        return cell
        
    }
    
}
