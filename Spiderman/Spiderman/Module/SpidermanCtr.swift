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
    public let cheerView = CheerView()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        cheerView.config.particle = .confetti(allowedShapes: Particle.ConfettiShape.all)
        view.addSubviews(cheerView)
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cheerView.frame = view.bounds
    }
    
    open func setupMusic() {
        if !offSound {
            MusicManager.playSound()
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: offSound ? UIImage(named: "ic_music_off", in: Bundle(for: SpidermanCtr.self), compatibleWith: nil) : UIImage(named: "ic_music_on", in: Bundle(for: SpidermanCtr.self), compatibleWith: nil), style: .done, target: self, action: #selector(musicAction))
    }
    
    @objc func musicAction() {
        let tmp = offSound
        offSound = !tmp
        if offSound {
            MusicManager.stopSound()
        } else {
            MusicManager.playSound()
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: offSound ? UIImage(named: "ic_music_off", in: Bundle(for: SpidermanCtr.self), compatibleWith: nil) : UIImage(named: "ic_music_on", in: Bundle(for: SpidermanCtr.self), compatibleWith: nil), style: .done, target: self, action: #selector(musicAction))
    }

    open func setupShopping() {
        let shopBtn = UIBarButtonItem(image: UIImage(named: "ic_shop", in: Bundle(for: SpidermanCtr.self), compatibleWith: nil), style: .done, target: self, action: #selector(shoppingAction))
        navigationItem.rightBarButtonItem = shopBtn
    }

    @objc open func shoppingAction() {
        let vc = IAPCtr()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

