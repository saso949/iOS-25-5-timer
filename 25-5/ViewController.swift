//
//  ViewController.swift
//  25-5
//
//  Created by Aoba S on 2021/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    var OurTImer = Timer()
    var TimerDisplayed = 0
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
            TimerDisplayed += 1
            countLabel.text = String(TimerDisplayed)
        }

}

