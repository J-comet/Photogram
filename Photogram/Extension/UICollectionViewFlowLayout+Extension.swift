//
//  UICollectionViewFlowLayout+Extension.swift
//  Photogram
//
//  Created by 장혜성 on 2023/08/30.
//

import UIKit

extension UICollectionViewFlowLayout {
    
    func collectionViewLayout(
        itemSize: CGSize,
        sectionInset: UIEdgeInsets,
        minimumLineSpacing: CGFloat,
        minimumInteritemSpacing: CGFloat
    ) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = itemSize
        layout.sectionInset = sectionInset
        layout.minimumLineSpacing = minimumLineSpacing
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        return layout
    }

}
