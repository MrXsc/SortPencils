import Foundation
import UIKit
import PlaygroundSupport
import AVFoundation


public class VCPoint : UIViewController,UITextFieldDelegate {
    
    var pencils = [UIButton]()
    var num = 10
    var note : UILabel!
    var label : UILabel!
    var minINdex = -1
    var min = 999
    var textf :UITextField!
    
    public override func viewDidLoad() {
        
        for index in 0...num-1{
            addPencil(x: 30, y: index*60+40,tag: index)
            
        }
        let labelend = UILabel(frame: CGRect(x: 50, y: 980, width: 220, height: 20))
        labelend.text = "Have a good time "
        labelend.font = UIFont(descriptor: UIFontDescriptor(name: "Medium", size: 20), size: 20)
        labelend.textColor = #colorLiteral(red: 0.9992693067, green: 0.4106049385, blue: 0.3488171399, alpha: 1)

        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        //add note label to see sub
        note = UILabel(frame: CGRect(x: 300, y: 0, width: 80, height: 80))
        note.layer.cornerRadius = 10
        note.layer.masksToBounds = true
        note.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        note.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        note.isHidden = true
        note.textAlignment = .center
        note.font = UIFont(descriptor: UIFontDescriptor(name: "Medium", size: 25), size: 25)
        
        
        label = UILabel(frame: CGRect(x: 30, y: 720, width: 300, height: 20))
        label.text = "Find Index of the Shortest Pencil"
        label.font = UIFont(descriptor: UIFontDescriptor(name: "Medium", size: 20), size: 20)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        textf = UITextField(frame: CGRect(x: 30, y: 640, width: 100, height: 50))
        textf.layer.cornerRadius = 10
        textf.layer.masksToBounds = true
        textf.backgroundColor = #colorLiteral(red: 0.8666198671, green: 0.8666198671, blue: 0.8666198671, alpha: 1)
        textf.placeholder = "index of min"
        textf.keyboardType = .numberPad
        textf.delegate = self
        textf.textAlignment = .center
        
        
        view.addSubview(textf)
        view.addSubview(label)
        view.addSubview(note)
        view.addSubview(labelend)
    }
    // textfiled delegate func
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text ?? "")
        textField.resignFirstResponder()
        if(textField.text == String("\(minINdex)")){
            print("ok")
            UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
                self.note.backgroundColor = #colorLiteral(red: 0.956210196, green: 0.7562709966, blue: 0.7132932839, alpha: 1)
                self.note.frame.size.width = 678
                self.note.frame.size.height = 1024
                self.note.text = " W I N !    "
                self.note.font = UIFont(descriptor: UIFontDescriptor(name: "Medium", size: 30), size: 30)
                self.note.frame.origin = CGPoint(x: 0, y:0)
                self.note.layer.cornerRadius = 0
            }, completion: nil)
        }
        return false
    }
    func addPencil(x : Int, y : Int,tag:Int)  {
        
        let width = Int(arc4random()%12*20 + 20)
        if(width<min){
            min = width
            minINdex = tag
        }
        
        let pencil = UIButton(frame: CGRect(x: x, y: y, width: width, height: 25))
       
        //Mark
        
        pencil.backgroundColor = RanColor(index :Int(arc4random()%9))
        
        pencil.tag = tag
        
        pencil.addTarget(self, action: #selector(btnAction(_:)), for: .touchDown)
        
        pencil.layer.cornerRadius = 5
        
        pencils.append(pencil)
        view.addSubview(pencil)
        print("x")
    }
    
    @objc func btnAction(_ sender: UIButton){
        playMusic(fileName: "touch.mp3")
        let x = sender.frame.origin.x
        let y = sender.frame.origin.y
        let w = sender.bounds.width
        let h = sender.bounds.height
        self.note.isHidden = false
        
        UIView.animateKeyframes(withDuration: 0.15, delay: 0, options: [], animations: {
            sender.frame.size.width = w + 60
            sender.frame.size.height = h + 40
            sender.frame.origin = CGPoint(x: x-20, y: y-20)
            sender.layer.cornerRadius = 20
        }, completion: nil)
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            self.note.frame.origin.y = y - 40
            self.note.text = "\(sender.tag)"
            
        }, completion: nil)
        //back
        UIView.animateKeyframes(withDuration: 0.8, delay: 0, options: [], animations: {
            sender.frame.size.width = w
            sender.frame.size.height = h
            sender.frame.origin = CGPoint(x: x, y: y)
            sender.layer.cornerRadius = 5
            
            
        }) { (true) in
            //self.note.isHidden = true
        }
        
        
        print(sender.tag)
    }
    
    //color
    public func RanColor(index :Int) -> UIColor {
        
        switch index {
        case 0:return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        case 1:return #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        case 2:return #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        case 3:return #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        case 4:return #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        case 5:return #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        case 6:return #colorLiteral(red: 0.2506145835, green: 0.7192841172, blue: 0.716160357, alpha: 1)
        case 7:return #colorLiteral(red: 1, green: 0.7801130414, blue: 0.9052978158, alpha: 1)
        default:
            return #colorLiteral(red: 0.9836056828, green: 0.6602786779, blue: 0.6627274752, alpha: 1)
        }
    }
    
    public var Player: AVAudioPlayer!
    
    
    public func playMusic(fileName: String) {
        let resourceUrl = Bundle.main.url(forResource: fileName, withExtension: nil)
        guard let url = resourceUrl else {
            print("Could not find file: \(fileName)")
            return
        }
        
        do {
            try Player = AVAudioPlayer(contentsOf: url)
            Player.numberOfLoops = 0 //not infinite loop
            Player.prepareToPlay()
            Player.play()
        } catch {
            print("Could not create audio player")
            return
        }
        
    }
}


