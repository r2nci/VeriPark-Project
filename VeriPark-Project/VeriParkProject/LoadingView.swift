//
//  LoadingView.swift
//  VeriParkProject
//
//  Created by Ramazan ikinci on 10.12.2021.
//

import Foundation
import UIKit
class Loading {
class func showUniversalLoadingView(_ show: Bool, loadingText : String = "") {
    let existingView = UIApplication.shared.windows[0].viewWithTag(1200)
    if show {
        if existingView != nil {
            return
        }
        let loadingView = self.makeLoadingView(withFrame: UIScreen.main.bounds, loadingText: loadingText)
        loadingView?.tag = 1200
        UIApplication.shared.windows[0].addSubview(loadingView!)
    } else {
        existingView?.removeFromSuperview()
    }

}



 class func makeLoadingView(withFrame frame: CGRect, loadingText text: String?) -> UIView? {
    let loadingView = UIView(frame: frame)
    loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    //activityIndicator.backgroundColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1)
     activityIndicator.style = .large
    activityIndicator.layer.cornerRadius = 6
    activityIndicator.center = loadingView.center
    activityIndicator.hidesWhenStopped = true
     activityIndicator.color = .red
    activityIndicator.startAnimating()
    activityIndicator.tag = 100 // 100 for example

    loadingView.addSubview(activityIndicator)
    if !text!.isEmpty {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        let cpoint = CGPoint(x: activityIndicator.frame.origin.x + activityIndicator.frame.size.width / 2, y: activityIndicator.frame.origin.y + 80)
        lbl.center = cpoint
        lbl.textColor = UIColor.white
        lbl.textAlignment = .center
        lbl.text = text
        lbl.tag = 1234
        loadingView.addSubview(lbl)
    }
    return loadingView
}
}

extension  UIViewController {
    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Tamam", style: .default, handler: { action in
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}
