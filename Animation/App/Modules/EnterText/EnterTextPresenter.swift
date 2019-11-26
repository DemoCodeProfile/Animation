//
//  EnterTextPresenter.swift
//  Animation
//
//  Copyright © 2019 Вадим. All rights reserved.


import UIKit

class EnterTextPresenter: EnterTextPresenterProtocol {

    weak private var view: EnterTextViewProtocol?
    private let router: EnterTextWireframeProtocol

    init(interface: EnterTextViewProtocol, router: EnterTextWireframeProtocol) {
        self.view = interface
        self.router = router
    }

    func dismiss() {
        router.dismiss()
    }
}
