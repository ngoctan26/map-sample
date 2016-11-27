//
//  ViewController.swift
//  MapDemo
//
//  Created by Nguyen Quang Ngoc Tan on 11/20/16.
//  Copyright © 2016 Nguyen Quang Ngoc Tan. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, CLLocationManagerDelegate{
    
    var locationManger = CLLocationManager()
    var didFindMyLocation = false
    
    // Views properties
    @IBOutlet weak var m_viewMap: GMSMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initMap() {
        // init Location manger
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        
        // Add observer for changes in myLocation in viewMap
        m_viewMap.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.new, context: nil)
        
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            // User have allow to access current location
            m_viewMap.isMyLocationEnabled = true
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if !didFindMyLocation {
            // Current location is detected
            guard let currentLocation = m_viewMap.myLocation else {
                print("Current location is nil")
                return
            }
            m_viewMap.camera = GMSCameraPosition.camera(withTarget: (currentLocation.coordinate), zoom: 15.0)
            m_viewMap.settings.myLocationButton = true // This property enable my location button on Map
        }
    }

}

