//
//  ViewController.swift
//  map1
//
//  Created by Tiffany Chung on 11/3/18.
//  Copyright © 2018 Tiffany Chung. All rights reserved.
//

import UIKit
import MapKit

struct Event {
    let title: String
    let latitude: Double
    let longitude: Double
    let date: String
}

class ViewController: UIViewController
{
    var inum = 0  // 0 = today, 1 = this week, 2 = all time
    var annotationIsVisible = false

   
    let todayevents = [
        Event(title: "Sproul Plaza",    latitude: 37.870870, longitude: -122.259680, date: "25 Jun, 2016"),
        Event(title: "Moffitt Library", latitude: 37.868590, longitude: -122.260290, date: "30 Jun, 2016"),
        ]
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var thisWeekButton: UIButton!
    @IBOutlet weak var allTimeButton: UIButton!
    
    func addtodaypins()
    {
        for Event in todayevents {
            let annotation = MKPointAnnotation()
            annotation.title = Event.title
            annotation.coordinate = CLLocationCoordinate2D(latitude: Event.latitude, longitude: Event.longitude)
            mapView.addAnnotation(annotation)
        }
    }
    
    func todaybutton(_ sender: Any)
    {
        if !annotationIsVisible {
            addtodaypins()
            annotationIsVisible = true
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 37.871899, longitude: -122.258537)
        let regionRadius: CLLocationDistance = 1000
        func centerMapOnLocation(location: CLLocation){
            let coordinateRegion =
                MKCoordinateRegion(center: location.coordinate,latitudinalMeters: regionRadius,longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(location: initialLocation)
        
        // show artwork on map
       
    
//        for Event in events {
//            let annotation = MKPointAnnotation()
//            annotation.title = Event.title
//            annotation.coordinate = CLLocationCoordinate2D(latitude: Event.latitude, longitude: Event.longitude)
//            mapView.addAnnotation(annotation)
//        }

    }
//    func addtodaypins()
//    {
//        for Event in todayevents {
//            let annotation = MKPointAnnotation()
//            annotation.title = Event.title
//            annotation.coordinate = CLLocationCoordinate2D(latitude: Event.latitude, longitude: Event.longitude)
//            mapView.addAnnotation(annotation)
//        }
//    }
//    var annotationIsVisible = false
//    @IBAction func todaybutton(_ sender: Any)
//    {
//        if !annotationIsVisible {
//            addtodaypins()
//            annotationIsVisible = true
//    }
//    }
    
}

