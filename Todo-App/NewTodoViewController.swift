//
//  NewTodoViewController.swift
//  Todo-App
//
//  Created by 岩永彩里 on 2018/06/19.
//  Copyright © 2018年 iwanaga sari. All rights reserved.
//

import UIKit

class NewTodoViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    @IBOutlet weak var todoField: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    let todoCollection = TodoCollection.sharedInstance
    
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"閉じる", style:UIBarButtonItemStyle.plain ,target: self , action: #selector(NewTodoViewController.close))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title:"保存", style:UIBarButtonItemStyle.plain, target: self, action: #selector(NewTodoViewController.save))
    }
    
    @objc func close(){
        self.dismiss (animated: true, completion: nil)
    }
    @objc func save(){
        if todoField.text!.isEmpty {
            let alertView = UIAlertController(title: "エラー", message: "Todoが記述されていません", preferredStyle: UIAlertControllerStyle.alert)
            alertView.addAction(UIAlertAction(title:"はい", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertView, animated: true, completion: nil)
        }else{
            let todo = Todo()
            todo.title = todoField.text!
            todo.descript  = descriptionView.text
            todo.priority = TodoPriority(rawValue: prioritySegment.selectedSegmentIndex)!
            self.todoCollection.addTodoCollection(todo: todo)
            print(self.todoCollection.todos)
            self.dismiss (animated:true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        todoField.delegate = self
        
        descriptionView.layer.cornerRadius = 5
        descriptionView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
        descriptionView.layer.borderWidth = 1
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewTodoViewController.tapGesture(_ :)))
        self.view.addGestureRecognizer(tapRecognizer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer){
        todoField.resignFirstResponder()
        descriptionView.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField:UITextField ) -> Bool {
        todoField.resignFirstResponder()
        return true
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

