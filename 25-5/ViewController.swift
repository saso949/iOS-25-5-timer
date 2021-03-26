//
//  ViewController.swift
//  25-5
//
//  Created by Aoba S on 2021/03/22.
//

import UIKit

class ViewController: UIViewController {
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var situationLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let fileTotal = userDefaults.string(forKey: "total") {
            totalCount = Int(fileTotal)!
            totalLabel.text = "累計ポモドーロ数:" + String(totalCount) + "ポモドーロ"
        }
        
        if (UITraitCollection.current.userInterfaceStyle == .dark) {
            /* ダークモード時の処理 */
            countLabel.textColor = UIColor.white
            totalLabel.textColor = UIColor.white
        } else {
            /* ライトモード時の処理 */
        }
        
        
    }
    
    var OurTImer = Timer()
    var viewCount = 0
    var a = 0
    var b = 0
    var tt = 0
    var studyCount = 1
    var totalCount = 0
    
    
    @objc func Action() {
        viewCount += 1
        a = viewCount / 60
        b = viewCount % 60
        
        if studyCount % 5 == 0 && tt > 0 {
            if situationLabel.text == "長期休憩中..." || situationLabel.text == "勉強中"{
                situationLabel.text = "長期休憩中"
            }else if situationLabel.text == "長期休憩中"{
                situationLabel.text = "長期休憩中."
            }else if situationLabel.text == "長期休憩中."{
                situationLabel.text = "長期休憩中.."
            }else if situationLabel.text == "長期休憩中.."{
                situationLabel.text = "長期休憩中..."
            }
            
            
            //30分タイマー
            if viewCount < 10{
                countLabel.text = "00:0" + String(viewCount)
            }else if viewCount < 60{
                countLabel.text = "00:" + String(viewCount)
            }else if viewCount < 600{
                if b < 10{
                    countLabel.text = "0" + String(a) + ":0" + String(b)
                }else{
                    countLabel.text = "0" + String(a) + ":" + String(b)
                }
            }else if viewCount < 1801{
                if b < 10 {
                    countLabel.text = String(a) + ":0" + String(b)
                }else{
                    countLabel.text = String(a) + ":" + String(b)
                }
            }
            
            if viewCount == 1800{
                tt += 1
                studyCount += 1
                viewCount = 0
                a = 0
                b = 0
                totalCount += 1
                userDefaults.set(totalCount, forKey: "total")
                            userDefaults.synchronize()
                totalLabel.text = "累計ポモドーロ数:" + String(totalCount) + "ポモドーロ"
                situationLabel.text = "長期休憩中"
            }
        }else if (tt % 2 == 0){
            
            if situationLabel.text == "今の状況" || situationLabel.text == "簡易休憩中" || situationLabel.text == "長期休憩中" || situationLabel.text == "勉強中..."{
                situationLabel.text = "勉強中"
            }else if situationLabel.text == "勉強中"{
                situationLabel.text = "勉強中."
            }else if situationLabel.text == "勉強中."{
                situationLabel.text = "勉強中.."
            }else if situationLabel.text == "勉強中.."{
                situationLabel.text = "勉強中..."
            }
            
            
            //25分タイマー
            if viewCount < 10{
                countLabel.text = "00:0" + String(viewCount)
            }else if viewCount < 60{
                countLabel.text = "00:" + String(viewCount)
            }else if viewCount < 600{
                if b < 10{
                    countLabel.text = "0" + String(a) + ":0" + String(b)
                }else{
                    countLabel.text = "0" + String(a) + ":" + String(b)
                }
            }else if viewCount < 1501{
                if b < 10 {
                    countLabel.text = String(a) + ":0" + String(b)
                }else{
                    countLabel.text = String(a) + ":" + String(b)
                }
            }
            
            if viewCount == 1500{
                tt += 1
                studyCount += 1
                viewCount = 0
                a = 0
                b = 0
                situationLabel.text = "勉強中"
            }
            
        }else if (tt % 2 == 1){
            if situationLabel.text == "簡易休憩中..." || situationLabel.text == "勉強中"{
                situationLabel.text = "簡易休憩中"
            }else if situationLabel.text == "簡易休憩中"{
                situationLabel.text = "簡易休憩中."
            }else if situationLabel.text == "簡易休憩中."{
                situationLabel.text = "簡易休憩中.."
            }else if situationLabel.text == "簡易休憩中.."{
                situationLabel.text = "簡易休憩中..."
            }
            
            
            //5分タイマー
            if viewCount < 10{
                countLabel.text = "00:0" + String(viewCount)
            }else if viewCount < 60{
                countLabel.text = "00:" + String(viewCount)
            }else if viewCount < 600{
                if b < 10{
                    countLabel.text = "0" + String(a) + ":0" + String(b)
                }else{
                    countLabel.text = "0" + String(a) + ":" + String(b)
                }
            }
            
            if viewCount == 300 {
                tt += 1
                viewCount = 0
                a = 0
                b = 0
                situationLabel.text = "簡易休憩中"
            }
        }
    }
    
    
    
    
    @IBAction func startButton(_ sender: Any) {
        OurTImer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Action), userInfo: nil, repeats: true)
        startButton.isEnabled = false
        startButton.backgroundColor = UIColor.gray
    }
    
    var stopCounter = 0
    @IBAction func stopButton(_ sender: Any) {
        if stopCounter % 2 == 0{
            stopButton.setTitle("再開", for: .normal)
            OurTImer.invalidate()
            stopCounter += 1
        }else if stopCounter % 2 == 1{
            OurTImer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Action), userInfo: nil, repeats: true)
            stopButton.setTitle("ストップ", for: .normal)
            stopCounter += 1
        }

    }
    
    
}

