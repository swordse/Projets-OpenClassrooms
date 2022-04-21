//
//  FavoriteViewModel.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 12/01/2022.
//

import Foundation
import UIKit

final class FavoriteViewModel {
    
    var coreDataService: BackupSession
    var anecdoteDetailDelegate: AnecdoteDetailDelegate!
    var favorites = [Anecdote]()
    let favoriteNavButton = BadgedButtonItem.shared
    
    init(coreDataService: BackupSession = CoreDataService(coreDataStack: CoreDataStack()), anecdoteDetailDelegate: AnecdoteDetailDelegate) {
        self.coreDataService = coreDataService
        self.anecdoteDetailDelegate = anecdoteDetailDelegate
    }
    
    //    MARK: - Output
    var favoriteAnecdote: (([Anecdote])-> Void)?
    
    //    MARK: - Methods
    // retrieve favorite from CoreData
    func getFavorite() {
        let favorites = coreDataService.favorites
        
        favoriteNavButton.setBadge(with: favorites.count)
        
        let anecdotes: [Anecdote] = favorites.map { favorite in
            let source = favorite.source
            let id = favorite.id ?? ""
            let categorie = Category(rawValue: favorite.categorie ?? "Picture")
            let title = favorite.title ?? ""
            let text = favorite.text ?? ""
            let date = favorite.date ?? ""
            return Anecdote(id: id, categorie: categorie!, title: title, text: text, source: source, date: date, isFavorite: true)
        }
        favoriteAnecdote?(anecdotes)
    }
    // show detailAnecdote when row is selected
    func selectedRow(anecdote: Anecdote, commentIsTapped: Bool, isFavoriteNavigation: Bool) {
        let selectedFavorite = anecdote
        anecdoteDetailDelegate.getDetail(anecdote: selectedFavorite, commentIsTapped: commentIsTapped, isFavoriteNavigation: isFavoriteNavigation)
    }
}
