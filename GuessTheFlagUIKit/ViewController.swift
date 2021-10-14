//
//  ViewController.swift
//  GuessTheFlagUIKit
//
//  Created by Andrei Korikov on 12.10.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0
    
    static let questionsPerRound = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries.append(contentsOf: ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria",
                                      "poland", "russia", "spain", "uk", "us"])
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gamecontroller"),
            style: .plain,
            target: self,
            action: #selector(showScore)
        )
        
        askQuestion()
    }
    
    @objc func showScore() {
        let alertVC = UIAlertController(title: "Score", message: "Your score is \(score)", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true)
    }
    
    func askQuestion() {
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = "Pick: \(countries[correctAnswer].uppercased()) Score: \(score)"
    }
    
    func resetGame() {
        score = 0
        questionsAsked = 0
        
        askQuestion()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            let ac = UIAlertController(
                title: "Negative",
                message: "Wrong! That's the flag of \(countries[sender.tag].uppercased())",
                preferredStyle: .alert
            )
            ac.addAction(UIAlertAction(title: "My fault", style: .default))
            present(ac, animated: true)
            score -= 1
        }
        
        questionsAsked += 1
        title?.append(". Question \(questionsAsked) of \(Self.questionsPerRound)")
        
        if questionsAsked == Self.questionsPerRound {
            let ac = UIAlertController(title: "Game Over", message: "Your score is \(score).", preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(
                title: "Continue",
                style: .default,
                handler: { _ in
                    self.resetGame()
                }
            ))
            present(ac, animated: true)
        } else {
            askQuestion()
        }
        
    }
}

