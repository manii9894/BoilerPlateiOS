//
//  UITableView+Extension.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 12/05/2022.
//

import Foundation
import UIKit

extension UITableView {

    func register<T: UITableViewCell>(_: T.Type)  {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }

    func registerNib<T: UITableViewCell>(_: T.Type)  {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.identifier, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.identifier)
    }

    func registerHeaderNib<T: UITableViewHeaderFooterView>(_: T.Type)  {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.identifier, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: T.identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T  {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(for section: Int) -> T  {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }

}

extension UITableViewCell: ReusableCellProtocol{}
extension UITableViewHeaderFooterView: ReusableCellProtocol{}
extension UITableViewCell: NibLoadableView {}

extension UITableViewCell {
    var cellActionButtonLabel: UILabel? {
        superview?.subviews
            .filter { String(describing: $0).range(of: "UISwipeActionPullView") != nil }
            .flatMap { $0.subviews }
            .filter { String(describing: $0).range(of: "UISwipeActionStandardButton") != nil }
            .flatMap { $0.subviews }
            .compactMap { $0 as? UILabel }.first
    }
}
