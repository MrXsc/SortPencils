//
//  Hello.swift
//  PlaygroundBook
//
//  Created by XS on 2019/3/20.
//

import UIKit
import PlaygroundSupport
import AVFoundation

public class VCHello: UIViewController {
    
    public var isBigBtn = false
    public var btn :UIButton!
    var btnLine :UIView!
    var btn1Line :UIView!
    var pencils :[UIButton]!
    var pencilTitle : UILabel!
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision : UICollisionBehavior!
    
   
    public override func viewDidLoad() {
        view.backgroundColor = #colorLiteral(red: 0.9268571734, green: 0.9232329726, blue: 1, alpha: 1)
        //create a label
        let labelend = UILabel(frame: CGRect(x: 50, y: 980, width: 220, height: 20))
        labelend.text = "Have a good time "
        labelend.font = UIFont(descriptor: UIFontDescriptor(name: "Medium", size: 20), size: 20)
        labelend.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let  sayHello = UILabel(frame: CGRect(x: 320, y: 500, width:150, height: 300))
        
        sayHello.text = "Hello WWDC 19"
        sayHello.numberOfLines = 3
        sayHello.textAlignment = .right
        sayHello.font = UIFont(descriptor: UIFontDescriptor(name: "Thin", size: 50), size: 50)
      
        btn = UIButton(frame: CGRect(x: 300, y: 200, width: 100, height: 100))
        btn.backgroundColor = #colorLiteral(red: 0.9836056828, green: 0.6602786779, blue: 0.6627274752, alpha: 1)
        btn.layer.cornerRadius = 50
        btn.layer.masksToBounds = true
        
        view.addSubview(sayHello)
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(btnAction), for: .touchDown)
        
        
        btnLine = UIView(frame: CGRect(x: 397, y: 250, width: 3, height: 200))
        btnLine.backgroundColor = #colorLiteral(red: 0.9836056828, green: 0.6602786779, blue: 0.6627274752, alpha: 1)
        btnLine.tintColor = #colorLiteral(red: 0.9836056828, green: 0.6602786779, blue: 0.6627274752, alpha: 1)
        view.addSubview(btnLine)
        
        btn1Line = UIView(frame: CGRect(x: 250, y: 250, width: 3, height: 200))
        btn1Line.backgroundColor = #colorLiteral(red: 0.9836056828, green: 0.6602786779, blue: 0.6627274752, alpha: 1)
        btn1Line.tintColor = #colorLiteral(red: 0.9836056828, green: 0.6602786779, blue: 0.6627274752, alpha: 1)
        view.addSubview(btn1Line)
        
        pencilTitle = UILabel(frame: CGRect(x: 100, y: 30, width: 400, height: 500))
        pencilTitle.numberOfLines = 3
        pencilTitle.isHidden = true
        pencilTitle.text = "How To Sort Pencils"
        pencilTitle.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        pencilTitle.font = UIFont(descriptor: UIFontDescriptor(name: "Heavy", size: 80), size: 80)
        view.addSubview(pencilTitle)
        
        RainPencil()
        view.addSubview(labelend)
    }
    
    //animation
    func RainPencil()  {
        self.animator = UIDynamicAnimator(referenceView: self.view)
        self.gravity = UIGravityBehavior()
        self.collision = UICollisionBehavior()
        self.animator.addBehavior(self.collision)
        self.animator.addBehavior(self.gravity)
        self.gravity.magnitude = 0.9
        self.collision.translatesReferenceBoundsIntoBoundary = true // set edge
        
        
        
        
    }
    
    public func Hello()  {
        playMusic(fileName: "touch.mp3")
        for _ in 0...10{
            dropRain()
        }
        // is big tag action
        if(isBigBtn){
            UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: [], animations: {
                self.btn.frame.size.width = 100
                self.btn.frame.size.height = 100
                self.btn.layer.cornerRadius = self.btn.frame.width / 2
                self.btn.frame.origin = CGPoint(x: 300, y: 200)
            }, completion: nil)
            self.pencilTitle.isHidden = true
            isBigBtn = false
        }else{
            UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: [], animations: {
                self.btn.frame.size.width = 1300
                self.btn.frame.size.height = 1300
                self.btn.layer.cornerRadius = self.btn.frame.width / 2
                self.btn.frame.origin = CGPoint(x: -270, y: -150)
            }, completion: nil)
            self.pencilTitle.isHidden = false
           
            isBigBtn = true
        }
    }
    
    //btn action
     @objc func btnAction(){
        Hello()
    }
    
    //droping pencils rain
    func dropRain()  {
        let drop = UIView(frame: CGRect(x: 30 + 22 * Double(arc4random() % 30), y: 0, width: 4, height: 25))
        drop.backgroundColor = RanColor(index: Int(arc4random()%9))
        drop.isUserInteractionEnabled = true
        self.view.addSubview(drop)
        gravity.addItem(drop)
        collision.addItem(drop)
    }
    
    //play music function
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
            //Player.prepareToPlay()
            Player.play()
        } catch {
            print("Could not create audio player")
            return
        }
        
    }
}


