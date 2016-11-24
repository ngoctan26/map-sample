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
    @IBOutlet var viewMap: GMSMapView!
    

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
        viewMap.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.new, context: nil)
        
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            // User have allow to access current location
            viewMap.isMyLocationEnabled = true
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if !didFindMyLocation {
            // Current location is detected
            guard let currentLocation = viewMap.myLocation else {
                print("Current location is nil")
                return
            }
            viewMap.camera = GMSCameraPosition.camera(withTarget: (currentLocation.coordinate), zoom: 15.0)
            viewMap.settings.myLocationButton = true // This property enable my location button on Map
        }
    }

}

