//
//  SplashViewController.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 24.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func loadAnimation() {
        guard let image = UIImage(named: "weather-logger") else {
            load()
            return
        }
        let splashView = SplashView(
            iconImage: image,
            iconInitialSize: CGSize(width: 100, height: 100),
            backgroundColor: .white
        )
        
        self.view.addSubview(splashView)
        
        splashView.duration = 3.0
        splashView.animationType = AnimationType.heartBeat
        splashView.iconColor = UIColor.red
        splashView.useCustomIconColor = false
        
        splashView.startAnimation {
            self.load()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            splashView.finishHeartBeatAnimation()
        })
    }
    
    private func load() {
        ConfigRepository.shared.load { [unowned self] (result) in
            switch result {
            case .success:
                self.routeToMain()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func routeToMain() {
        let view = WeatherViewController.makeWeather()
        navigationController?.pushViewController(view, animated: true)
    }
}
