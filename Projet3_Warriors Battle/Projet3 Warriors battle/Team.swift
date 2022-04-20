//
//  Team.swift
//  Projet3 Warriors battle
//
//  Created by Raphaël Goupille on 10/05/2021.
//

import Foundation

final class Team {
    
    // MARK: - Properties
    
    let name: String
    var characters = [Character]()
    
    
    init(name: String) {
        self.name = name
    }
    // MARK: - Methods
    /// func to obtain the player's choice among the array of characters
    func teamChoice() -> Int {
        var playerChoice = 0
        var number = 1
        var numbers: [Int] = []
        for character in characters {
            if character.isAlive {
                if character is Mage {
                    print("\(number). \(character.kind.rawValue.uppercased()): \(character.name), health: \(character.health), attack points: \(character.weapon.rawValue), healing points: \(character.weapon.rawValue)")
                    numbers.append(number)
                    number += 1
                } else {
                    print("\(number). \(character.kind.rawValue.uppercased()): \(character.name), health: \(character.health), attack points: \(character.weapon.rawValue)")
                    numbers.append(number)
                    number += 1
                }
            }
        }
        repeat {
            if let choice = readLine() {
                if let intChoice = Int(choice) {
                    if numbers.contains(intChoice){
                        playerChoice = intChoice
                    } else {
                        print("Choose an available number:")
                    }
                } else {
                    print("You must enter a number.")
                }
            }
        } while numbers.contains(playerChoice) == false
        return playerChoice - 1
    }
    
}

