//
//  AboutView.swift
//  Dupe
//
//  Created by Joshua James on 27.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

class AboutView: UIView {
    
    static let NibName = "AboutView"
        
    @IBOutlet private weak var textView: UITextView?
    
    // MARK: - UIView -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureSubviews()
    }
    
    // MARK: - Configuration -
    
    private func configureSubviews() {
        configureTextViews()
    }
    
    private func configureTextViews() {
        textView?.theme()
        textView?.backgroundColor = GameViewController.baseRubikColor

        textView?.text = """
            Dupe is a solo production, made with ❤️\n\n Sound effects and music obtained from\nhttps://www.zapsplat.com
        """
    }
    
}
