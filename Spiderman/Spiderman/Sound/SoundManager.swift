//
//  SoundManager.swift
//  LearningGame
//
//  Created by Tran Duy Tu on 1/16/20.
//  Copyright © 2020 Be Nguyen. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation

public class SoundManager: NSObject {
    static let shared = SoundManager()
    var player: AVAudioPlayer?
    
    public func playSucess() {
        let fileName = ["amazing", "brilliant", "excellent", "greatjob"][Int.random(in: 0...3)]
        playSound(fileName)
    }
    
    public func playIncorrect() {
        playSound("incorrect")
    }
    
    public func playCorrect() {
        playSound("correct")
    }
    
    public func playTap() {
        playSound("tap")
    }
    
    private func playSound(_ fileName: String) {
        let path = Bundle.main.path(forResource: "\(fileName)", ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            // couldn't load file :(
        }
    }
}
