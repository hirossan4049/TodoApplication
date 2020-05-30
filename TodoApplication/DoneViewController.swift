//
//  DoneViewController.swift
//  TodoApplication
//
//  Created by unkonow on 2020/05/30.
//  Copyright © 2020 linear. All rights reserved.
//

import UIKit
import RealmSwift

class DoneViewController: UIViewController{
    @IBOutlet var doneTableView: UITableView!
    var itemList: Results<Todo>!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("done View controller loaded!")
        self.doneTableView.delegate = self
        self.doneTableView.dataSource = self
        
        let realm = try! Realm()
        self.itemList = realm.objects(Todo.self).filter("isDone == True")

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        self.doneTableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DoneViewController: UITableViewDelegate, UITableViewDataSource {
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
        
        cell.checkBox.change_checkbox(check: item.isDone)
        

        print(item.title as Any)
        print(item.isDone)
        return cell
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //セルの選択解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item:Todo = self.itemList[(indexPath as NSIndexPath).row]
        let realm = try! Realm()
        try! realm.write {
            item.isDone = !item.isDone
            print(item.isDone)
        }
        print(item.isDone)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath as IndexPath) as! ListTableViewCell
//        cell.checkBox.change_checkbox(check: item.isDone!)


        print("Clicked!")
        tableView.reloadData()
        //ここに遷移処理を書く
//        self.present(SecondViewController(), animated: true, completion: nil)
    }
}
