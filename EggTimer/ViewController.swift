
import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    @IBOutlet weak var labelEgg: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    let timings=["Soft":3,"Medium":4,"Hard":7]
    var player:AVAudioPlayer!
    var totalTime=0
    var secondsPassed=0
    var timer=Timer()
    //all three buttons linked to same IBAction
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness=sender.currentTitle!
        totalTime=timings[hardness]! //setting the timing of egg from the dictionary
        progressBar.progress=0.0 //setting the progress bar as 0 initially
        secondsPassed=0
        labelEgg.text=hardness
        timer=Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(updateTimer), userInfo:nil, repeats: true)
    }
    //this function will be called by the selector in Timer everytime the button is tapped
    @objc func updateTimer()
    {
        if secondsPassed<totalTime
        {
            secondsPassed+=1
            //let progress=Float(secondsPassed)/Float(totalTime)
            UIView.animate(withDuration:Double(totalTime))
            {
                self.progressBar.setProgress(1.0, animated: true)
            }
        }
        else
        {
            timer.invalidate()
            labelEgg.text="DONE"
            let url=Bundle.main.url(forResource:"alarm_sound" , withExtension:"mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
                    
        }
    }
}
