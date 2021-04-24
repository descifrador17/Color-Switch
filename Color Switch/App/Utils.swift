//
//  Utils.swift
//  Color Switch
//
//  Created by Dayal, Utkarsh on 23/04/21.
//

import SpriteKit

enum PlayColours {
    static let colors = [UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0),
                         UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1.0),
                         UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0),
                         UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)]
}

enum SwitchState : Int{
    case red, yellow, green, blue
}

enum AppKeys{
    static let HIGHSCORE_KEY = "HighScore"
    static let RECENT_SCORE_KEY = "RecentScore"
}


