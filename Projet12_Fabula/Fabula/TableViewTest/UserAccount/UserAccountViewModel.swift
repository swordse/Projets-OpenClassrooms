//
//  UserAccountViewModel.swift
//  Fabula
//
//  Created by Raphaël Goupille on 14/02/2022.
//

import Foundation


class UserAccountViewModel {
    
    var authService = AuthService()
    
    init(authService: AuthService = AuthService()) {
        self.authService = authService
    }
    
    // -MARK: Output:
    
    var accountCreationResult: ((Result<Bool, NetworkError>) -> Void)?
    
    var signInResult: ((Result<Bool, NetworkError>) -> Void)?
    
    // -MARK: Methods
    func accountCreation(userEmail: String, password: String, userName: String) {
        
        // logout if a user is connected
        self.authService.logOut()
        
        authService.createAccount(userEmail: userEmail, password: password, userName: userName) { result in
                        
            switch result {
                // if failure, transmit the error
            case.failure(let error):
                self.accountCreationResult?(.failure(error))
        
                // if success
            case.success(_):
                // save the connexion state
                UserDefaultsManager().userIsConnected(true)
                // get the userId and create a fabulaUser
                self.authService.getCurrentUser { fabulaUser in
                    guard let fabulaUser = fabulaUser else { return }
                    var newFabulaUser = fabulaUser
                    newFabulaUser.userName = userName
                    
                    // save the new user in UserDefault
                    UserDefaultsManager().saveUser(userName: newFabulaUser.userName, userId: newFabulaUser.userId, userEmail: newFabulaUser.userEmail)
                    
                    // save the new user in Firestore
                    self.authService.saveUser(user: newFabulaUser)
                    self.accountCreationResult?(.success(true))
                    
                }
            }
        }
    }
    
    func signIn(email: String, passWord: String) {
        authService.signIn(email: email, passWord: passWord) { result in
            switch result {
            case.failure(let networkError):
                self.signInResult?(.failure(networkError))
            case.success(let result):
                self.signInResult?(.success(result))
                // get user info and save it in userdefaults
                self.authService.getCurrentUser { user in
                    guard let user = user else { return }
                    UserDefaultsManager().saveUser(userName: user.userName, userId: user.userId, userEmail: user.userEmail)
                }
                // save connexion state in userdefaults
                UserDefaultsManager().userIsConnected(true)
            }
        }
    }
    
    func logOut() {
        authService.logOut()
        UserDefaultsManager().userIsConnected(false)
    }
}

