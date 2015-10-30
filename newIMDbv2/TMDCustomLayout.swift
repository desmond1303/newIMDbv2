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
        
        let collectionView: UICollectionView = self.collectionView!
        let insets: UIEdgeInsets = collectionView.contentInset
        let offset: CGPoint = collectionView.contentOffset
        let minY: CGFloat = -insets.top;
        
        let attributes =  super.layoutAttributesForElementsInRect(rect)
        
        if (offset.y < minY) {
            
            // Figure out how much we've pulled down
            let deltaY: CGFloat = CGFloat.abs(offset.y - minY)
            
            for attrs in attributes! {
                
                // Locate the header attributes
                let kind: String = attrs.representedElementKind!
                if (kind == UICollectionElementKindSectionHeader) {
                    
                    // Adjust the header's height and y based on how much the user
                    // has pulled down.
                    let headerSize: CGSize = self.headerReferenceSize
                    var headerRect: CGRect = attrs.frame
                    headerRect.size.height = minY > headerSize.height + deltaY ? minY : headerSize.height
                    headerRect.origin.y = headerRect.origin.y - deltaY;
                    attrs.frame = headerRect
                    break
                }
            }
        }
        return attributes
    }
 
}
