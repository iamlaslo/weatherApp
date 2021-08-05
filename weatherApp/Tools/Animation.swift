//
//  Animation.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 6.8.2021.
//

import UIKit

extension UIView{
    func animShow(){
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn],
                       animations: {
//                        self.center.y -= self.bounds.height
//                        self.layoutIfNeeded()
                        self.alpha = 1
        }, completion: nil)
    }
    func animHide(){
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear],
                       animations: {
//                        self.center.y += self.bounds.height
//                        self.layoutIfNeeded()
                        self.alpha = 0

        },  completion: {(_ completed: Bool) -> Void in
//        self.isHidden = true
            })
    }
}
