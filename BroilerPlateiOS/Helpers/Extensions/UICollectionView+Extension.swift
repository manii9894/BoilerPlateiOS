//
//  UICollectionView+Extension.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 12/05/2022.
//

import Foundation
import UIKit

extension UICollectionView {

    func register<T: UICollectionViewCell>(_: T.Type)  {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }

    func registerNib<T: UICollectionViewCell>(_: T.Type)  {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.identifier, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: T.identifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T  {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }
    
    func registerHeaderNib<T: UICollectionReusableView>(_: T.Type)  {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.identifier, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableHeaderView<T: UICollectionReusableView>(for indexPath: IndexPath) -> T  {
        guard let cell = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }

}

extension UICollectionReusableView: ReusableCellProtocol{}
extension UICollectionViewCell: NibLoadableView {}
