//
//  aga.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 6.8.2021.
//

import UIKit

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        daily = model.daily[indexPath.item]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let dailyViewController = storyboard.instantiateViewController(identifier: "DailyVC") as? DailyViewController else { return }
        dailyViewController.model = daily
                
        show(dailyViewController, sender: nil)
    }
}
