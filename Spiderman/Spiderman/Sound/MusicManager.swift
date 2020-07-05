//
//  SoundManager.swift
//  Toeic
//
//  Created by DuyTu-Kakashi on 11/2/17.
//  Copyright © 2017 TranDuyTu. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation

public class MusicManager: NSObject {
    static let shared = MusicManager()
    var player: AVAudioPlayer?
    
    public func playSound() {
        let path = Bundle.main.path(forResource: "background_home", ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = 9999
            player?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    public func stopSound() {
        player?.stop()
    }
}

var offSound: Bool {
    get {
        return UserDefaults.standard.bool(forKey: "play_sound")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "play_sound")
        UserDefaults.standard.synchronize()
    }
}
