//
//  RoundedCorners.swift
//  WhereIsMyFood?
//
//  Created by Shreya Randive on 7/24/19.
//  Copyright © 2019 Shreya Randive. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedCorners: UIImageView {
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
}
