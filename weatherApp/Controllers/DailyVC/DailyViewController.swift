//
//  DailyViewController.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 4.8.2021.
//

import Foundation
import UIKit

class DailyViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var wholeTempLabel: UILabel!
    @IBOutlet weak var wholeConditionsLabel: UILabel!
    @IBOutlet weak var wholeImageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    
    @IBOutlet weak var morningImageView: UIImageView!
    @IBOutlet weak var morningTempLabel: UILabel!
    @IBOutlet weak var morningFeelsLabel: UILabel!
    
    @IBOutlet weak var afternoonImageView: UIImageView!
    @IBOutlet weak var afternoonTempLabel: UILabel!
    @IBOutlet weak var afternoonFeelsLabel: UILabel!
    
    @IBOutlet weak var eveningImageView: UIImageView!
    @IBOutlet weak var eveningTempLabel: UILabel!
    @IBOutlet weak var eveningFeelsLabel: UILabel!
    
    @IBOutlet weak var nightImageView: UIImageView!
    @IBOutlet weak var nightTempLabel: UILabel!
    @IBOutlet weak var nightFeelsLabel: UILabel!
    
    
    var model: DailyModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI(model: model, self: self)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
    }
}
