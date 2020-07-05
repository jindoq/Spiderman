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

public class SoundManager {
    public static var player: AVAudioPlayer?
    
    public static func playSucess() {
        let fileName = ["amazing", "brilliant", "excellent", "greatjob"][Int.random(in: 0...3)]
        playSound(fileName)
    }
    
    public static func playIncorrect() {
        playSound("incorrect")
    }
    
    public static func playCorrect() {
        playSound("correct")
    }
    
    public static func playTap() {
        playSound("tap")
    }
    
    public static func playSound(_ fileName: String) {
        let path = Bundle(for: SoundManager.self).path(forResource: "\(fileName)", ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            // couldn't load file :(
        }
    }
}
