//
//  EnterTextRouter.swift
//  Animation
//
//  Copyright © 2019 Вадим. All rights reserved.


import UIKit

class EnterTextRouter: EnterTextWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        let view = EnterTextViewController(nibName: nil, bundle: nil)
        let router = EnterTextRouter()
        let presenter = EnterTextPresenter(interface: view, router: router)

        view.presenter = presenter
        router.viewController = view

        return view
    }
    
    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
