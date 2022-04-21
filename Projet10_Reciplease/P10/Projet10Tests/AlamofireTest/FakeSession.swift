//
//  FakeSession.swift
//  Projet10Tests
//
//  Created by Raphaël Goupille on 17/11/2021.
//

import Foundation
import Alamofire
@testable import Projet10

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
    
}

final class FakeEdamamSession: AlamofireSession {
    
    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
    func request(url: URL, callback: @escaping (AFDataResponse<Any>) -> Void) {
        let dataResponse = AFDataResponse<Any>(request: nil, response: fakeResponse.response, data: fakeResponse.data, metrics: nil, serializationDuration: 0, result: .success("OK"))
        callback(dataResponse)
    }

}
