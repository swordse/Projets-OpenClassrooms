//
//  TranslationViewController.swift
//  Projet9
//
//  Created by Raphaël Goupille on 09/09/2021.
//

import UIKit

final class TranslationViewController: UIViewController {
    
    // MARK: - Properties
    
    // keep track of the translation way
    private var translationIsReverse = false
    
    private let service = TranslationService()
    
    // default languages choice
    private var languageChoice = LanguageChoice(sourceIso: "fr", sourceName: "Français", targetIso: "en", targetName: "Anglais")
    
    // keep track of the frames for the reverse animation
    private var targetStackFrame = CGRect()
    private var sourceStackFrame = CGRect()
    
    @IBOutlet weak var sourceView: UIView!
    @IBOutlet weak var sourceStack: UIStackView!
    @IBOutlet weak var sourceLanguageButton: UIButton!
    @IBOutlet weak var textToTranslateTextView: UITextView!
    @IBOutlet weak var reverseButton: UIButton!
    @IBOutlet weak var targetView: UIView!
    @IBOutlet weak var targetStack: UIStackView!
    @IBOutlet weak var targetLanguageButton: UIButton!
    @IBOutlet weak var translatedTextTextView: UITextView!
    @IBOutlet weak var dragLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var sourceViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var targetViewTopConstraint: NSLayoutConstraint!
    
    // MARK: - Life Cycle View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tap to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        
        view.addGestureRecognizer(tapGesture)
        
        // swipeDown to translate
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(translate))
        view.addGestureRecognizer(swipeDownGesture)
        swipeDownGesture.direction = .down
        
        // add done button to textView keyboard
        self.textToTranslateTextView.addDoneButton(title: "Done", target: self, selector: #selector(doneTapped))
        
        // set view
        sourceView.setShadow()
        sourceView.layer.cornerRadius = 7
        
        sourceLanguageButton.setBorder()
        sourceLanguageButton.setImageAndTitle()
        
        textToTranslateTextView.setBorder()
        
        targetView.setShadow()
        targetView.layer.cornerRadius = 7
        
        targetLanguageButton.setBorder()
        targetLanguageButton.setImageAndTitle()
        
        translatedTextTextView.setBorder()
        
        targetStackFrame = targetStack.frame
        sourceStackFrame = sourceStack.frame
        
        activityIndicator.isVisible(false)
        textToTranslateTextView.isEditable = true
        translatedTextTextView.isEditable = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        sourceLanguageButton.setTitle(languageChoice.sourceName, for: .normal)
        targetLanguageButton.setTitle(languageChoice.targetName, for: .normal)
    }
    
    
    // MARK: - Methods
    @objc func doneTapped() {
        self.view.endEditing(true)
    }
    
    @IBAction func sourceLanguageButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toLanguageSource", sender: self)
    }
    
    @IBAction func targetLanguageButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toLanguageTarget", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVc = segue.destination as? LanguagesTableViewController
        if segue.identifier == "toLanguageSource" {
            destinationVc?.isSourceLanguage = true
            destinationVc?.sourceDelegate = self
        } else if segue.identifier == "toLanguageTarget" {
            destinationVc?.isSourceLanguage = false
            destinationVc?.targetDelegate = self
        }
    }
    
    @IBAction func reverseButtonTapped(_ sender: Any) {
        
        translationIsReverse.toggle()
        
        targetViewTopConstraint.constant = translationIsReverse ? -(targetView.frame.height + reverseButton.frame.height + 20): 20
        
        sourceViewBottomConstraint.constant = translationIsReverse ? -(reverseButton.frame.height + sourceView.frame.height + 20) : 20
        
        translatedTextTextView.text = ""
        textToTranslateTextView.text = ""
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        
        switch translationIsReverse {
        case true :
            UIView.animate(withDuration: 0.5) {
                self.reverseButton.transform = CGAffineTransform(scaleX: 1, y: -1)
            }
            
            textToTranslateTextView.isEditable = false
            translatedTextTextView.isEditable = true
            textToTranslateTextView.isSelectable = false
            translatedTextTextView.isSelectable = true
            
        case false :
            UIView.animate(withDuration: 0.5) {
                self.reverseButton.transform = CGAffineTransform.identity
            }
            
            textToTranslateTextView.isEditable = true
            translatedTextTextView.isEditable = false
            textToTranslateTextView.isSelectable = true
            translatedTextTextView.isSelectable = false
        }
    }
    
    @objc func translate(_ sender: UISwipeGestureRecognizer) {
        
        activityIndicator.isVisible(true)
        var source = ""
        var target = ""
        var textToTranslate = String()
        var textViewTranslate = UITextView()
        
        // get the language choice based on the translation way
        switch translationIsReverse {
        case true:
            source = languageChoice.targetIso
            target = languageChoice.sourceIso
            textToTranslate = translatedTextTextView.text
            textViewTranslate = textToTranslateTextView
            
        case false:
            source = languageChoice.sourceIso
            target = languageChoice.targetIso
            textToTranslate = textToTranslateTextView.text
            textViewTranslate = translatedTextTextView
        }
        
        service.getTranslation(textToTranslate: textToTranslate, source: source, target: target) { result in
            DispatchQueue.main.async {
                switch result {
                case.failure(let error):
                    print(error)
                case.success(let success):
                    textViewTranslate.text = success.data.translations[0].translatedText
                    self.activityIndicator.isVisible(false)
                }
                self.reverseButton.isEnabled = true
            }
        }
        UIView.animate(withDuration: 0.4) {
            self.view.transform = CGAffineTransform(translationX: 0, y: 30)
        } completion: { _ in
            self.view.transform = CGAffineTransform.identity
        }
    }
}

// MARK: - Extensions

extension TranslationViewController: PassSourceLanguage {
    
    func passLanguageSource(source: String, sourceName: String) {
        
        languageChoice.sourceIso = source
        languageChoice.sourceName = sourceName
        navigationController?.popViewController(animated: true)
    }
}

extension TranslationViewController: PassTargetLanguage {
    
    func passLanguageTarget(target: String, targetName: String) {
        languageChoice.targetIso = target
        languageChoice.targetName = targetName
        navigationController?.popViewController(animated: true)
    }
}




