//
//  ViewController.swift
//  To Do List
//
//  Created by IMCS2 on 7/30/19.
//  Copyright © 2019 com.phani. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

var sendingValue = [String]()

class ViewController: UITableViewController{
    var ref: DatabaseReference!
    var keyArray:[String] = []
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sendingValue.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let  todo: String = sendingValue[indexPath.row]
        cell.textLabel?.text = todo
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromFirebase()
    }
    
    
    func fetchDataFromFirebase(){
        //accessing value=
        ref = Database.database().reference().child("Student")
        // ref.child("names")
        ref.observe(.value){(snapshot: DataSnapshot) in
            sendingValue.removeAll()
            for nameValue in snapshot.children{
                let snapshotContent = nameValue as? DataSnapshot
                let namedata = snapshotContent?.value as? NSDictionary
                self.keyArray.append(snapshotContent!.key)
                sendingValue.append(namedata?.value(forKey: "names") as! String)
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let values = keyArray[indexPath.row]
        if editingStyle == .delete{
            sendingValue.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            Database.database().reference().child("Student").child(values).removeValue()
            
        }
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}




