//
//  LanguagesService.swift
//  Projet9
//
//  Created by Raphaël Goupille on 31/08/2021.
//

import Foundation

// get the list of available languages
class LanguagesService {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    private let baseStringURL: String = "https://translation.googleapis.com/language/translate/v2/languages?key=AIzaSyCi_MKsn6t-Yb2SUvchQ4lp59gjUL39LFg&target=fr"

    
    func fetchLanguages(callBack: @escaping (Result<DataLanguagesCodable, NetworkError>) -> Void) {
        guard let url: URL = .init(string: baseStringURL) else { return }
        
        session.dataTask(with: url, callback: callBack)
        
    }
    
}
