//
//  secondViewController.swift
//  sampleMiniGuidebook
//
//  Created by untaka0822 on 2017/06/19.
//  Copyright © 2017年 untaka0822. All rights reserved.
//

import UIKit
import MapKit

class secondViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var myMapView: MKMapView!
    
    var place = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLabel.text = place
        
        // プロパティリストファイルパスを取得
        let filePath = Bundle.main.path(forResource: "placelist", ofType: "plist")
        
        // プロパティリストからdataを取得(ディクショナリー型)
        let dic = NSDictionary(contentsOfFile: filePath!)
    
        // 指定されたエリア名をキーにして、画面に必要な情報を取得
        let detailInfo:NSDictionary = dic![place] as! NSDictionary
        
        myLabel.text = detailInfo["description"] as! String
        
        myImageView.image = UIImage(named: detailInfo["image"] as! String)
        
        
        //　緯度
        let latitude = detailInfo["latitude"] as! String
        // 経度
        let longitude = detailInfo["longitude"] as! String
        
        // 中心となる場所の座標オブジェクト
        let coodinate = CLLocationCoordinate2DMake(atof(latitude), atof(longitude))
        
        // 縮尺を設定
        let span = MKCoordinateSpanMake(0.9, 0.9)
        
        // 範囲オブジェクトを作成(文字列ではなく数字で数値を渡す)
        let region = MKCoordinateRegionMake(coodinate, span)
        
        // MapViewに範囲オブジェクトを設定
        myMapView.setRegion(region, animated: true)
        
        // ピンを生成
        let myPin = MKPointAnnotation()
        
        // ピンの座標を設定
        myPin.coordinate = coodinate
        
        // mapViewにピンを追加
        myMapView.addAnnotation(myPin)


        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
