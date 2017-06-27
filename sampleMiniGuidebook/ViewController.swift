//
//  ViewController.swift
//  sampleMiniGuidebook
//
//  Created by untaka0822 on 2017/06/19.
//  Copyright © 2017年 untaka0822. All rights reserved.
//

import UIKit

// これを使う時には必要なプロトコルがあるため書かないとエラーがある

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    // プロパティリストから読み込んだdataを格納する配列
    var placeList:[String] = []
    
    // 選択されたエリア名
    var selectName = ""

    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // プロパティリストファイルパスを取得
        let filePath = Bundle.main.path(forResource: "placelist", ofType: "plist")
        
        // プロパティリストからdataを取得(ディクショナリー型)
        let dic = NSDictionary(contentsOfFile: filePath!)
        
        // TableViewで扱いやすい配列(エリア名の入っている配列)を作成
        // 高速列挙で値を取得
        for (key,data) in dic! {
            placeList.append(key as! String) // ダウンキャスト変換
        }
        
        
        // printで配列の中身を確認(念のため)
        print(placeList)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = placeList[indexPath.row]
        
        return cell
    }
    
    // セルをタップした時、セグエを指定して画面遷移
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 表示されているエリア名をメンバ変数に格納 大事
        selectName = placeList[indexPath.row]
        
        // セグエを指定して画面を遷移
        performSegue(withIdentifier: "secondViewController", sender: nil)
    }
    
    // 次の画面へ移動する時に、プロパティに選択したエリア名を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // 移動先の画面のインスタンスを作成
        let dvc = segue.destination as! secondViewController
        
        // 移動先の画面のプロパティにエリア名を指定
        // dvc.myLabel.text = selectName は考え方はOKだが、インスタンス化されるタイミングが少し遅いためエラーになる
        dvc.place = selectName
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

