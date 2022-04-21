import Foundation
import UIKit

/// Protocol to transmit comment tapped from CommentForm (deleguee) to DetailAnecdoteTableViewController (delegate). Controller retrieve the anecdoteId and call saveComment in viewmodel
protocol SubmittedCommentDelegate {
    func commentSubmitted(comment: String)
}

/// View show when identified user tap the add comment button in DetailAnecdote. This view is shown over the DetailAnecdoteViewController
final class CommentForm: NSObject {
    
    var submittedCommentDelegate: SubmittedCommentDelegate?
    
    struct Constants {
        static let backgroundAlphaTo: CGFloat = 1
    }
    
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .deepBlue
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
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    private var commentTextView: UITextView = {
        let commentTextView = UITextView()
        return commentTextView
    }()
    
    private var submitButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private var myTargetView: UIView?
    
    func showCommentForm(on navigationController: UINavigationController) {
        
        guard let targetView = navigationController.view else {
            return
        }
        
        myTargetView = targetView
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        alertView.frame = CGRect(x: 10, y: targetView.frame.size.height, width: targetView.frame.size.width - 20, height: backgroundView.frame.size.height - 200)
        alertView.backgroundColor = UIColor(named: "darkBlue")
        targetView.addSubview(alertView)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: alertView.frame.width, height: 40))
        titleLabel.text = "Ajouter un commentaire"
        titleLabel.textColor = .white
        titleLabel.backgroundColor = UIColor(named: "darkBlue")
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        alertView.addSubview(titleLabel)
        
        let dismissButton = UIButton()
        let image = UIImage(systemName: "x.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        dismissButton.setImage(image, for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissCommentForm), for: .touchUpInside)
        dismissButton.frame = CGRect(x: alertView.frame.size.width-30, y: 15, width: 20, height: 20)
        alertView.addSubview(dismissButton)
        
        NSLayoutConstraint.activate([
            dismissButton.widthAnchor.constraint(equalToConstant: 20),
            dismissButton.heightAnchor.constraint(equalToConstant: 20)])
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.contentMode = .scaleAspectFit
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        alertView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        commentTextView.textColor = .black
        commentTextView.backgroundColor = .white
        commentTextView.layer.cornerRadius = 10
        commentTextView.layer.borderWidth = 1
        commentTextView.layer.borderColor = UIColor.black.cgColor
        commentTextView.font = UIFont.systemFont(ofSize: 15)
        commentTextView.addDoneButton(title: "Terminé", target: self, selector: #selector(tapDone(sender:)))
        
        submitButton.layer.cornerRadius = 10
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        submitButton.setTitle("SOUMETTRE", for: .normal)
        submitButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = UIColor(named: "lightDark")
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        
        stackView.addArrangedSubview(commentTextView)
        stackView.addArrangedSubview(submitButton)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: +10),
            stackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -10),
            stackView.centerYAnchor.constraint(equalTo: alertView.centerYAnchor),
            commentTextView.heightAnchor.constraint(equalToConstant: 100),
            submitButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
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
    // when submit button is tapped then comment text is transmitted to the delegate and the view is dismissed
    @objc func submitTapped() {
        guard let commentText = commentTextView.text, commentText != "" else { return }
        submittedCommentDelegate?.commentSubmitted(comment: commentText)
        dismissView()
    }
    
    @objc func dismissCommentForm() {
        dismissView()
    }
    
    func dismissView() {
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
    
    @objc func tapDone(sender: Any) {
        commentTextView.endEditing(true)
    }
}
