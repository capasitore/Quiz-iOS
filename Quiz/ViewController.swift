//
//  ViewController.swift
//  Quiz
//
//  Created by Andreas Aronsson on 05/06/16.
//  Copyright © 2016 Andreas Aronsson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet var answerLabel: UILabel!
    
    
    let questions: [String] = ["From what is cognac made?",
                               "What is 7+7?",
                               "What is the capital of Vermont?"]
    
    let answers : [String] = ["Grapes",
                              "14",
                              "Montpelier"]
    
    var currentQuestionIndex = 0
    
    @IBAction func showNextQuestion(sender: AnyObject) {
        //++ will be removed in Swift 3
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransition()
    }
    
    
    
    @IBAction func showAnswer(sender: AnyObject){
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
        
        updateOffScreenLabel()
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //label initial alpha
        nextQuestionLabel.alpha = 0
    }
    
    func animateLabelTransition() {
        
        //force any outstanding layout changes to occur
        //otherwise the label width will animate as well
        view.layoutIfNeeded()
        
        //animate alpha
        //and center x constraint
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
        UIView.animateWithDuration(0.5, delay: 0,
                                   options: [.CurveLinear],
                                   animations: {
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
            self.view.layoutIfNeeded()
            }, completion: { _ in
                swap(&self.currentQuestionLabel,
                    &self.nextQuestionLabel)
                swap(&self.currentQuestionLabelCenterXConstraint,
                    &self.nextQuestionLabelCenterXConstraint)
                
                self.updateOffScreenLabel()
        })
    }


}

