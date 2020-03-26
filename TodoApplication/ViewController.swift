//
//  ViewController.swift
//  TodoApplication
//
//  Created by linear on 2020/03/25.
//  Copyright © 2020 linear. All rights reserved.
//

import UIKit
import RealmSwift


class ViewController: UIViewController, UITextFieldDelegate {

//    @IBOutlet var textField: UITextField!
    @IBOutlet var tableView: UITableView!


//    @IBOutlet var titleLabel: UILabel!

    var itemList: Results<Todo>!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let realm = try! Realm()
        self.itemList = realm.objects(Todo.self)

        self.tableView.dataSource = self

    }


    @IBAction func createPress() {
        print("CreateOnPress")
        aleartInputDialog()

    }

    func createTodo(title: String) {
//        aleartInputDialog()
        let instanceTodo: Todo = Todo()
        //get Date
        let now = Date()
        instanceTodo.title = title
        instanceTodo.updateTime = now
        let insRealm = try! Realm()
        try! insRealm.write {
            insRealm.add(instanceTodo)
        }
        self.tableView.reloadData()

    }
    



    func aleartInputDialog() {
        var alertTextField: UITextField?

        let alert = UIAlertController(
                title: "Todoを作成",
                message: "作成したい内容を入力してください。",
                preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(
                configurationHandler: { (textField: UITextField!) in
                    textField.text = ""
                    // textField.placeholder = "Mike"
                    // textField.isSecureTextEntry = true
                })
        alertTextField = alert.textFields![0] as UITextField
        alert.addAction(
                UIAlertAction(
                        title: "Cancel",
                        style: UIAlertAction.Style.cancel,
                        handler: nil))
        alert.addAction(
                UIAlertAction(
                        title: "OK",
                        style: UIAlertAction.Style.default) { _ in
                            
                    if let text = alertTextField?.text {
                        print("CreateDialogOK: "+text)
                        self.createTodo(title: text)
//                        self.label1.text = text
                    }
                }
        )

        self.present(alert, animated: true, completion: nil)
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath) as! ListTableViewCell

        let item: Todo = self.itemList[(indexPath as NSIndexPath).row]
        // DATE FORMAT
        let f = DateFormatter()
        f.timeStyle = .short
        f.dateStyle = .short
        f.locale = Locale(identifier: "ja_JP")


        cell.titleLabel.text = item.title
        cell.updateTime.text = f.string(from: item.updateTime!)

        print(item.title as Any)
        return cell
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemList.count
    }

//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TestCell",for: indexPath)
//
//        let item:Todo = self.itemList[(indexPath as NSIndexPath).row]
//
//        cell.textLabel?.text = item.title
//        return cell
//    }
}
