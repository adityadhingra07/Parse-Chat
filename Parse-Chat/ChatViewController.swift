//
//  ChatViewController.swift
//  Parse-Chat
//
//  Created by Aditya Dhingra on 2/21/17.
//  Copyright © 2017 Aditya Dhingra. All rights reserved.
//

import UIKit
import Parse
import NextGrowingTextView

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // OUTLETS
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var growingTextView: NextGrowingTextView!
    @IBOutlet weak var send: UIButton!
    @IBOutlet weak var inputContainerView: UIView!
    @IBOutlet weak var inputContainerViewBottom: NSLayoutConstraint!
    
    
    // GLOBAL VARS
    var messages: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTableView.dataSource = self
        chatTableView.delegate = self
        
        getParseMessage()
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.growingTextView.layer.cornerRadius = 4
        self.growingTextView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        self.growingTextView.textContainerInset = UIEdgeInsets(top: 16, left: 0, bottom: 4, right: 0)
        self.growingTextView.placeholderAttributedText = NSAttributedString(string: "Write message ...",
                                                                            attributes: [NSFontAttributeName: self.growingTextView.font!,
                                                                                         NSForegroundColorAttributeName: UIColor.gray
            ]
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getParseMessage() {
        let query = PFQuery(className: "Message")
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                print("Successfully retrieved \(objects?.count) objects.")
                
                if let message_objects = objects {
                    self.messages = message_objects
                    print(message_objects)
                    self.chatTableView.reloadData()
                }
            } else {
                print("error with finding objects")
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        let message = self.messages[indexPath.row]
        let text = message["text"] as? String
        
        cell.messageLabel?.text = text
        return cell
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func handleSendButton(_ sender: AnyObject) {
        self.growingTextView.text = ""
        self.view.endEditing(true)
    }
    
    
    func keyboardWillHide(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            if let _ = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                //key point 0,
                self.inputContainerViewBottom.constant =  0
                //textViewBottomConstraint.constant = keyboardHeight
                UIView.animate(withDuration: 0.25, animations: { () -> Void in self.view.layoutIfNeeded() })
            }
        }
    }
    func keyboardWillShow(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            if let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                self.inputContainerViewBottom.constant = keyboardHeight
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
