//
//  AboutView.swift
//  Dupe
//
//  Created by Joshua James on 27.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit
import FFPopup

class NotificationView: UIView {
    
    static let NibName = "NotificationView"
        
    @IBOutlet private weak var blCorner: UIView?
    @IBOutlet private weak var brCorner: UIView?
    @IBOutlet private weak var textView: UITextView?
    
    // MARK: - UIView -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureSubviews()
    }
    
    // MARK: - Methods -
    
    func popin(withText text: String) {
        let popup = FFPopup(contetnView: self,
                            showType: .bounceInFromTop,
                            dismissType: .slideOutToTop,
                            maskType: .clear,
                            dismissOnBackgroundTouch: true,
                            dismissOnContentTouch: true)
        let layout = FFPopupLayout(horizontal: .center,
                                   vertical: .top)
        
        popup.show(layout: layout)
        
        textView?.text = text
        
        textView?.backgroundColor = GameViewController.baseRubikColor
    }
    
    // MARK: - Configuration -
    
    private func configureSubviews() {
        configureTextViews()
        configureCorners()
    }
    
    private func configureTextViews() {
        textView?.theme()
        textView?.backgroundColor = GameViewController.baseRubikColor
    }
    
    private func configureCorners() {
        blCorner?.backgroundColor = UIColor.background
        brCorner?.backgroundColor = UIColor.background
    }
    
}
