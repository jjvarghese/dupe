//
//  MenuCell.swift
//  Dupe
//
//  Created by Joshua James on 27.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

protocol MenuCellDelegate {

    func menuCellSelectedOption(_ cell: MenuCell, option: MenuOption)
    
}

class MenuCell: UITableViewCell {
    
    @IBOutlet private weak var button: UIButton?
    
    var delegate: MenuCellDelegate?
    var option: MenuOption?
    
    // MARK: - Updating -
    
    func update(asMenuOption option: MenuOption) {
        self.option = option
        
        backgroundColor = .clear
        isUserInteractionEnabled = true
        selectionStyle = .none
        
        configureSubviews()
        
        button?.setTitle(option.title(),
                         for: .normal)
    }
    
    // MARK: - Actions -
    
    @IBAction private func buttonTouched(_ sender: Any) {
        guard let option = option else { return }
        
        weak var weakSelf = self
        
        DispatchQueue.main.async {
            weakSelf?.delegate?.menuCellSelectedOption(self, option: option)
        }
    }
    
    // MARK: - Configuration -
    
    private func configureSubviews() {
        configureButton()
    }
    
    private func configureButton() {
        button?.theme()
    }
    
}
