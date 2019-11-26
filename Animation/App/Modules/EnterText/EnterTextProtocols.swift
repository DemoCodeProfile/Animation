//
//  EnterTextProtocols.swift
//  Animation
//
//  Copyright © 2019 Вадим. All rights reserved.

import Foundation

//MARK: Wireframe -
protocol EnterTextWireframeProtocol: class {
    func dismiss()
}
//MARK: Presenter -
protocol EnterTextPresenterProtocol: class {
    func dismiss()
}

//MARK: View -
protocol EnterTextViewProtocol: class {
    var presenter: EnterTextPresenterProtocol?  { get set }
    var delegate: EnterTextViewControllerDelegate? { get set }
}

protocol EnterTextViewControllerDelegate: class {
    func setText(text: String?)
}
