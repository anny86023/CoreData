//
//  ViewController.swift
//  ExCoreData
//
//  Created by anny on 2020/11/12.
//  Copyright © 2020 anny. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputPhone: UITextField!
    
    // 用來操作 Core Data 的常數
    let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showUser()
        print("----")
        updateUser()
        print("----")
        deleteUser()
        print("----")
    }

    // 按下按鈕 新增User
    @IBAction func addPerseon(_ sender: UIButton) {
        if inputName.text?.isEmpty == true || inputPhone.text?.isEmpty == true{
            let alert = UIAlertController(title: "請輸入完整資料", message: "欄位不可為空", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }else{
            addUser(name: inputName.text!, phone: inputPhone.text!)
            inputName.text = ""
            inputPhone.text = ""
        }
    }
    
    // 新增User
    func addUser(name:String, phone:String){
        let user = User(context: context)
        user.name = name
        user.phone = phone
        container.saveContext()
        print("存入資料 姓名\(name) 手機\(phone)")
        showUser()
    }
    
    // 顯示全部資料
    func showUser(){
        let request = NSFetchRequest<User>(entityName: "User")
        do {
            let results = try context.fetch(request)
            for result in results {
                print("姓名: \(result.name!), 手機: \(result.phone!)")
            }
        } catch {
            fatalError("Could not fetch. \(error)")
        }
    }
    
    // 修改
    func updateUser(){
        let request = NSFetchRequest<User>(entityName: "User")
    
        let name = "anny"
        request.predicate = NSPredicate(format: "name == %@", name)
        //request.predicate = NSPredicate(format: "name CONTAINS[cd]%@", name)
        
        do {
            let results = try context.fetch(request)

            if results.count > 0 {
                let user = results[0]
                user.phone = "0900000000"
                container.saveContext()
                showUser()
            }
        } catch {
            fatalError("Failed to fetch data: \(error)")
        }
    }
    
    //刪除
    func deleteUser(){
        let request = NSFetchRequest<User>(entityName: "User")
    
        let name = "aaa"
        request.predicate = NSPredicate(format: "name == %@", name)
        //request.predicate = NSPredicate(format: "name CONTAINS[cd]%@", name)
        
        do {
            let results = try context.fetch(request)

            for result in results {
                context.delete(result)
            }
            showUser()
        } catch {
            fatalError("Failed to fetch data: \(error)")
        }
    }
}
