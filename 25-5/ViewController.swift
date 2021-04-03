//
//  ViewController.swift
//  25-5
//
//  Created by Aoba S on 2021/03/22.
//

import UIKit
import AVFoundation


class ViewController: UIViewController , UIApplicationDelegate{
    let userDefaults = UserDefaults.standard
    var player:AVAudioPlayer?
    var player1:AVAudioPlayer?
    var request:UNNotificationRequest!
    
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
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(self.stop),
                                       name: UIApplication.willResignActiveNotification,
                                       object: nil)
        
        
        notificationCenter.addObserver(self,
                                       selector: #selector(self.start),
                                       name:UIApplication.willEnterForegroundNotification,
                                       object: nil)
        
        
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
        
        sttp()
        
    }
    
    var OurTImer = Timer()
    var viewCount = 0
    var a = 0
    var b = 0
    var tt = 0
    var studyCount = 1
    var totalCount = 0
    var time = Date()
    
    
    @objc func stop() {
        let date :Date = Date()
        time = date
        print(date)
        
        var remaining = 0
        var sst = ""
        var tuti = ""
        
        if stopSituation == "false"{
            if studyCount % 5 == 0 && tt > 0 {
                remaining = 1800 - viewCount
                sst = "長期休憩"
                tuti = "tuti1.mp3"
            }else if tt % 2 == 0{
                remaining = 1500 - viewCount
                sst = "勉強"
                if studyCount == 4 , studyCount == 9 , studyCount == 14 , studyCount == 19{
                    tuti = "tuti2.mp3"
                }else{
                    tuti = "tuti1.mp3"
                }
            }else if tt % 2 == 1{
                remaining = 300 - viewCount
                sst = "簡易休憩"
                tuti = "tuti1.mp3"
            }
            
            
            let content = UNMutableNotificationContent()
            // 通知内容の設定
            content.title = sst + "の時間が終了しました！"
            content.body = "アプリを開くまで次のタイマーは再生されません"
            content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: tuti))
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(remaining), repeats: false)
            
            // 通知スタイルを指定
            let request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)
            // 通知をセット
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    
    
    @objc func start() {
        if stopSituation == "false" && startSitu == "true"{
            let now = Date()
            print("start!")
            let span = (floor(now.timeIntervalSince(time)))
            viewCount += Int(span)
            print(span)
            
            if studyCount % 5 == 0 && tt > 0 {
                if viewCount >= 1800{
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
            }else if tt % 2 == 0{
                if viewCount >= 1500{
                    tt += 1
                    studyCount += 1
                    viewCount = 0
                    a = 0
                    b = 0
                    situationLabel.text = "勉強中"
                }
                
            }else if tt % 2 == 1{
                if viewCount >= 300{
                    tt += 1
                    viewCount = 0
                    a = 0
                    b = 0
                    situationLabel.text = "簡易休憩中"
                }
            }
        }
    }
    
    
    @objc func Action() {
        viewCount += 1
        a = viewCount / 60
        b = viewCount % 60
        
        sttp()
        
        if viewCount <= 3{
            startButton.setTitle("スキップ", for: .normal)
            startButton.backgroundColor = UIColor(red: 155/255, green: 64/255, blue: 59/255, alpha: 1.0)
        }else if viewCount > 3{
            startButton.setTitle("初めから", for: .normal)
            startButton.backgroundColor = UIColor(red: 114/255, green: 140/255, blue: 54/255, alpha: 1.0)
        }
        
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
            
            count()
            
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
                
                sound()
                
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
            count()
            
            if viewCount == 1500{
                tt += 1
                if tt % 5 == 0 && tt > 0{
                    sound()
                }else{
                    let url1 = Bundle.main.url(forResource: "clock2", withExtension: "mp3")
                    
                    do {
                        player1 = try AVAudioPlayer(contentsOf: url1!)
                        player1?.play()
                    } catch {
                        print("error")
                    }
                }
                
                
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
            count()
            
            if viewCount == 300 {
                tt += 1
                viewCount = 0
                a = 0
                b = 0
                
                sound()
                situationLabel.text = "簡易休憩中"
            }
        }
    }
    
    
    @objc func count() {
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
    }
    
    @objc func sound() {
        let url1 = Bundle.main.url(forResource: "clock2", withExtension: "mp3")
        
        do {
            player1 = try AVAudioPlayer(contentsOf: url1!)
            player1?.play()
        } catch {
            print("error")
        }
    }
    
    @objc func sttp() {
        if startSitu == "false"{
            stopButton.backgroundColor = UIColor.gray
            stopButton.isEnabled = false
        }else if startSitu == "true"{
            stopButton.backgroundColor = UIColor.link
            stopButton.isEnabled = true
        }
    }
    
    var startSitu = "false"
    @IBAction func startButton(_ sender: Any) {
        if startSitu == "false"{
            OurTImer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Action), userInfo: nil, repeats: true)
            startSitu = "true"
        }
        if self.startButton.currentTitle == "スキップ"{
            pulus()
        }else if self.startButton.currentTitle == "初めから"{
            viewCount = 0
            startButton.setTitle("スキップ", for: .normal)
            startButton.backgroundColor = UIColor(red: 155/255, green: 64/255, blue: 59/255, alpha: 1.0)
            count()
        }
        
    }
    
    @objc func pulus() {
        if studyCount % 5 == 0 && tt > 0 {
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
        }else if tt % 2 == 0{
            tt += 1
            studyCount += 1
            viewCount = 0
            a = 0
            b = 0
            situationLabel.text = "勉強中"
        }else if tt % 2 == 1{
            tt += 1
            viewCount = 0
            a = 0
            b = 0
            situationLabel.text = "簡易休憩中"
        }
    }
    
    
    
    
    var stopSituation = "false"
    var stopCounter = 0
    @IBAction func stopButton(_ sender: Any) {
        if stopCounter % 2 == 0{
            stopButton.setTitle("再開", for: .normal)
            OurTImer.invalidate()
            stopCounter += 1
            stopSituation = "true"
            
        }else if stopCounter % 2 == 1{
            OurTImer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Action), userInfo: nil, repeats: true)
            stopButton.setTitle("ストップ", for: .normal)
            stopCounter += 1
            stopSituation = "false"
        }
        
    }
    
    
    @IBAction func finishBL(_ sender: Any) {
        let dialog = UIAlertController(title: "タイマーを終了しますか？", message: "終了してもポモドーロ数はリセットされません", preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "はい", style: .default, handler: {_ in
            self.OurTImer.invalidate()
            self.viewCount = 0
            self.a = 0
            self.b = 0
            self.tt = 0
            self.studyCount = 1
            self.stopCounter = 0
            self.stopSituation = "false"
            self.startSitu = "false"
            
            self.startButton.backgroundColor = UIColor.link
            self.startButton.setTitle("スタート", for: .normal)
            self.stopButton.setTitle("ストップ", for: .normal)
            self.countLabel.text = "00:00"
            self.situationLabel.text = "今の状況"
            self.sttp()
        }))
        dialog.addAction(UIAlertAction(title: "いいえ", style: .cancel, handler: nil))
        // 生成したダイアログを表示
        self.present(dialog, animated: true, completion: nil)
    }
    
    
}

