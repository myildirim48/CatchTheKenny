//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by YILDIRIM on 22.05.2022.
//

import UIKit

class ViewController: UIViewController {

    //Views
    @IBOutlet weak var timerLabel: UILabel!
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
    
    //Variables
    var score = 0
    var scoreTimer = Timer()
    var scoreTimerCounter = 0
    var highScore = 0
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Score label.text
        scoreLabel.text = "Score : \(score)"
        
        //High Score Check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "High Score : \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "High Score : \(highScore)"
        }
        
        //Kennys
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        //Recognizers
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        //Recognizers added
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        
        //Timer created
        scoreTimerCounter = 10
        timerLabel.text = String(scoreTimerCounter)
        scoreTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(scoreTimerFunc), userInfo: nil, repeats: true)
        
        //Hide Timer
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideAllKenny), userInfo: nil, repeats: true)
        
        //Kenny Array
        kennyArray = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        hideAllKenny()
        
        
    }
    
    //Hide the kennys
  @objc func hideAllKenny(){
        for kenny in kennyArray {  //Hide all kennys
            kenny.isHidden = true
        }
        //Random Kenny Hidden on
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
    }
    
    //Score Timer Count Down Function
    @objc func scoreTimerFunc() {
        scoreTimerCounter -= 1
        timerLabel.text = String(scoreTimerCounter)
        if scoreTimerCounter == 0 {
            scoreTimer.invalidate()
            hideTimer.invalidate()

            //When time finished hide all kenny
            for kenny in kennyArray {  //Hide all kennys
                kenny.isHidden = true
            }
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "High Score : \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            
            
            //Times over Alert
            let alertTimesOver = UIAlertController(title: "Time's Up", message: "Time's over.", preferredStyle: UIAlertController.Style.alert)
            
            //Replay
            let replayButtonInAlert = UIAlertAction(title: "Restart", style: UIAlertAction.Style.default) { [self] UIAlertAction in
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.scoreTimerCounter = 10
                self.timerLabel.text = String(self.scoreTimerCounter)
                
                //Game Timer
                scoreTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.scoreTimerFunc), userInfo: nil, repeats: true)
                
                //Hide Timer
                hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideAllKenny), userInfo: nil, repeats: true)
                
                
                
                
            }
            
            let okButtonInAlert = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            
            alertTimesOver.addAction(okButtonInAlert)
            alertTimesOver.addAction(replayButtonInAlert)
            self.present(alertTimesOver, animated: true, completion: nil)
        }
    }

    //Score increase Function
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score : \(score)"
    }
}

