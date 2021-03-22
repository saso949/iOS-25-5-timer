//
//  ViewController.swift
//  25-5
//
//  Created by Aoba S on 2021/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    var OurTImer = Timer()
    var viewCount = 0
    @IBOutlet weak var countLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startButton(_ sender: Any) {
        OurTImer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Action), userInfo: nil, repeats: true)
    }

    
    @IBAction func stopButton(_ sender: Any) {
    }
    
    @objc func Action() {
            viewCount += 1
        
        if viewCount < 10{
            countLabel.text = "00:0" + String(viewCount)
        }else if viewCount < 60{
            countLabel.text = "00:" + String(viewCount)
        }
        
        }

}

