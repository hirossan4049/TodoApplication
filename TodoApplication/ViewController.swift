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
    
    var DoneWaitingList:[Date] = []
    


//    @IBOutlet var titleLabel: UILabel!

    var itemList: Results<Todo>!
    var add_only_itemList: [Todo]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let realm = try! Realm()
        self.itemList = realm.objects(Todo.self).filter("isDone == False")
        
        for item in self.itemList{
            print(item)
            self.add_only_itemList.append(item)
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
//        self.tableView.beginUpdates()
//        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)],
//                                  with: .automatic)
//        self.tableView.endUpdates()
        self.tableView.reloadData()
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
        self.add_only_itemList.append(instanceTodo)
        let insRealm = try! Realm()
        try! insRealm.write {
            insRealm.add(instanceTodo)
        }
        self.tableView.beginUpdates()
        
        self.tableView.insertRows(at: [IndexPath(row: self.itemList.count - 1, section: 0)],
                                  with: .automatic)
        self.tableView.endUpdates()
//        self.tableView.reloadData()

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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
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
        
        // FIXME
        var isDWL:Bool = false
        for dwl_item in self.DoneWaitingList{
            if dwl_item == item.updateTime{
                cell.checkBox.change_checkbox(check: true)
                print("DONE WATING LIST")
                isDWL = true
                break
            }

        }
        if isDWL == false{
            cell.checkBox.change_checkbox(check: item.isDone)
        }


        print(item.title as Any)
        print(item.isDone)
        return cell
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemList.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        

        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath as IndexPath) as! ListTableViewCell
//        cell.checkBox.change_checkbox(check: item.isDone)
        
        let item: Todo = self.add_only_itemList[(indexPath as NSIndexPath).row]
        self.DoneWaitingList.append(item.updateTime!)
        print("dwlist",self.DoneWaitingList)
        
//        cell.checkBox.change_checkbox(check: item.isDone)


        tableView.reloadData()

        print("Clicked!")
        



        
//        self.tableView.insertRows(at: [IndexPath(row: self.itemList.count - 1, section: 0)],
//                                  with: .automatic)
        /// FIXME:１秒のスリープ中の連打
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 1)
            DispatchQueue.main.async {
                self.DoneWaitingList.remove(value: item.updateTime!)

                let item:Todo = self.itemList[(indexPath as NSIndexPath).row]
                let realm = try! Realm()
                try! realm.write {
                    item.isDone = !item.isDone
                    print("tableClicked:" + String(item.isDone))
                }
                print("TABLEVIEW DELETE NOW....",indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [IndexPath(row: indexPath.row , section: 0)], with: .bottom)
                tableView.endUpdates()
                print(self.DoneWaitingList)


                print("TABLEVIEW DELETED!....")
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)

        


        
//        tableView.reloadData()
        //ここに遷移処理を書く
//        self.present(SecondViewController(), animated: true, completion: nil)
    }
    
    
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            print("delete")
//            let item:Todo = self.itemList[(indexPath as NSIndexPath).row]
//            print(item.title)
//
//            let realm = try! Realm()
//            try! realm.write {
//                realm.delete(item)
//            }
////            tableView.reloadData()
//            self.tableView.deleteRows(at: [IndexPath(row: indexPath.row , section: 0)], with: .bottom)
//            self.tableView.endUpdates()
//
//        }
//    }
    

    
    
    
//    private func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath as IndexPath) as! ListTableViewCell
//        //        cell.checkBox.change_checkbox(check: true)
//        cell.titleLabel.text = "ola"
//    }
    


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

extension Array where Element: Equatable {
    mutating func remove(value: Element) {
        if let i = self.index(of: value) {
            self.remove(at: i)
        }
    }
}
