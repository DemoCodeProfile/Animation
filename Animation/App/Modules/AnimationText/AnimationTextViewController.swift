//
//  AnimationTextViewController.swift
//  Animation
//
//  Copyright © 2019 Вадим. All rights reserved.

import UIKit

class AnimationTextViewController: UIViewController, AnimationTextViewProtocol {

    private struct Constants {
        static let testTextExample = "Test example"
    }
    
	var presenter: AnimationTextPresenterProtocol?
    let animationButton = UIButton()
    let animationLabel = AnimationLabel(text: Constants.testTextExample, font: .systemFont(ofSize: 32))
    
	override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(animationLabel)
        view.addSubview(animationButton)
        animationLabel.frame = CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
        animationButton.frame = CGRect(
            x: (UIScreen.main.bounds.width - 100) / 2,
            y: 40,
            width: 100,
            height: 100
        )
        animationButton.setImage(UIImage(named: "visibility"), for: .normal)
        let tapAnimationLabelRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(tapShowEnterTextScreen(_:))
        )
        tapAnimationLabelRecognizer.numberOfTapsRequired = 2
        animationLabel.addGestureRecognizer(tapAnimationLabelRecognizer)
        let tapAnimationButtonRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(tapAnimation(_:))
        )
        animationButton.addGestureRecognizer(tapAnimationButtonRecognizer)
    }
    
    @objc func tapAnimation(_ sender: Any?) {
        animationLabel.animateLabel()
    }
    
    @objc func tapShowEnterTextScreen(_ sender: Any?) {
        presenter?.showEnterTextScreen(delegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animationLabel.animateLabel()
    }
}

extension AnimationTextViewController: EnterTextViewControllerDelegate {
    func setText(text: String?) {
        if let text = text, !text.isEmpty {
            animationLabel.text = text
        }
        animationLabel.animateLabel()
    }
}
