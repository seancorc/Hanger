
//
//  FilterCVDelegate&DS.swift
//  Hanger
//
//  Created by Sean Corcoran on 8/23/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import UIKit


class FilterCVDelegateAndDS: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var stringArray = [String]()
    var widthMultiplier: CGFloat!
    
    init(stringArray: [String], widthMultiplier: CGFloat = 0.2) {
        super.init()
        self.stringArray = stringArray
        self.widthMultiplier = widthMultiplier
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stringArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Global.CellID, for: indexPath) as! FilterCollectionViewCell
        let text = stringArray[indexPath.row]
        cell.configureCell(labelText: text)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = stringArray[indexPath.row]
        let padding = 12 * Global.ScaleFactor
        let NSText = NSString(string: text)
        let size = NSText.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: FilterTableViewCell.titleFontSize)])
        return CGSize(width: (size.width + padding) > UIScreen.main.bounds.width * widthMultiplier ? (size.width + padding) : UIScreen.main.bounds.width * widthMultiplier, height: size.height * 2) //If the text with padding is bigger then the selected width multiplier
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView.allowsMultipleSelection {
//            self.numberOfSelectedFilters += 1
//            filterView.applyButton.setTitle("Apply (\(numberOfSelectedFilters))", for: .normal)
//            filterView.applyButton.layoutIfNeeded()
//        }
//        currentSelectionState[collectionView.tag]?.append(indexPath)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if collectionView.allowsMultipleSelection {
//            self.numberOfSelectedFilters -= 1
//            filterView.applyButton.setTitle("Apply (\(numberOfSelectedFilters))", for: .normal)
//            filterView.applyButton.layoutIfNeeded()
//        }
//        currentSelectionState[collectionView.tag]?.removeAll {$0 == indexPath}
//    }
    
}
