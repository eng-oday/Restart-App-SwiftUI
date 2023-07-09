//
//  AudioPlayer.swift
//  Restart-App
//
//  Created by 3rabApp-oday on 09/07/2023.
//

import Foundation
import AVFoundation


var audioPlayer:AVAudioPlayer?

func PlaySound(sound:String , type:String)
{
    if let path = Bundle.main.path(forResource: sound , ofType: type) {
        do {
            if #available(iOS 16.0, *) {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
                audioPlayer?.play()
            } else {
                // Fallback on earlier versions
            }
        }catch{
            print("could not play sound .")
        }
        
    }
}
