//
//  WeatherView.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 25.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import UIKit

class WeatherView: UIView {
    let identifier = "WeatherView"
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var weathertype: UILabel!
    
    private var cells = [WeatherModels.Cell]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: InfoCell.identifier, bundle: nil), forCellWithReuseIdentifier: InfoCell.identifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    func loadViewFromNib() {
        Bundle.main.loadNibNamed(identifier, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    func willDisplay(weather: WeatherEntity, cells: [WeatherModels.Cell]?) {
        if let cells = cells {
            self.cells = cells
        }
        
        guard let firstWeather = weather.weather.first else { return }
        let weatherIcon = WeatherIconEntity(condition: firstWeather.id, iconString: firstWeather.icon)
        let country = weather.sys.country
        let temperature = Temperature(country: country, openWeatherMapDegrees: weather.main.temp)
        
        temperatureLabel.text = temperature.degrees
        locationLabel.text = weather.name
        iconLabel.text = weatherIcon.iconText
        weathertype.text = firstWeather.description
        configureLabels()
        configureLabelsWithAnimation()
        collectionView.reloadData()
    }
    
    func configureLabels() {
        locationLabel.center.x  -= self.bounds.width
        iconLabel.center.x -= self.bounds.width
        temperatureLabel.center.x -= self.bounds.width
        iconLabel.alpha = 0.0
        locationLabel.alpha = 0.0
        temperatureLabel.alpha = 0.0
    }
    
    func configureLabelsWithAnimation() {
        UIView.animate(withDuration: 0.5, animations: {
            self.locationLabel.center.x += self.bounds.width
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
            self.iconLabel.center.x += self.bounds.width
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
            self.temperatureLabel.center.x += self.bounds.width
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
            self.iconLabel.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, options: [], animations: {
            self.locationLabel.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
            self.temperatureLabel.alpha = 1.0
        }, completion: nil)
    }
}

extension WeatherView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = cells[indexPath.row]
        return collectionView.dequeueReusableCell(withReuseIdentifier: item.identifier(), for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let item = cells[indexPath.row]
        
        switch item {
        case let .cell(info, name, image):
            guard let cell = cell as? InfoCell else { return }
            cell.willDisplay(info: info, name: name, image: image)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width - 60) / 3
        return CGSize(width: cellWidth, height: 60)
    }
}
