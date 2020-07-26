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
        play(fileName)
    }
    
    public static func playIncorrect() {
        play("incorrect")
    }
    
    public static func playCorrect() {
        play("correct")
    }
    
    public static func playTap() {
        play("tap")
    }
    
    public static func play(_ fileName: String) {
        let path = Bundle(for: SoundManager.self).path(forResource: "\(fileName)", ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    public static func playSound(_ fileName: String) {
        if let path = Bundle.main.path(forResource: "\(fileName)", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch {
                // couldn't load file :(
            }
        }
    }
}
