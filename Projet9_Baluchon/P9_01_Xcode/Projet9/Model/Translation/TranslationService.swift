//
//  TranslationService.swift
//  Projet9
//
//  Created by Raphaël Goupille on 29/08/2021.
//

import Foundation

// Get the translation of the text
final class TranslationService {
    
    private let session: URLSession
    private let baseStringURL: String = "https://translation.googleapis.com/language/translate/v2"
    
    init(session: URLSession = URLSession.init(configuration: .default)) {
        self.session = session
    }
    
    func getTranslation(textToTranslate: String, source: String, target: String, callback: @escaping(Result<TranslationResponseCodable, NetworkError>) -> Void) {
        
        let parameters = [("key", "AIzaSyCi_MKsn6t-Yb2SUvchQ4lp59gjUL39LFg"), ("q", "\(textToTranslate)"), ("source", "\(source)"), ("target", "\(target)"), ("format", "text")]
        
        guard let baseURL: URL = .init(string: baseStringURL) else {return}
        let url: URL = encode(with: baseURL, and: parameters)
        session.dataTask(with: url, callback: callback)
                            }

}

extension TranslationService: URLEncodable {}
