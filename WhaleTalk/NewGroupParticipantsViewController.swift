//
//  NewGroupParticipantsViewController.swift
//  WhaleTalk
//
//  Created by Koen Hendriks on 28/04/16.
//  Copyright © 2016 Koen Hendriks. All rights reserved.
//

import UIKit
import CoreData

class NewGroupParticipantsViewController: UIViewController {

    var context:NSManagedObjectContext?
    var chat: Chat?
    var chatCreationDelegate: ChatCreationDelegate?
    
    private var searchField: UITextField!
    
    private let tableView = UITableView(frame: CGRectZero, style: .Plain)
    private let cellIdentifier = "ContactCell"
    private var displayedContacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Participants"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .Plain, target: self, action: "createChat")
        showCreateButton(false)
        
        automaticallyAdjustsScrollViewInsets = false
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        searchField = createSearchField()
        
        tableView.tableHeaderView = searchField
        
        fillViewWith(tableView)
        
        if let context = context{
            let request = NSFetchRequest(entityName: "Contact")
            request.sortDescriptors = [
                NSSortDescriptor(key: "lastName", ascending: true),
                NSSortDescriptor(key: "firstName", ascending: true)
            ]
            do{
                if let result = try context.executeFetchRequest(request) as? [Contact]{
                    displayedContacts = result
                }
            }
            catch{
                print("There was a problem fetching")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func createSearchField() -> UITextField {
        let searchField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        searchField.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        searchField.placeholder = "Type contact name"
        
        let holderView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        searchField.leftView = holderView
        searchField.leftViewMode = .Always
        
        let image = UIImage(named: "contact_icon")?.imageWithRenderingMode(.AlwaysTemplate)
        
        let contactimage = UIImageView(image: image)
        contactimage.tintColor = UIColor.darkGrayColor()
        
        holderView.addSubview(contactimage)
        contactimage.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints:[NSLayoutConstraint] = [
            contactimage.widthAnchor.constraintEqualToAnchor(holderView.widthAnchor, constant: -20),
            contactimage.heightAnchor.constraintEqualToAnchor(holderView.heightAnchor, constant: -20),
            contactimage.centerXAnchor.constraintEqualToAnchor(holderView.centerXAnchor),
            contactimage.centerYAnchor.constraintEqualToAnchor(holderView.centerYAnchor)
        ]
        NSLayoutConstraint.activateConstraints(constraints)
        
        return searchField
    }

    private func showCreateButton(show: Bool){
        if show {
            navigationItem.rightBarButtonItem?.tintColor = view.tintColor
            navigationItem.rightBarButtonItem?.enabled = true
        }
        else{
            navigationItem.rightBarButtonItem?.tintColor = UIColor.lightGrayColor()
            navigationItem.rightBarButtonItem?.enabled = false
        }
    }

}

extension NewGroupParticipantsViewController: UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedContacts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        let contact = displayedContacts[indexPath.row]
        
        cell.textLabel?.text = contact.fullName
        cell.selectionStyle = .None
        
        return cell
    }
}










