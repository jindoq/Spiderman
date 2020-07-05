//
//  PaveCtr.swift
//  PAVE
//
//  Created by Duy Tu Tran on 3/18/20.
//  Copyright © 2020 Discovery Loft. All rights reserved.
//

import Foundation
import UIKit

open class SpidermanCtr: UIViewController {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }

    open func setupSetting() {
        let shopBtn = UIBarButtonItem(image: UIImage(named: "ic_shop", in: Bundle(for: SpidermanCtr.self), compatibleWith: nil), style: .done, target: self, action: #selector(shoppingAction))
        navigationItem.rightBarButtonItem = shopBtn
    }

    @objc open func shoppingAction() {
        let vc = IAPCtr()
        push(vc)
    }
}

extension SpidermanCtr {
    open func present(_ vc: UIViewController) {
        vc.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    open func push(_ vc: UIViewController) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
