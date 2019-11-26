//
//  EnterTextViewController.swift
//  Animation
//
//  Copyright © 2019 Вадим. All rights reserved.

import UIKit



class EnterTextViewController: UIViewController, EnterTextViewProtocol {

	var presenter: EnterTextPresenterProtocol?
    weak var delegate: EnterTextViewControllerDelegate?
    @IBOutlet weak var enterTextLabel: UITextField!
    
	override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func doneText(_ sender: UIButton) {
        delegate?.setText(text: enterTextLabel.text)
        presenter?.dismiss()
    }
}
