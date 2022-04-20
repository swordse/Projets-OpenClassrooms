//
//  TeamCreator.swift
//  Projet3 Warriors battle
//
//  Created by Raphaël Goupille on 10/05/2021.
//

import Foundation


final class TeamCreator {
    
    // MARK: - Properties
    
    let numberOfTeam = 2
    let numberOfCharacters = 3
    var names = [String]()
    var teams = [Team]()
    
    // MARK: Methods
    
    func createTeams() {
        for i in 0 ..< numberOfTeam {
            let team = Team(name: uniqueTeamName(team: i))
            team.characters = createCharacters()
            teams.append(team)
            }
    }
    
    private func createCharacters() -> [Character] {
        var characters = [Character]()
        print("Choose the 3 characters of your team:")
        print(Constants.separator)
        for i in 0 ..< numberOfCharacters {
            if let character = createCharacter(number: i) {
            characters.append(character)
            }
        }
        return characters
    }
    
    private func createCharacter(number: Int) -> Character? {
        var playerChoice = 0
        repeat {
        print("You have to choose \(3 - number) more character(s): \n1. Dwarf \n2. Mage \n3. Soldier")
            if let choice = readLine(){
                if let intChoice = Int(choice) {
                    playerChoice = intChoice
                } else {
                    print("You have to choose a number.")
                }
            }
        } while playerChoice != 1 && playerChoice != 2 && playerChoice != 3
        
                switch playerChoice {
                case 1 :
                    return Dwarf(name: uniqueCharacterName(kind: "Dwarf"))
                case 2:
                    return Mage(name: uniqueCharacterName(kind: "Mage"))
                case 3:
                    return Soldier(name: uniqueCharacterName(kind: "Soldier"))
                default:
                return nil
                }
    }
    
    // check if the TeamName is already used
    private func uniqueTeamName(team: Int) -> String {
        var teamName = ""
        repeat {
            print(Constants.separator)
            print("PLAYER \(team + 1): choose a name for your team :")
            if let name = readLine() {
                if names.contains(name) {
                    print("This name is already used. Please choose another one:")
                } else {
                    teamName = name
                    names.append(teamName)
                    return teamName
                }
            }
        } while teamName == ""
        return teamName
    }
    
    // check if the characterName is already used
    private func uniqueCharacterName(kind: String) -> String {
        var characterName = ""
        repeat {
            print("Choose a name for your \(kind) :")
            if let name = readLine() {
                characterName = name
                if names.contains(characterName) {
                    print("This name is already used. Please choose another one:")
                    characterName = ""
                } else {
                    names.append(characterName)
                    return characterName
                }
            }
        } while characterName == ""
        return characterName
    }
    
    
}
