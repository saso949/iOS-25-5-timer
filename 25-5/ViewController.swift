//
//  ViewController.swift
//  25-5
//
//  Created by Aoba S on 2021/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var OurTImer = Timer()
    var viewCount = 0
    var a = 0
    var b = 0
    
    
    @objc func Action() {
        viewCount += 1
        a = viewCount / 60
        b = viewCount % 60
        
        
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
            
        }
        
        
        
    }
    
    
    
    
    @IBAction func startButton(_ sender: Any) {
        OurTImer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Action), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func stopButton(_ sender: Any) {
    }
    
    
}

