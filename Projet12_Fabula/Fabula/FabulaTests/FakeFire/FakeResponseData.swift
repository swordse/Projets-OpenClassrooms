//
//  FakeResponseData.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 13/02/2022.
//

import Foundation
import UIKit
@testable import Fabula

final class FakeResponseData {
    
    class NetworkError: Error {}
    static let networkError = NetworkError()
    
    static func formatDateStringToDate(date: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm:ss Z"
        return formatter.date(from: date)!
    }
    
    static func getResultAnecdote() -> [[String: Any]] {
        let date = formatDateStringToDate(date: "2022-01-25 23:00:00 +0000")
        return [["title": "Difforme" as Any, "source": "https://www.pourlascience.fr/sd/art-science/linterminable-dos-de-la-grande-odalisque-3853.php" as Any, "id": "BBNnkxaB3Bik8bdBYuSB" as Any, "Date": date as Date, "category": "Art" as Any, "text": "La Grande Odalisque peinte en 1814 par Jean-Auguste Ingres a fait l’objet de vives critiques lors de son exposition. Le peintre a en effet ajouté cinq vertèbres au modèle. La position de la Grande Odalisque ne serait pas possible sans ces vertèbres supplémentaires." as Any]]
    }
    
    
    
    static let resultWord = [["definition": "ce qui définit" as Any, "word": "DEFINITION" as Any, "qualifier": "adjectif" as Any, "example": "exemple" as String]]
    
    static let resultQuote = [["author": "bob", "text": "le texte", "category": "Test Categorie"]]

    
//    [[ "id": "12", "category": "Science", "title": "Hello", "text": "le texte", "Date": Date()]]
    
    static let resultComment =  [["anecdoteId": "13", "commentText": "commentaire", "date": Date(), "userId": "dedededed", "userName": "bob"]]
    
    static let fakeAnecdote = Anecdote(id: "&é", categorie: Category.science, title: "titre", text: "text", date: "16/12/1980", isFavorite: false)
    
    static let fakeQuizzCategoryInfo = QuizzCategoryInfo(name: "bob", image: UIImage(named: "Histoire")!, color: .green)
    
    static let fakeArtCategory = [["Art": ["BILBO", "SAQUET"]]]
    static let fakeHistoryCategory = [["Histoire": ["BILBO", "SAQUET"]]]
    static let fakeScienceCategory = [["Science": ["BILBO", "SAQUET"]]]
    static let fakeLitteratureCategory = [["Littérature": ["BILBO", "SAQUET"]]]
    
    static let fakeCategories = [fakeArtCategory, fakeHistoryCategory, fakeScienceCategory, fakeLitteratureCategory]
    
    
    static let fakeQuizzData = [["title": "La lune" as Any, "question": "Quel est le diamètre de la lune?" as Any, "propositions": ["3474", "6800", "12000"] as Any, "category": "Science"as Any, "response": "3474"as Any]]
    
    static let fakeQuizz = [Quizz(category: "art", propositions: ["oui", "non"], question: "est ce que oui", response: "oui", title: "absurde"), Quizz(category: "art", propositions: ["oui", "non"], question: "est ce que oui", response: "oui", title: "absurde")]
    
    static let fakeThem = "les lampes"
}
