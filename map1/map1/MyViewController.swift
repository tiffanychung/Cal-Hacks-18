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
    let subtitle: String
    let latitude: Double
    let longitude: Double
    let date: String
}
//class UIButton: UIControl{
//    UIButton.contentEdgeInsets = UIEdgeInsets(top:15, left:20, bottom:10, right: 10)
//}

class MyViewController: UIViewController, MKMapViewDelegate
{
    var inum = 0  // 0 = today, 1 = this week, 2 = all time
    var annotationIsVisible = false
   
    let todayevents = [
        Event(title: "Cal Hacks",  subtitle: "11/2 - 11/4/18",  latitude: 37.872170, longitude: -122.251150, date: "04 November, 2018"),
        Event(title: "UCBSO Presents Beethoven and Sibelius!", subtitle: "11/3/18", latitude: 37.870020, longitude: -122.247390, date: "03 November, 2018"),
        Event(title: "The Berkeley Project", subtitle: "11/3/18", latitude: 37.869629, longitude: -122.258492, date: "03 November, 2018"),
        Event(title: "A Quiet Place DKA Escape Room", subtitle: "11/3/18", latitude: 37.867430, longitude: -122.253780, date: "03 November, 2018")
        ]
    
    let weekevents = [
        Event(title: "CASA | Professional Growth Conference", subtitle: "11/07/18", latitude: 37.869700, longitude: -122.261100, date: "07 November, 2018"),
        Event(title: "FoodInno Mochi Donut 2.0", subtitle: "11/7/18", latitude: 37.869629, longitude: -122.258492, date: "07 Novmember, 2018")

        ]
    
    let alltimeevents = [
        Event(title: "Applying to Study Abroad", subtitle: "11/14/18 2PM - 4PM", latitude: 37.871860, longitude: -122.254520, date: "14 November, 2018"),
        Event(title: "Women in Tech: The Future of AI", subtitle: "11/16/18", latitude: 37.871860, longitude: -122.254520, date: "16 November, 2018")
        ]
    var urldict = [
        "Cal Hacks" : "https://www.facebook.com/events/1888216391270580/", "UCBSO Presents Beethoven and Sibelius!" : "https://www.facebook.com/events/1906734562773165/?event_time_id=1906734572773164",
        "The Berkeley Project" : "https://www.facebook.com/events/892682820941665/", "A Quiet Place DKA Escape Room" : "https://www.facebook.com/events/171650203785350/", "CASA | Professional Growth Conference" : "https://www.facebook.com/events/2172671329648439/", "FoodInno Mochi Donut 2.0" : "https://www.facebook.com/events/349194888988712/", "Applying to Study Abroad" :"https://www.facebook.com/events/773024106368588/",
        "Women in Tech: The Future of AI" : "https://www.facebook.com/events/243581662938922/"
        ]
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var thisWeekButton: UIButton!
    @IBOutlet weak var allTimeButton: UIButton!
    func addpins(_ parameter: Array<Event>)
    {
        for Event in parameter {
            let annotation = MKPointAnnotation()
            annotation.title = Event.title
            annotation.subtitle = Event.subtitle
            annotation.coordinate = CLLocationCoordinate2D(latitude: Event.latitude, longitude: Event.longitude)
            mapView.addAnnotation(annotation)
        }
    }
    
    @objc func didTapTodayButton(_ sender: Any)
    {
        NSLog("pressed today button")
//        if !annotationIsVisible {
//            addtodaypins()
//            annotationIsVisible = true
//        }
        self.inum = 0
        updateMap()
    }
    
    @objc func didTapThisWeekButton(_ sender: Any)
    {
        NSLog("pressed this week button")
        //        if !annotationIsVisible {
        //            addtodaypins()
        //            annotationIsVisible = true
        //        }
        self.inum = 1
        updateMap()
    }
    
    @objc func didTapAllTimeButton(_ sender: Any)
    {
        NSLog("pressed all time button")
        //        if !annotationIsVisible {
        //            addtodaypins()
        //            annotationIsVisible = true
        //        }
        self.inum = 2
        updateMap()
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // set initial location in Berk
        self.todayButton.contentEdgeInsets = UIEdgeInsets(top:10, left:10, bottom:10, right: 10)
        self.thisWeekButton.contentEdgeInsets = UIEdgeInsets(top:10, left:10, bottom:10, right: 10)
        self.allTimeButton.contentEdgeInsets = UIEdgeInsets(top:10, left:10, bottom:10, right: 10)
        // rounding corners of buttons
        self.todayButton.layer.cornerRadius = 10
        self.thisWeekButton.layer.cornerRadius = 10
        self.allTimeButton.layer.cornerRadius = 10
        let initialLocation = CLLocation(latitude: 37.871899, longitude: -122.258537)
        let regionRadius: CLLocationDistance = 1500
        func centerMapOnLocation(location: CLLocation){
            let coordinateRegion =
                MKCoordinateRegion(center: location.coordinate,latitudinalMeters: regionRadius,longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(location: initialLocation)
        
        // My class will now consume things the map does 🙌
        mapView.delegate = self
        
        // show artwork on map
       
        self.view.bringSubviewToFront(self.todayButton)
        self.todayButton.addTarget(self, action: #selector(self.didTapTodayButton(_:)), for: .touchUpInside)
        
        self.view.bringSubviewToFront(self.thisWeekButton)
        self.thisWeekButton.addTarget(self, action: #selector(self.didTapThisWeekButton(_:)), for: .touchUpInside)
        
        self.view.bringSubviewToFront(self.allTimeButton)
        self.allTimeButton.addTarget(self, action: #selector(self.didTapAllTimeButton(_:)), for: .touchUpInside)
        
        addpins(todayevents)

    }
    func updateMap()
    {
        mapView.removeAnnotations(mapView.annotations)
        addpins(todayevents)
        if self.inum > 0
        {
            addpins(weekevents)
        }
        
        if self.inum == 2
        {
            addpins(alltimeevents)
        }
        
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        print("Clicked on pin??")
        if let annotationTitle = view.annotation?.title
        {
            print("User tapped on annotation with title: \(annotationTitle!)")
            UIApplication.shared.open(URL(string: self.urldict[annotationTitle!]!)!, options: [:], completionHandler: nil)
        }
        
    }

    
}

