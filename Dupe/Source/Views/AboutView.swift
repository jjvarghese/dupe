//
//  AboutView.swift
//  Dupe
//
//  Created by Joshua James on 27.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

protocol AboutViewDelegate {
    
    func aboutViewIsGoingBack(_ aboutView: AboutView)
    
}

class AboutView: UIView {
    
    static let NibName = "AboutView"
    
    var delegate: AboutViewDelegate?
    
    @IBOutlet private weak var textView: UITextView?
    @IBOutlet private weak var backButton: UIButton?
    
    // MARK: - UIView -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureSubviews()
    }
    
    // MARK: - Configuration -
    
    private func configureSubviews() {
        configureTextViews()
        configureButtons()
    }
    
    private func configureTextViews() {
        textView?.theme()
    }
    
    private func configureButtons() {
        backButton?.theme()
    }
    
    // MARK: - Actions -
    
    @IBAction private func backTouched(_ sender: Any) {
        delegate?.aboutViewIsGoingBack(self)
    }
    
}
