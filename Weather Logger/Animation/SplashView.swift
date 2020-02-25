//
//  SplashView.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 25.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import UIKit

class SplashView: UIView {
    open var iconImage: UIImage? {
        didSet {
            if let iconImage = self.iconImage {
                imageView?.image = iconImage
            }
        }
    }
    
    open var iconColor: UIColor = .white {
        didSet {
            imageView?.tintColor = iconColor
        }
    }
    
    open var useCustomIconColor: Bool = false {
        didSet {
            if useCustomIconColor {
                if let iconImage = self.iconImage {
                    imageView?.image = iconImage.withRenderingMode(.alwaysTemplate)
                }
            } else {
                if let iconImage = self.iconImage {
                    imageView?.image = iconImage.withRenderingMode(.alwaysOriginal)
                }
            }
        }
    }
    
    open var iconInitialSize: CGSize = CGSize(width: 60, height: 60) {
        didSet {
            imageView?.frame = CGRect(x: 0, y: 0, width: iconInitialSize.width, height: iconInitialSize.height)
        }
    }
    
    open var backgroundImageView: UIImageView?
    open var imageView: UIImageView?
    open var animationType: AnimationType = .twitter
    open var duration: Double = 1.5
    open var delay: Double = 0.5
    open var heartAttack: Bool = false
    open var minimumBeats: Int = 1
    public init(iconImage: UIImage, iconInitialSize: CGSize, backgroundColor: UIColor) {
        
        self.imageView = UIImageView()
        self.iconImage = iconImage
        self.iconInitialSize = iconInitialSize
        
        super.init(frame: (UIScreen.main.bounds))
        
        imageView?.image = iconImage
        imageView?.tintColor = iconColor
        imageView?.frame = CGRect(x: 0, y: 0, width: iconInitialSize.width, height: iconInitialSize.height)
        imageView?.contentMode = .scaleAspectFit
        imageView?.center = self.center
        
        self.addSubview(imageView!)
        self.backgroundColor = backgroundColor
    }
    
    public init(iconImage: UIImage, iconInitialSize: CGSize, backgroundImage: UIImage) {
        
        self.imageView = UIImageView()
        self.iconImage = iconImage
        self.iconInitialSize = iconInitialSize
        
        super.init(frame: (UIScreen.main.bounds))
        
        imageView?.image = iconImage
        imageView?.tintColor = iconColor
        imageView?.frame = CGRect(x: 0, y: 0, width: iconInitialSize.width, height: iconInitialSize.height)
        imageView?.contentMode = .scaleAspectFit
        imageView?.center = self.center
        
        self.backgroundImageView = UIImageView()
        backgroundImageView?.image = backgroundImage
        backgroundImageView?.frame = UIScreen.main.bounds
        backgroundImageView?.contentMode = .scaleAspectFill
        
        self.addSubview(backgroundImageView!)
        self.addSubview(imageView!)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) haven't implemented")
    }
}
