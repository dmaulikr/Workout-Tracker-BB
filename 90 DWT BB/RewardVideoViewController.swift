//
//  RewardVideoViewController.swift
//  90 DWT BB
//
//  Created by Grant, Jared on 1/11/17.
//  Copyright © 2017 Jared Grant. All rights reserved.
//

import UIKit

class RewardVideoViewController: UIViewController {

    var shouldShowAd = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if shouldShowAd {
            
            MPRewardedVideo.presentAd(forAdUnitID: "1b90344b9bc749c4adc443909cbc09e4", from: self, with: nil)
            shouldShowAd = false
        }
        else {
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
