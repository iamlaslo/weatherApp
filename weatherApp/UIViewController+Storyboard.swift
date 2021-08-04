//
//  UIViewController+Storyboard.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 4.8.2021.
//

import Foundation
import UIKit

extension UIViewController {
    func getViewControllerByID(_ id: String) -> UIViewController {
        // creating global storyboard link
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: id)
    }
}

