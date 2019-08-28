//
//  TodoCollection.swift
//  Todo-App
//
//  Created by 岩永彩里 on 2018/06/19.
//  Copyright © 2018年 iwanaga sari. All rights reserved.
//

import UIKit

class TodoCollection: NSObject {
    static let sharedInstance = TodoCollection()
    var todos:[Todo] = []
    
    func addTodoCollection(todo: Todo){
        self.todos.append(todo)
        self.save()
    }
    
    func save(){
        var todoList: Array<Dictionary<String, AnyObject>> = []
        for todo in todos{
            let todoDic = TodoCollection.convertDictionary(todo: todo)
            todoList.append(todoDic)
        }
        
        let defaults = UserDefaults.standard
        defaults.set(todoList, forKey: "todoLists")
        defaults.synchronize()
        
    }
    
    func fetchTodos(){
        let defaults = UserDefaults.standard
        if let todoList = defaults.object(forKey: "todoLists") as? Array<Dictionary<String, AnyObject>> {
            for todoDic in todoList {
                let todo = TodoCollection.convertTodoModel(attiributes: todoDic)
                self.todos.append(todo)
            }
        }
    }
    
    class func convertDictionary(todo: Todo) -> Dictionary<String, AnyObject> {
        var dic = Dictionary<String, AnyObject>()
        dic["title"] = todo.title as AnyObject
        dic["descript"] = todo.descript as AnyObject
        dic["priority"] = todo.priority.rawValue as AnyObject
        return dic
    }
    class func convertTodoModel(attiributes: Dictionary<String, AnyObject>) -> Todo {
        let todo = Todo()
        todo.title = attiributes["title"] as! String
        todo.descript = attiributes["descript"] as! String
        todo.priority = TodoPriority(rawValue: attiributes["priority"] as! Int)!
        return todo
    }
}
