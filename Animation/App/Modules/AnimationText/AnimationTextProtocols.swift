//
//  AnimationTextProtocols.swift
//  Animation
//
//  Copyright © 2019 Вадим. All rights reserved.

import Foundation

//MARK: Wireframe
protocol AnimationTextWireframeProtocol: class {
    func showEnterTextScreen(delegate: EnterTextViewControllerDelegate?)
}

//MARK: Presenter -
protocol AnimationTextPresenterProtocol: class {
    func showEnterTextScreen(delegate: EnterTextViewControllerDelegate?)
}

//MARK: View -
protocol AnimationTextViewProtocol: class {
    var presenter: AnimationTextPresenterProtocol?  { get set }
}
