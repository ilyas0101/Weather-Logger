//
//  WeatherViewController.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 24.02.2020.
//  Copyright (c) 2020 ilyas Yavuz. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherDisplayLogic: class {
    func display(viewModel: WeatherModels.GetLocation.ViewModel)
    func display(error: String)
}

class WeatherViewController: UIViewController, WeatherDisplayLogic, CLLocationManagerDelegate {
    var interactor: WeatherBusinessLogic?
    var router: (NSObjectProtocol & WeatherRoutingLogic & WeatherDataPassing)?
    
    @IBOutlet weak var weatherScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var locationManager: CLLocationManager?
    var allWeatherViews = [WeatherView]()
    var isfirstTime: Bool = false
    
    static func makeWeather() -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard
            let viewController = storyboard.instantiateInitialViewController() as? WeatherViewController
            else { return UIViewController() }
        let interactor = WeatherInteractor()
        let presenter = WeatherPresenter()
        let router = WeatherRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        return viewController
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherScrollView.delegate = self
        locationManager = CLLocationManager()
        getLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func getLocation() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .denied, .restricted:
            let alert = UIAlertController(
                title: "Location Services disabled",
                message: "Please enable Location Services in Settings",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
        default:
            break
        }
        
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let myCoord = locations.last
        locationManager?.stopUpdatingLocation()
        if !isfirstTime {
            interactor?.handle(request: WeatherModels.GetLocation.Request(lat: myCoord?.coordinate.latitude, lon: myCoord?.coordinate.longitude))
        }
        isfirstTime = true
    }
    
    private func createWeatherViews(weathers: [WeatherEntity], cells: [Int: [WeatherModels.Cell]]) {
        for weather in weathers {
            let view = WeatherView()
            view.willDisplay(weather: weather, cells: cells[weather.id])
            allWeatherViews.append(view)
        }
    }
    
    private func addWeatherToScrollView() {
        for i in 0 ..< allWeatherViews.count {
            let weatherView = allWeatherViews[i]
            let xPos = self.view.frame.width * CGFloat(i)
            weatherView.frame = CGRect(x: xPos, y: 0, width: weatherScrollView.bounds.width, height: weatherScrollView.bounds.height)
            
            weatherScrollView.addSubview(weatherView)
            weatherScrollView.contentSize.width = weatherView.frame.width * CGFloat(i + 1)
        }
    }
    
    // MARK: PageControll
    
    private func setPageControllPageNumber() {
        pageControl.numberOfPages = allWeatherViews.count
    }
    
    private func updatePageControlSelectedPage(currentPage: Int) {
        pageControl.currentPage = currentPage
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchLocationSeg" {
            guard let viewControler = segue.destination as? SearchViewController else { return }
            viewControler.delegate = self
        }
    }
    
    // MARK: Requests
    
    func display(viewModel: WeatherModels.GetLocation.ViewModel) {
        allWeatherViews.removeAll()
        createWeatherViews(weathers: viewModel.weathers, cells: viewModel.cells)
        addWeatherToScrollView()
        setPageControllPageNumber()
    }
    
    func display(error: String) {
        
    }
}

extension WeatherViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x / scrollView.frame.size.width
        updatePageControlSelectedPage(currentPage: Int(round(value)))
    }
}

extension WeatherViewController: SearchViewControllerDelegate {
    func didAdd(newLocation: WeatherLocation) {
        interactor?.handle(
            request: WeatherModels.GetWeather.Request(
                city: newLocation.city
            )
        )
    }
}
