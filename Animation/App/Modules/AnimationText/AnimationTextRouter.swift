//
//  AnimationTextRouter.swift
//  Animation
//
//  Copyright © 2019 Вадим. All rights reserved.

import UIKit

class AnimationTextRouter: AnimationTextWireframeProtocol {
    
    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        let view = AnimationTextViewController(nibName: nil, bundle: nil)
        let router = AnimationTextRouter()
        let presenter = AnimationTextPresenter(interface: view, router: router)

        view.presenter = presenter
        router.viewController = view

        return view
    }
    
    func showEnterTextScreen(delegate: EnterTextViewControllerDelegate?) {
        let enterTextViewController = EnterTextRouter.createModule()
        (enterTextViewController as? EnterTextViewController)?.delegate = delegate
        viewController?.present(enterTextViewController, animated: true, completion: nil)
    }
}
