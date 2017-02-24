//
//  ChatViewController.swift
//  Parse-Chat
//
//  Created by Aditya Dhingra on 2/21/17.
//  Copyright © 2017 Aditya Dhingra. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // OUTLETS
    @IBOutlet weak var chatTableView: UITableView!
    
    // GLOBAL VARS
    var messages: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTableView.dataSource = self
        chatTableView.delegate = self
        
        getParseMessage()
        
        // Do any additional setup after loading the view.
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
        
        cell.messageLabel?.text = "message"
        
        return cell
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
