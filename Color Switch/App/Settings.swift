//
//  Settings.swift
//  Color Switch
//
//  Created by Dayal, Utkarsh on 23/04/21.
//

import SpriteKit

enum Physicsategories{
    static let none: UInt32 = 0
    static let ballCategory: UInt32 = 0x1
    static let switchCategory: UInt32 = 0x1 << 1
}

struct CurrentUserData {
    
    var id: UUID

    init (id:UUID) {
        self.id = id
    }
}

class Global {

    static let sharedGlobal = Global()

    var currentUser: CurrentUserData?

}

let singleton = Global.sharedGlobal
