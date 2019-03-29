//
//  File.swift
//  Book_Sources
//
//  Created by student on 2019/3/21.
//
import Foundation
import PlaygroundSupport
import AVFoundation

//used to play background music
public var Player: AVAudioPlayer!


public func playMusic(fileName: String,loop :Int) {
    let resourceUrl = Bundle.main.url(forResource: fileName, withExtension: nil)
    guard let url = resourceUrl else {
        print("Could not find file: \(fileName)")
        return
    }
    
    do {
        try Player = AVAudioPlayer(contentsOf: url)
        Player.numberOfLoops = loop//infinite loop
        Player.prepareToPlay()
        Player.play()
    } catch {
        print("Could not create audio player")
        return
    }
    
}
