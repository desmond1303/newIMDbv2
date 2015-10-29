//
//  TMDCustomLayout.swift
//  newIMDbv2
//
//  Created by Dino Praso on 27.10.15.
//  Copyright © 2015 Atlantbh. All rights reserved.
//

import UIKit

class TMDCustomLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        super.prepareLayout()
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var elementsInRect = [UICollectionViewLayoutAttributes]()

        for i in 0..<self.collectionView!.numberOfSections() {
            for j in 0..<self.collectionView!.numberOfItemsInSection(i) {
                let indexPath: NSIndexPath = NSIndexPath(forRow: j, inSection: i)
                    
                let attr: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                elementsInRect.append(attr)
                
            }
        }
        
        return elementsInRect
    }
 
}
