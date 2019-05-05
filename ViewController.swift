//
//  ViewController.swift
//  catchKenny
//
//  Created by HHK on 16.04.2019.
//  Copyright © 2019 Halil Hakan Karabay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var KennyArray = [UIImageView]()
    var hideTimer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let highScore = UserDefaults.standard.object(forKey: "highScore")
        
        if highScore == nil {
            highScoreLabel.text = "0"
        }
        
        if let newScore = highScore as? Int {
            highScoreLabel.text = String(newScore)
        }
        
        
        scoreLabel.text = "Score : \(score)"
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaScore)
        )
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaScore)
        )
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaScore)
        )
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaScore)
        )
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaScore)
        )
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaScore)
        )
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaScore)
        )
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaScore)
        )
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaScore)
        )
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        
        
        //timers
        counter = 30
        timeLabel.text = "Time : \(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideKenny), userInfo: nil, repeats: true)
        
        //arrays
        
        KennyArray.append(kenny1)
        KennyArray.append(kenny2)
        KennyArray.append(kenny3)
        KennyArray.append(kenny4)
        KennyArray.append(kenny5)
        KennyArray.append(kenny6)
        KennyArray.append(kenny7)
        KennyArray.append(kenny8)
        KennyArray.append(kenny9)
        
        hideKenny()
        
        
    }
    
    
    @objc func hideKenny() {
        for kenny in KennyArray {
            kenny.isHidden = true
        }
        
        let random = Int( arc4random_uniform(UInt32(KennyArray.count - 1)))
        
        KennyArray[random].isHidden = false
        
        
        
    }
    
    @objc func countDown() {
        
        counter = counter - 1
        timeLabel.text = "Time : \(counter)"
        
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            if self.score > Int(highScoreLabel.text!)! {
                UserDefaults.standard.set(self.score, forKey: "highScore")
                highScoreLabel.text = String(self.score)
            }
            
            
            let alert = UIAlertController(title: "Time", message: "Time's UP!", preferredStyle: UIAlertController.Style.alert)
            let okbutton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 30
                self.timeLabel.text = "Time : \(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideKenny), userInfo: nil, repeats: true)
                
            }
            alert.addAction(replayButton)
            alert.addAction(okbutton)
            self.present(alert,animated: true, completion: nil)
        }
    }
    @objc func increaScore() {
        score = score + 1
        scoreLabel.text = "Score : \(score)"
    }

}

