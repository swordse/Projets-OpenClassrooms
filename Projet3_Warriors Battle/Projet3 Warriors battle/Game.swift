
import Foundation

final class Game {
    
    // MARK: - Properties
    
    let numberOfTeams = 2
    let teamCreator = TeamCreator()
    var teams = [Team]()
    var turn = 0
    // calculate the opponentIndex based on the current turn
    var opponentTeamIndex: Int { turn % 2 == 0 ? 1 : 0 }
    // keep track of all the dead characters for the end game stats
    var deadCharacters = [Character]()
    
    // MARK: - Methods
    
   func start() {
        print(Constants.presentation)
        teamCreator.createTeams()
        teams = teamCreator.teams
        fight()
    }
    
    private func fight() {
        print(Constants.separator + "\n")
        print("GOOD! You have created your teams. \n⚔️⚔️⚔️⚔️LET'S FIGHT!!!⚔️⚔️⚔️⚔️")
        
        while true {
            for i in 0 ..< numberOfTeams {
                
                // get the fighter
                print(Constants.separator + "\n")
                print(teams[i].name.uppercased() + ": \(Constants.chooseFighter)")
                let playerChoice = teams[i].teamChoice()
                let chosenFighter = teams[i].characters[playerChoice]
                // if the fighter is a mage, he can heal or attack
                if let mage = chosenFighter as? Mage {
                    if mage.mageChoiceHeal() {
                        // mage has chosen to heal: get the teammate to heal
                        print(Constants.chooseCharacterToHeal)
                        let playerChoice = teams[i].teamChoice()
                        let teammateToHeal = teams[i].characters[playerChoice]
                        mage.heal(teammateToHeal: teammateToHeal)
                    } else  {
                        // mage has chosen to attack: get the opponent
                        print(Constants.chooseOpponent)
                        let playerChoice = teams[opponentTeamIndex].teamChoice()
                        let opponentCharacter = teams[opponentTeamIndex].characters[playerChoice]
                        mage.attack(against: opponentCharacter)
                        removeDeadCharacter(opponentCharacter: opponentCharacter, teamIndex: opponentTeamIndex, characterIndex: playerChoice)
                        if checkWin() {
                            return
                        }
                    }
                } else {
                    // if the fighter is not a mage, get the opponent
                    print(Constants.chooseOpponent)
                    let playerChoice = teams[opponentTeamIndex].teamChoice()
                    let opponentCharacter = teams[opponentTeamIndex].characters[playerChoice]
                    chosenFighter.attack(against: opponentCharacter)
                    removeDeadCharacter(opponentCharacter: opponentCharacter, teamIndex: opponentTeamIndex, characterIndex: playerChoice)
                    if checkWin() {
                        return
                    }
                }
                turn += 1
            }
        }
    }
    
    private func removeDeadCharacter(opponentCharacter: Character, teamIndex: Int, characterIndex: Int) {
        if opponentCharacter.isAlive == false {
            teams[teamIndex].characters.remove(at: characterIndex)
            deadCharacters.append(opponentCharacter)
        }
    }
    
    private func checkWin() -> Bool {
        var win = false
        for i in 0 ..< numberOfTeams {
            if teams[i].characters.isEmpty {
                var winnerIndex: Int { i % 2 == 0 ? 1 : 0 }
                print(Constants.separator)
                print("\n        🏆🏆🏆 \(teams[winnerIndex].name.uppercased()) WINS!!!!!!!🏆🏆🏆\n" )
                print(Constants.separator)
                turn += 1
                displayStats(team: teams[winnerIndex])
                win = true
            }
        }
        return win
    }
    
    // display the stats of the game
    private func displayStats(team: Team) {
        print("You have killed all the other team's characters in: \(turn) turns."
                + "\nAfter this fight, here are the statistics of your characters still alive:")
        for character in team.characters {
            print("- Name: \(character.name) - type: \(character.kind) - life: \(character.health) - weapon: \(character.weapon) ")
        }
        print("\n" + Constants.separator)
        print("Here are the statistics of the characters killed:")
        for character in deadCharacters {
            print("- Name: \(character.name) - type: \(character.kind) - life: 0 - weapon: \(character.weapon) ")
        }
        print("\n" + Constants.separator)
        resetGame()
    }
    
    // after a win: reset the Game to play again or to end
    private func resetGame() {
        turn = 0
        print("Do you want to play again?"
                + "\n1. Yes"
                + "\n2. No")
        
        if let choice = readLine() {
            if let intChoice = Int(choice) {
                switch intChoice {
                case 1:
                    start()
                case 2:
                    print("Thanks for playing. Hope to see you soon.\nGoodbye")
                default:
                    print("You must choose 1 or 2.")
                }
            } else {
                print("You must choose 1 or 2.")
            }
        }
    }
    
    
    
}

