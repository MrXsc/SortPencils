//
//  Sort.swift
//  Book_Sources
//
//  Created by student on 2019/3/20.
//


import UIKit
import PlaygroundSupport

public class VCSort:UIViewController {
    
    var pencils = [MyPen]()
    var num = 9
    public var sortArr = [Int]()
    
    var btnSwap :UIButton!
    var btnMin:UIButton!
    
    var selectCount = 0
    var selindex1 = -1
    var selindex2 = -1

    var label : UILabel!
    
    var countFinished = 0
    
    /* public override func viewDidAppear(_ animated: Bool) {
     
     }*/
    
    public override func viewDidLoad() {
        
        
        for index in 0...num-1{
            addPencil(x: 30, y: index*70+100,tag: index)
            
        }
        
        view.backgroundColor = #colorLiteral(red: 0.9128127694, green: 0.9207462668, blue: 1, alpha: 1)
        
        //add note label to see sub
        
        
        label = UILabel(frame: CGRect(x: 30, y: 720, width: 220, height: 20))
        label.text = "Select then Swap "
        label.font = UIFont(descriptor: UIFontDescriptor(name: "Medium", size: 20), size: 20)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(label)
        let labelend = UILabel(frame: CGRect(x: 50, y: 980, width: 220, height: 20))
        labelend.text = "Have a good time "
        labelend.font = UIFont(descriptor: UIFontDescriptor(name: "Medium", size: 20), size: 20)
        labelend.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
   
        
        btnMin = UIButton(frame: CGRect(x: 400, y: 400, width: 80, height: 80))
        btnMin.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        btnMin.layer.cornerRadius = 40
        btnMin.setTitle(" M I N ", for: .normal)
        btnMin.layer.masksToBounds = true
        btnMin.addTarget(self, action: #selector(btnMinAction), for: .touchDown)
        view.addSubview(btnMin)
        
        btnSwap = UIButton(frame: CGRect(x: 400, y: 300, width: 80, height: 80))
        btnSwap.backgroundColor = #colorLiteral(red: 0.9836056828, green: 0.6602786779, blue: 0.6627274752, alpha: 1)
        btnSwap.layer.cornerRadius = 40
        btnSwap.setTitle("S W A P", for: .normal)
        btnSwap.layer.masksToBounds = true
        btnSwap.addTarget(self, action: #selector(btnSwapAction), for: .touchDown)
        
        view.addSubview(btnSwap)
        
        
        view.addSubview(labelend)
    }
    
    func findMin() -> Int{
        var min = 999
        var minIndex =  countFinished
        for x in countFinished ... 8{
            if(sortArr[x] < min){
                minIndex = x
                min = sortArr[x]
            }
        }
        return minIndex
    }
    
    func getPencil(index : Int)->Int {
        var  tag = 0
        for x in pencils{
            if(x.index == index){
                tag = x.tag
            }
        }
        return tag
    }
    
    @objc func btnMinAction(){
        
        if(selectCount == 0){
            selindex1 = getPencil(index: findMin())
            let p = pencils[selindex1]
            UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: [], animations: {
                p.setTitle(String(Int(p.frame.width)/10), for: .normal)
                p.frame.size.height = 30
                p.layer.cornerRadius = 5
                p.backgroundColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
            }, completion: nil)
           selectCount = 1
        }
        UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: [], animations: {
            
            self.btnMin.frame.size.width = 100
            self.btnMin.frame.size.height = 100
            self.btnMin.layer.cornerRadius = 50
            self.btnMin.frame.origin = CGPoint(x: 380, y: 380)
            
        }, completion: nil)
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            
            self.btnMin.frame.size.width = 80
            self.btnMin.frame.size.height = 80
            self.btnMin.layer.cornerRadius = 40
            self.btnMin.frame.origin = CGPoint(x: 400, y: 400)
        }, completion: nil)
        
    }
    //交换按钮 动画
    @objc func btnSwapAction(){
        playMusic(fileName: "touch.mp3", loop: 0)
    
        if(selectCount==1){
            selindex2 = getPencil(index: countFinished)
            print("1 : \(selindex1) , 2: \(selindex2)")
            if(selindex1 == selindex2){
                let p = pencils[getPencil(index: selindex1)]
                selectCount = 0
                selindex1 = -1
                selindex2 = -1
                p.setTitle("", for: .normal)
                //size back
                
                p.frame.size.height = 20
                p.layer.cornerRadius = 3
                // 透明
                
            }else{
                
                SwapPencil(index1: selindex1, index2: selindex2)
            }
            countFinished += 1
            print(" countFinished: \(countFinished)")
            
           
            selindex1 = -1
            selindex2 = -1
            selectCount = 0
            
            if(IsFinish()){
                playMusic(fileName: "touch.mp3", loop: 0)
                self.btnSwap.isEnabled = false
                for x in pencils{
                    x.backgroundColor = RanColor(index: Int(arc4random()%9))
                    x.setTitle("", for: .normal)
                }
                UIView.animateKeyframes(withDuration: 0.5, delay: 0.7, options: [], animations: {
                    
                    self.btnSwap.setTitle(" W I N !    ", for: .normal)
                    
                    self.btnSwap.frame.size.width = 678
                    self.btnSwap.frame.size.height = 1024
                    self.btnSwap.layer.cornerRadius = 0
                    self.btnSwap.frame.origin =  CGPoint(x: 0, y: 0)
                    
                    self.btnSwap.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "Heavy", size: 70), size: 70)
                }, completion: nil)
                playMusic(fileName: "finish.mp3", loop: 3)
                return
            }
        }
        UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: [], animations: {
            
            self.btnSwap.frame.size.width = 100
            self.btnSwap.frame.size.height = 100
            self.btnSwap.layer.cornerRadius = 50
            self.btnSwap.frame.origin = CGPoint(x: 380, y: 280)
            
        }, completion: nil)
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            
            self.btnSwap.frame.size.width = 80
            self.btnSwap.frame.size.height = 80
            self.btnSwap.layer.cornerRadius = 40
            self.btnSwap.frame.origin = CGPoint(x: 400, y: 300)
        }, completion: nil)
        
        for x in pencils{
            print("pencils  pen : index:\(x.index)  , tag :\(x.tag)")
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
        sortArr.append( Int(pencil.frame.width) / 10)
       
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
        //MARK--------------
        
        let indexT = pencils[index1].index
        pencils[index1].index = pencils[index2].index
        pencils[index2].index = indexT
 
        
        
        
        
        SwapArr(index1: self.pencils[index1].index,index2: self.pencils[index2].index)
        print(sortArr)
        
        
        
        
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
        playMusic(fileName: "touch.mp3", loop: 0)
        
        UIView.animateKeyframes(withDuration: 0.1, delay: 0, options: [], animations: {
            
            sender.setTitle(String(Int(sender.frame.width)/10), for: .normal)
            sender.frame.size.height = 30
            sender.layer.cornerRadius = 5
            
        }, completion: nil)
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            
            sender.frame.size.height = 20
            sender.layer.cornerRadius = 3
        }, completion: nil)
        //sender.setTitle("", for: .normal)
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
        let t = sortArr[index1]
        sortArr[index1] = sortArr[index2]
        sortArr[index2] = t
    }
    
    
    
    public func IsFinish() -> Bool {
        var isOK = true
        for x in 0...sortArr.count-2{
            if(sortArr[x]>sortArr[x+1]){
                isOK = false
                break
            }
        }
        return isOK
    }
    
}
