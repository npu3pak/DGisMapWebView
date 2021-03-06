//
//  ViewController.swift
//  Example2GisApi
//
//  Created by Aleksandr Smetannikov on 27/12/2019.
//  Copyright © 2019 Aleksandr Smetannikov. All rights reserved.
//

import UIKit
import MapKit
import MBProgressHUD

class ViewController: UIViewController, DGMapWebViewDelegate{

    @IBOutlet weak var mapView: DGMapWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        MBProgressHUD.showAdded(to: view, animated: true)
        // init map for Moscow city
        let maxBounds = MapBounds(topLeft: CLLocationCoordinate2D(latitude: 57.053422, longitude: 35.139385),
                                  bottomRight: CLLocationCoordinate2D(latitude: 54.279764, longitude: 40.362835))

        mapView.loadMap(
            latitude: 55.753215,
            longitude: 37.622504,
            zoom: 14,
            minZoom: 8,
            disableClusteringAtZoom: 14,
            maxClusterRadius: 40,
            maxBounds: maxBounds
        )
    }

    // MARK: - События карты

    func mapLoaded() {
        print("2Gis map loaded!")
        addIcons()
        addMarkers()
        mapView.setHome(latitude: 55.753215, longitude: 37.622504)
        MBProgressHUD.hide(for: view, animated: true)
    }

    func mapError(_ errorMessage: String) {
        MBProgressHUD.hide(for: view, animated: true)
        print("2Gis map error: \(errorMessage)")
    }

    func mapMoved(zoom: Int, bounds mapBounds: MapBounds) {
        print("Map was moved! zoom = \(zoom), bounds = \(mapBounds)")
    }

    func markerClicked(_ id: String, latitude: Float, longitude: Float) {
        mapView.setView(latitude: latitude, longitude: longitude)
        let alert = UIAlertController(title: nil, message: " MarkerId: \(id) \n Latitude: \(latitude) \n Longitude: \(longitude)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    // MARK: -  Добавление маркеров

    private func addIcons() {
        mapView.addIcon(id: "0", imageUrl: "https://img.icons8.com/flat_round/64/000000/salamander--v1.png", height: 30, width: 30)
        mapView.addIcon(id: "1", imageUrl: "https://img.icons8.com/flat_round/64/000000/owl--v1.png", height: 30, width: 30)
        mapView.addIcon(id: "2", imageUrl: "https://img.icons8.com/flat_round/64/000000/pinguin--v1.png", height: 30, width: 30)
        mapView.addIcon(id: "3", imageUrl: "https://img.icons8.com/flat_round/64/000000/lion.png", height: 30, width: 30)
        mapView.addIcon(id: "4", imageUrl: "https://img.icons8.com/flat_round/64/000000/warranty-card.png", height: 30, width: 30)
        mapView.addIcon(id: "5", imageUrl: "https://img.icons8.com/flat_round/64/000000/cap.png", height: 30, width: 30)
        mapView.addIcon(id: "6", imageUrl: "https://img.icons8.com/flat_round/64/000000/update-left-rotation.png", height: 30, width: 30)
        mapView.addIcon(id: "7", imageUrl: "https://img.icons8.com/flat_round/64/000000/youtube-play.png", height: 30, width: 30)
        mapView.addIcon(id: "8", imageUrl: "https://img.icons8.com/flat_round/64/000000/filled-like.png", height: 30, width: 30)
        mapView.addIcon(id: "9", imageUrl: "https://img.icons8.com/flat_round/64/000000/three-stars.png", height: 30, width: 30)
    }

    private func addMarkers() {
        MBProgressHUD.showAdded(to: view, animated: true)

        DispatchQueue.main.async {
             for i in 0..<1000 {
                 let lat = Float.random(in: 55.7...55.8)
                 let lng = Float.random(in: 37.4...37.8)
                 self.mapView.addMarker(id: "\(i)", iconId: "\(i%10)", latitude: lat, longitude: lng)
             }
             self.mapView.addMarker(id: "1", iconId: "0", latitude: 55.756111, longitude: 37.625420)
             self.mapView.addMarker(id: "2", iconId: "0", latitude: 55.753570, longitude: 37.632286)
             self.mapView.addMarker(id: "3", iconId: "1", latitude: 55.738538, longitude: 37.633853)
             self.mapView.addMarker(id: "4", iconId: "1", latitude: 55.743089, longitude: 37.561240)
             self.mapView.addMarker(id: "5", iconId: "9", latitude: 55.722845, longitude: 37.621493)
             self.mapView.addMarker(id: "6", iconId: "9", latitude: 55.738683, longitude: 37.578835)

            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }

    // MARK: - Пользовательские действия

    @IBAction func zoomInClick(_ sender: UIButton) {
        mapView.zoomIn()
    }

    @IBAction func zoomOutClick(_ sender: UIButton) {
        mapView.zoomOut()
    }

    @IBAction func setZoomClick(_ sender: UIButton) {
        mapView.setZoom(15)
    }

    @IBAction func addMarkersClick(_ sender: UIButton) {
        addMarkers()
    }

    @IBAction func removeAllMarkersClick(_ sender: UIButton) {
        mapView.removeAllMarkers()
    }

    @IBAction func getBoundsClick(_ sender: UIButton) {
        mapView.getZoom {
            if let zoom = $0 {
                print("map zoom = \(zoom)")
            } else {
                print("map zoom unavailable")
            }
        }

        mapView.getBounds { mapBounds in
            if let mapBounds = mapBounds {
                print("map bounds = \(mapBounds)")
            } else {
                print("map bounds unavailable")
            }
        }
    }
}

