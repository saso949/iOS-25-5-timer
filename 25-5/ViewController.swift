//
//  ViewController.swift
//  25-5
//
//  Created by Aoba S on 2021/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var situationLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var OurTImer = Timer()
    var viewCount = 0
    var a = 0
    var b = 0
    var tt = 0
    var studyCount = 0
    
    
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
    }
    
    var stopCounter = 0
    @IBAction func stopButton(_ sender: Any) {
        if stopCounter % 2 == 0{
            stopButton.setTitle("再開", for: .normal)
            OurTImer.invalidate()
        }else if stopCounter % 2 == 1{
            OurTImer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Action), userInfo: nil, repeats: true)
            stopButton.setTitle("ストップ", for: .normal)
        }

    }
    
    
}

