//
//  GameViewController.swift
//  Dupe
//
//  Created by Joshua James on 19.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var smallGrid: UICollectionView?
    @IBOutlet weak var bigGrid: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        configureNavigationBar()
    }
    
    // MARK: - Configuration -
    
    private func configureSubviews() {
        configureCollectionViews()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureCollectionViews() {
        smallGrid?.delegate = self
        bigGrid?.delegate = self
    }

}
