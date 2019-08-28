//
//  TodoListTableViewController.swift
//  Todo-App
//
//  Created by 岩永彩里 on 2018/06/19.
//  Copyright © 2018年 iwanaga sari. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    let todoCollection = TodoCollection.sharedInstance
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController!.navigationBar.tintColor = UIColor.white        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "新規作成", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TodoListTableViewController.newTodo))
        self.navigationItem.leftBarButtonItem = editButtonItem
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        todoCollection.fetchTodos()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    @objc func newTodo(){
        self.performSegue(withIdentifier: "PresentNewTodoViewController", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.todoCollection.todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "reuseIdentifier")
        let todo = self.todoCollection.todos[indexPath.row]
        cell.textLabel!.text = todo.title
        cell.detailTextLabel!.text = todo.descript
        cell.textLabel!.font = UIFont(name: "HirakakuProN-W3", size: 15)
        let priorityIcon = UIView(frame: CGRect(x:0, y:0, width:12, height:12))
        priorityIcon.layer.cornerRadius = 6
        priorityIcon.backgroundColor = todo.priority.color()
        cell.accessoryView = priorityIcon
        // Configure the cell...
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            self.todoCollection.todos.remove(at: indexPath.row)
            self.todoCollection.save()
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.middle)
        case .insert:
            //処理
            return
        default:
            return
        }
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = self.todoCollection.todos[sourceIndexPath.row]
        self.todoCollection.todos.remove(at: sourceIndexPath.row)
        self.todoCollection.todos.insert(todo, at: destinationIndexPath.row)
        self.todoCollection.save()
    }
}
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
