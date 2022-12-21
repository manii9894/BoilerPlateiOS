//
//  Loader.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 12/04/2022.
//

import UIKit
import NVActivityIndicatorView

class Loader {
    
    private static let shared = Loader()
    
    static func show() {
        
        if let window = Router.shared.keyWindow {
            guard !window.subviews.contains(where: { $0 is BlockingActivityIndicator }) else {
                return
            }
            
            let activityIndicator = BlockingActivityIndicator()
            activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            activityIndicator.frame = window.bounds
            
            UIView.transition(
                with: window,
                duration: 0.3,
                options: .transitionCrossDissolve,
                animations: {
                    window.addSubview(activityIndicator)
                }
            )
        }
        
    }
    
    static func dismiss() {
        
        if let window = Router.shared.keyWindow {
            window.subviews.filter { $0 is BlockingActivityIndicator }.forEach { view in
                view.removeFromSuperview()
            }
        }
    }
    
}

final class BlockingActivityIndicator: UIView {
    
    private let activityIndicator: NVActivityIndicatorView
    
    override init(frame: CGRect) {
        self.activityIndicator = NVActivityIndicatorView(
            frame: CGRect(
                origin: .zero,
                size: NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE
            )
        )
        activityIndicator.type = .ballRotateChase
        activityIndicator.color = .blue
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
