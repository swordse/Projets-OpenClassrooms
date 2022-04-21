//
//  CustomAlert.swift
//  Projet9
//
//  Created by Raphaël Goupille on 22/09/2021.
//

import Foundation
import UIKit

class CustomAlert {
    
    struct Constants {
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    private let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 12
        return alert
    }()
    
    private var myTargetView: UIView?
    
    func showAlert(with title: String, message: String, on vc: UIViewController) {
        
        guard let targetView = vc.view else { return }
        
        myTargetView = targetView
        
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        
        alertView.frame = CGRect(x: 40, y: -300, width: targetView.frame.size.width-80, height: 200)
        
        targetView.addSubview(alertView)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: alertView.frame.width, height: 50))
        titleLabel.text = title
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 25)
        
        titleLabel.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        titleLabel.textAlignment = .center
        alertView.addSubview(titleLabel)
        
        let messageLabel = UILabel(frame: CGRect(x: 10, y: 50, width: alertView.frame.width-20, height: 100))
        messageLabel.numberOfLines = 0
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.backgroundColor = .white
        alertView.addSubview(messageLabel)
        
        let button = UIButton(frame: CGRect(x: 10, y: 150, width: alertView.frame.size.width-20, height: 40))
        alertView.addSubview(button)
        button.layer.cornerRadius = 20
        button.backgroundColor = .link
        button.setTitle("OK", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
        alertView.addSubview(messageLabel)
        
        
        UIView.animate(withDuration: 0.2, animations: {
            self.backgroundView.alpha = Constants.backgroundAlphaTo
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.2, animations: {
                    self.alertView.center = targetView.center
                })
            }
        })
    }
    
    @objc func dismissAlert() {
        guard let targetView = myTargetView else {return}
        UIView.animate(withDuration: 0.2, animations: {
            self.alertView.frame = CGRect(x: 40, y: targetView.frame.size.height, width: targetView.frame.size.width-80, height: 200)
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.2) {
                    self.backgroundView.alpha = 0
                } completion: { done in
                    if done {
                        self.alertView.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                    }
                }
            }
        })
    }
    
}
