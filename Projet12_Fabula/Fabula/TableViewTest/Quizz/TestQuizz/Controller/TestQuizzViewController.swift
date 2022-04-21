//
//  TestQuizzViewController.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 04/01/2022.
//

import UIKit

final class TestQuizzViewController: UIViewController, StoryBoarded {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var backQuestionView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var changeQuizzButton: UIButton!
    
    let shape = CAShapeLayer()
    var questionText: String?
    var progressBarProgress: Float?
    var score: Int?
    
    var viewmodel: TestQuizzViewModel?
    var coordinator: QuizzCoordinator?
    var dataSource = TestQuizzDataSource()
    // register tableview with the proposed answers
    let answersTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TestQuizzTableViewCell.self, forCellReuseIdentifier: TestQuizzTableViewCell.identifier)
        return tableView
    }()
    // bottom bar to show game progress
    let progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .default)
        view.trackTintColor = .lightBlue
        view.progressTintColor = UIColor(named: "Orange")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup view
        tabBarController?.tabBar.isHidden = true
        backQuestionView.layer.cornerRadius = 15
        tryAgainButton.layer.cornerRadius = 15
        tryAgainButton.isEnabled = false
        tryAgainButton.scaleMinAnim()
        changeQuizzButton.layer.cornerRadius = 15
        changeQuizzButton.isEnabled = false
        changeQuizzButton.scaleMinAnim()
        answersTableView.rowHeight = 70
        answersTableView.dataSource = dataSource
        answersTableView.delegate = dataSource
        answersTableView.separatorStyle = .none
        view.addSubview(answersTableView)
        view.addSubview(progressView)
        progressView.setProgress(0, animated: true)
        // set up data
        guard let viewmodel = viewmodel else {
            return
        }
        bind()
        viewmodel.start()
        backQuestionView.scaleMinAnim()
        questionLabel.text = questionText
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        answersTableView.backgroundColor = .deepBlue
        answersTableView.translatesAutoresizingMaskIntoConstraints = false
        answersTableView.isUserInteractionEnabled = true
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            progressView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            progressView.heightAnchor.constraint(equalToConstant: 20),
            answersTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            answersTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            answersTableView.topAnchor.constraint(equalTo: backQuestionView.bottomAnchor, constant: 20),
            answersTableView.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: 20)])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        backQuestionView.scaleMaxAnim(completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    // bind with viewmodel closures
    func bind() {
        // pass answer of the datasource to the viewmodel
        dataSource.playerResponse = viewmodel?.isCorrect(playerResponse:)
        // datasource inform viewcontroller when tableview animation is finished to reload data
        dataSource.animationIsFinished = {
            [weak self] bool in
            if bool {
                self?.answersTableView.reloadData()
            }
        }
        
        viewmodel?.isCorrect = { [weak self] bool in
            self?.dataSource.updateIsCorrect(isCorrect: bool)
            self?.backQuestionView.translateRightAnim(completion: {
                bool in
                if bool {
                    self?.questionLabel.text = self?.questionText
                    self?.backQuestionView.setBackAnim(completion: nil)
                }
            })
        }
        
        self.viewmodel?.question = { [weak self] question in
            self?.questionText = question
        }
        
        self.viewmodel?.propositions = { [weak self] propositions in
            self?.dataSource.updatePropositions(propositions: propositions)
        }
        
        self.viewmodel?.displayedScore = { [weak self] score in
            self?.scoreLabel.text = "Score: \(String(score))/10"
            self?.score = score
        }
        
        self.viewmodel?.isOngoing = { [weak self] bool in
            self?.dataSource.updateIsOngoing(isOngoing: bool)
            guard let progressBarProgress = self?.progressBarProgress else {
                return
            }
            self?.progressView.setProgress(progressBarProgress, animated: true)
            if !bool {
                self?.gameIsOver()
            }
        }
        
        self.viewmodel?.progressBarProgress = {
            [weak self] float in
            self?.progressBarProgress = float
        }
    }
    
    func gameIsOver() {
//         create ActivityRing
        let circlePath = UIBezierPath(arcCenter: view.center, radius: 80, startAngle: 0, endAngle: .pi * 2, clockwise: true)

        shape.path = circlePath.cgPath
        shape.lineWidth = 20
        shape.strokeColor = UIColor(named: "green")?.cgColor
        shape.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shape.strokeEnd = 0
        view.layer.addSublayer(shape)

        guard let score = score else {
            return
        }
        //hide label
        questionLabel.isHidden = true
        questionLabel.text = "Correct: \(score)/10\nIncorrect: \(10-score)"
        
        // tryButton and changeButton appear
        tryAgainButton.scaleMaxAnim(completion: nil)
        tryAgainButton.isEnabled = true
        changeQuizzButton.scaleMaxAnim { _ in
            self.progressView.isHidden = true
            self.progressView.setProgress(0, animated: true)
            let floatScore = Float(score)
            self.animateActivityRing(to: CGFloat(floatScore/10))
            UIView.animate(withDuration: 0.8, animations: {
                self.view.bringSubviewToFront(self.scoreLabel)
                self.scoreLabel.transform = CGAffineTransform.init(translationX: (self.view.center.x - self.scoreLabel.center.x), y: 0)
            }) { _ in
                
                UIView.animate(withDuration: 0.2, animations: { [self] in
                    self.backQuestionView.transform = CGAffineTransform.init(translationX: 0, y: (self.view.center.y - self.backQuestionView.center.y))
                    self.questionLabel.isHidden = false
                }, completion: nil)
            }
        }
        changeQuizzButton.isEnabled = true
    }
    
    func animateActivityRing(to value: CGFloat) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = value
        animation.duration = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        shape.add(animation, forKey: "animation")
    }
    
    @IBAction func changeQuizzTapped(_ sender: Any) {
        coordinator?.pop()
    }
    
    @IBAction func tryAgainTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.4, animations: {
            self.scoreLabel.transform = .identity
            self.scoreLabel.textAlignment = .left
            self.shape.removeAllAnimations()
        }, completion: nil)
        
        progressView.isHidden = false
        changeQuizzButton.isEnabled = true
        tryAgainButton.isEnabled = true
        backQuestionView.scaleMinAnim()
        viewmodel?.start()
        questionLabel.text = questionText
        backQuestionView.scaleMaxAnim(completion: nil)
        changeQuizzButton.scaleMinAnim()
        changeQuizzButton.isEnabled = false
        tryAgainButton.scaleMinAnim()
        tryAgainButton.isEnabled = false
        self.answersTableView.reloadData()
        self.answersTableView.alpha = 1
    }
}
