//
//  Mage.swift
//  Projet3 Warriors battle
//
//  Created by Raphaël Goupille on 10/05/2021.
//

import Foundation

final class Mage: Character {
    
    init(name: String) {
        super.init(kind: .mage, name: name, health: 15, weapon: .magicWand)
    }
    
    // specific action for the mage: he can choose to heal or to attack
    func mageChoiceHeal() -> Bool {
        var bool = Bool()
        print("Do you want to attack an opponent character or to heal one of your teammate? \n1. Attack. \n2. Heal.")
        if let choice = readLine() {
            switch choice {
            case "1":
                bool = false
            case "2":
                bool = true
            default: print("You must enter 1 or 2")
            }
        }
        return bool
    }
    
    func heal(teammateToHeal: Character) {
        self.findBox()
        teammateToHeal.health += self.weapon.rawValue
        print(Constants.separator)
        print("\(teammateToHeal.name) has been healed. His health is: \(teammateToHeal.health)")
    }
    
    
}
