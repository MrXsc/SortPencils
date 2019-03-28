
import UIKit
import PlaygroundSupport
import AVFoundation

public class MyPen: UIButton {
    public var index = 0
}
public class VCSwap : UIViewController{
    
    var pencils = [MyPen]()
    var num = 9
    static public var sortArr = [Int]()
    var btnSwap :UIButton!
    
    var selectCount = 0
    var selindex1 = -1
    var selindex2 = -1
    
    var count = 0
    var runMan : UIView!
    
    
    var label : UILabel!
    /* public override func viewDidAppear(_ animated: Bool) {
     
     }*/
    
    public override func viewDidLoad() {
        runMan = UIView(frame: CGRect(x: 30, y: 0, width: 0, height: 30))
        runMan.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        self.view.addSubview(runMan)
        
        let labelend = UILabel(frame: CGRect(x: 50, y: 980, width: 220, height: 20))
        labelend.text = "Have a good time "
        labelend.font = UIFont(descriptor: UIFontDescriptor(name: "Medium", size: 20), size: 20)
        labelend.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        for index in 0...num-1{
            addPencil(x: 30, y: index*60+100,tag: index)
            
        }
        
        view.backgroundColor = #colorLiteral(red: 0.899287343, green: 0.961802423, blue: 1, alpha: 1)
        
        //add note label to see sub
       
        
        label = UILabel(frame: CGRect(x: 30, y: 720, width: 220, height: 20))
        label.text = "Click & Swap "
        label.font = UIFont(descriptor: UIFontDescriptor(name: "Medium", size: 20), size: 20)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(label)
        
        btnSwap = UIButton(frame: CGRect(x: 400, y: 300, width: 80, height: 80))
        btnSwap.backgroundColor = #colorLiteral(red: 0.9836056828, green: 0.6602786779, blue: 0.6627274752, alpha: 1)
        btnSwap.layer.cornerRadius = 40
        btnSwap.setTitle("S W A P", for: .normal)
        btnSwap.layer.masksToBounds = true
        btnSwap.addTarget(self, action: #selector(btnSwapAction), for: .touchDown)
        
        view.addSubview(btnSwap)
        view.addSubview(labelend)
    }
    
    //交换动画
    @objc func btnSwapAction(){
        if(selectCount==2){
            SwapPencil(index1: selindex1, index2: selindex2)
            if(IsFinish()){
                playMusic(fileName: "finish.mp3")
                self.btnSwap.isEnabled = false
                
                
                UIView.animateKeyframes(withDuration: 1, delay: 1, options: [], animations: {
                    self.btnSwap.setTitle(" W I N !     ", for: .normal)
                    self.btnSwap.frame.size.width = 678
                    self.btnSwap.frame.size.height = 1024
                    self.btnSwap.layer.cornerRadius = 0
                    self.btnSwap.frame.origin =  CGPoint(x: 0, y: 0)
                    
                    self.btnSwap.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "Heavy", size: 70), size: 70)
                }, completion: nil)
                
                return
            }
            UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: [], animations: {
                
                self.btnSwap.frame.size.width = 100
                self.btnSwap.frame.size.height = 100
                self.btnSwap.layer.cornerRadius = 50
                self.btnSwap.frame.origin = CGPoint(x: 380, y: 280)
                
                
                
                self.runMan.frame.size.width += 40
                if(self.runMan.frame.size.width > 400){
                    self.runMan.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
                }
                self.count += 1
                
            }, completion: nil)
            UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
                
                self.btnSwap.frame.size.width = 80
                self.btnSwap.frame.size.height = 80
                self.btnSwap.layer.cornerRadius = 40
                self.btnSwap.frame.origin = CGPoint(x: 400, y: 300)
            }, completion: nil)
        }else{
            UIView.animateKeyframes(withDuration: 0.05, delay: 0, options: [], animations: {
                self.btnSwap.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }, completion: nil)
            UIView.animateKeyframes(withDuration: 0.1, delay: 0.1, options: [], animations: {
                self.btnSwap.backgroundColor = #colorLiteral(red: 0.9836056828, green: 0.6602786779, blue: 0.6627274752, alpha: 1)
            }, completion: nil)
        }
    }
    
    func addPencil(x : Int, y : Int,tag:Int)  {
        
        
        let color = RanColor(index: Int(arc4random()%9))
        
        let pencil = MyPen(frame: CGRect(x: x, y: y, width: Int(arc4random()%20 * 10 + 30), height: 20))
        
        //Mark
        
        pencil.backgroundColor = color
        
        pencil.tag = tag
        pencil.index = tag
        pencil.addTarget(self, action: #selector(SelectPen(_:)), for: .touchDown)
        pencil.layer.cornerRadius = 5
        pencils.append(pencil)
        view.addSubview(pencil)
        VCSwap.sortArr.append( Int(pencil.frame.width) / 10)
        print("x")
    }
    
    
    
    
    //swap action
    func SwapPencil(index1:Int,index2:Int){
        let f1 = pencils[index1].frame
        let f2 = pencils[index2].frame
        
        //jump
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            self.pencils[index1].frame.origin.x = f1.origin.x + 50
            self.pencils[index2].frame.origin.x = f2.origin.x + 50
        }, completion: nil)
        
        //push,  get new line
        UIView.animateKeyframes(withDuration: 0.4, delay: 0.6, options: [], animations: {
            
            self.pencils[index1].frame.origin = f2.origin
            self.pencils[index2].frame.origin = f1.origin
            self.pencils[index1].setTitle("", for: .normal)
            self.pencils[index2].setTitle("", for: .normal)
            //size back
            
            self.pencils[index1].frame.size.height = 20
            self.pencils[index1].layer.cornerRadius = 3
            
            
            self.pencils[index2].frame.size.height = 20
            self.pencils[index2].layer.cornerRadius = 3
        }, completion: nil)
        
        //data back
        selectCount = 0
        selindex1 = -1
        selindex2 = -1
        
        let indexT = pencils[index1].index
        pencils[index1].index = pencils[index2].index
        pencils[index2].index = indexT
        
        SwapArr(index1: self.pencils[index1].index,index2: self.pencils[index2].index)
        print(VCSwap.sortArr)
        
        
        
        for x in pencils{
            print(x.index)
        }
        print("-----")
        
        
    }
    //MARK : user method
    public  func Swap(index1:Int,index2:Int){
        let f1 = pencils[index1].frame
        let f2 = pencils[index2].frame
        
        //jump
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            self.pencils[index1].frame.origin.x = f1.origin.x + 100
            self.pencils[index2].frame.origin.x = f2.origin.x + 100
            
        }, completion: nil)
        
        
        UIView.animateKeyframes(withDuration: 0.4, delay: 0.6, options: [], animations: {
            self.pencils[index1].frame.origin = f2.origin
            self.pencils[index2].frame.origin = f1.origin
            
        }, completion: nil)
        
    }
    
    @objc func SelectPen(_ sender: UIButton){
        //
        playMusic(fileName: "touch.mp3")
        
        if (sender.tag == selindex1 || sender.tag == selindex2){
            //1. 跟新 selindex
            ReloadSelect(index: sender.tag)
            //2. 缩小
            UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: [], animations: {
                sender.setTitle("", for: .normal)
                sender.frame.size.height = 20
                sender.layer.cornerRadius = 3
                
            }, completion: nil)
        }
        else
        {
            if(selectCount < 2){
                //1. 跟新 增加
                if(selindex1 == -1){
                    selindex1 = sender.tag
                }else{
                    selindex2 = sender.tag
                }
                selectCount += 1
                // 2.放 大
                UIView.animateKeyframes(withDuration: 0.1, delay: 0, options: [], animations: {
                    
                    sender.setTitle(String(Int(sender.frame.width)/10), for: .normal)
                    sender.frame.size.height = 30
                    sender.layer.cornerRadius = 5
                    
                }, completion: nil)
            }else{
                print("no")
            }
        }
    }
    
    func ReloadSelect(index : Int)  {
        if(index==selindex1){
            selindex1 = -1
            selectCount -= 1
        }
        if(index==selindex2){
            selindex2 = -1
            selectCount -= 1
        }
    }
    
    //color
    public func RanColor(index :Int) -> UIColor {
        switch index {
        case 0:return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        case 1:return #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        case 2:return #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        case 3:return #colorLiteral(red: 0.8476688862, green: 0.8346748948, blue: 0.07235179096, alpha: 1)
        case 4:return #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        case 5:return #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        case 6:return #colorLiteral(red: 0.2506145835, green: 0.7192841172, blue: 0.716160357, alpha: 1)
        case 7:return #colorLiteral(red: 1, green: 0.7801130414, blue: 0.9052978158, alpha: 1)
        default:
            return #colorLiteral(red: 0.9836056828, green: 0.6602786779, blue: 0.6627274752, alpha: 1)
        }
    }
    
    //model
    
    func SwapArr(index1:Int,index2:Int)  {
        let t = VCSwap.sortArr[index1]
        VCSwap.sortArr[index1] = VCSwap.sortArr[index2]
        VCSwap.sortArr[index2] = t
    }
    
    
     public func IsFinish() -> Bool {
        var isOK = true
        for x in 0...VCSwap.sortArr.count-2{
            if(VCSwap.sortArr[x]>VCSwap.sortArr[x+1]){
                isOK = false
                break
            }
        }
        return isOK
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
            //Player.numberOfLoops = -1 //infinite loop
            Player.prepareToPlay()
            Player.play()
        } catch {
            print("Could not create audio player")
            return
        }
        
    }
 
}
