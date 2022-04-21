//
//  HomeViewController.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 23/12/2021.
//

import UIKit

final class HomeViewController: UIViewController, StoryBoarded {
    
    let userAccount = UserAccountController()
    var coordinator: HomeCoordinator?
    var dataSource = HomeCollectionDataSource()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Fabula"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "user"), style: .plain, target: self, action: #selector(connexionTapped))
        view.addSubview(collectionView)
        view.backgroundColor = .deepBlue
        collectionView.backgroundColor = .deepBlue
        collectionView.frame = CGRect(x: 10, y: 30, width: view.frame.size.width-20, height: view.frame.size.height-30)
        collectionView.register(SectionHeaderCollectionViewCell.nib(), forCellWithReuseIdentifier: SectionHeaderCollectionViewCell.identifier)
        collectionView.register(SectionCollectionViewCell.nib(), forCellWithReuseIdentifier: SectionCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        collectionView.collectionViewLayout = dataSource.createCompositionalLayout()
        getSelectedIndex()
        
        // get the user connexion status
        AuthService().getCurrentUser { user in
            guard let user = user else {
                // user is not connected
                UserDefaultsManager().userIsConnected(false)
                return
            }
            UserDefaultsManager().userIsConnected(true)
            UserDefaultsManager().saveUser(userName: user.userName, userId: user.userId, userEmail: user.userEmail)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // if user is new, display ongoing screens
        if Core.shared.isNewUser() {
            // show welcome view
            let vc = storyboard?.instantiateViewController(withIdentifier: "welcome") as! WelcomeViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    // get the indexPath from datasource and navigate
    func getSelectedIndex() {
        dataSource.selectedSection = {
            [weak self] indexPath in
            
            switch indexPath.section {
            case 0: return
            case 1:
                switch indexPath.row {
                case 0:
                    self?.coordinator?.showAnecdotes()
                case 1:
                    self?.coordinator?.showQuote()
                case 2:
                    self?.coordinator?.showWord()
                case 3:
                    self?.coordinator?.showQuizz()
                default:
                    self?.coordinator?.showAnecdotes()
                }
            
            case 2:
                switch indexPath.row {
                case 0:
                    self?.coordinator?.showMap()
                default:
                    return
                }
            default:
                return
            }
        }
    }
    
    @objc
    func connexionTapped() {
        guard let navigationController = navigationController else {
            return
        }
        userAccount.showUserConnexion(on: navigationController)
    }
}

// used to check if user is a new user, if so, display the ongoing views
class Core {
    
    static let shared = Core()
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsnotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
