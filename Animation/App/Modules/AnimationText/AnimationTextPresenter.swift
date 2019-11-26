//
//  AnimationTextPresenter.swift
//  Animation
//
//  Copyright © 2019 Вадим. All rights reserved.

import UIKit

class AnimationTextPresenter: AnimationTextPresenterProtocol {

    weak private var view: AnimationTextViewProtocol?
    private let router: AnimationTextWireframeProtocol

    init(interface: AnimationTextViewProtocol, router: AnimationTextWireframeProtocol) {
        self.view = interface
        self.router = router
    }
    
    func showEnterTextScreen(delegate: EnterTextViewControllerDelegate?) {
        router.showEnterTextScreen(delegate: delegate)
    }
}
