//
//  Character.swift
//  Projet3 Warriors battle
//
//  Created by Raphaël Goupille on 10/05/2021.
//

import Foundation


class Character {
    
    // MARK: - Properties
    
    let kind: Kind
    let name: String
    var health: Int
    var weapon: Weapons
    var isAlive: Bool { health > 0 }
    
    init(kind: Kind, name: String, health: Int, weapon: Weapons) {
        self.kind = kind
        self.name = name
        self.health = health
        self.weapon = weapon
        
    }
    
    enum Weapons: Int {
        case axe = 100
        case magicWand = 5
        case sword = 7
        case superAxe = 20
        case superMagicWand = 15
        case superSword = 14
    }
    
    enum Kind: String {
        case dwarf
        case mage
        case soldier
    }
    
    // MARK: - Methods
    
    // randomly find a box which contains a magic weapon
    func findBox() {
        let random = Int.random(in: 1...5)
        if random == 1 || random == 2 || random == 3 {
            if self is Mage {
                self.weapon = .superMagicWand
                print("\n" + Constants.separator)
                print("      🎁 You have found a MAGIC BOX which contains a \(self.weapon) 🪄. It can attack or heal: \(self.weapon.rawValue)")
                print("\n" + Constants.separator)
            }
            if self is Dwarf {
                self.weapon = .superAxe
                print("\n" + Constants.separator)
                print("      🎁 You have found a MAGIC BOX which contains a \(self.weapon) 🪓. It can attack: \(self.weapon.rawValue)")
                print("\n" + Constants.separator)
            }
            if self is Soldier {
                self.weapon = .superSword
                print("\n" + Constants.separator)
                print("      🎁 You have found a MAGIC BOX which contains a \(self.weapon)🗡. It can attack: \(self.weapon.rawValue)")
                print("\n" + Constants.separator)
            }
        }
        
    }
    
    func attack(against opponent: Character) {
        findBox()
        print("\n" + Constants.separator)
        opponent.health -= weapon.rawValue
        if opponent.isAlive {
            print("      \(opponent.name) has been attacked. His remaining life is: \(opponent.health)")
        } else {
            print("      ☠️ Ohh! MY GOSH!!!! \(opponent.name) has been killed!!! ☠️")
        }
    }
    
}



