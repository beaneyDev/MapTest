//
//  ViewController.swift
//  MapTest
//
//  Created by Matt Beaney on 27/11/2016.
//  Copyright © 2016 Matt Beaney. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, GMSMapViewDelegate {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var map: UIView!
    @IBOutlet weak var background: UIImageView!
    var mapView: GMSMapView!
    
    let infoMarker = GMSMarker()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMap()
        go()
        
        let locationManager = CLLocationManager()
        
        
    }
    
    func go() {
        self.spinner.startAnimating()
        on.delay(1.0, task: {
            on.main {
                let toImage = UIImage(named:"background-blurred")
                UIView.transition(with: self.background,
                                  duration:0.3,
                                  options: UIViewAnimationOptions.transitionCrossDissolve,
                                  animations: { self.background.image = toImage },
                                  completion: nil)
                
                on.delay(0.5, task: { 
                    on.main {
                        UIView.animate(withDuration: 0.3, animations: {
                            self.map.alpha = 1.0
                        })
                        
                        self.spinner.stopAnimating()
                        self.spinner.alpha = 0.0
                    }
                })
            }
        })
    }
    
    func setUpMap() {
        //Initialise
        self.map.alpha = 0.0
        let camera = GMSCameraPosition.camera(withLatitude: 52.391305, longitude: 0.650453, zoom: 15)
        self.mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isIndoorEnabled = true
        mapView.accessibilityElementsHidden = false
        mapView.delegate = self
        mapView.layer.borderColor = UIColor.white.cgColor
        mapView.layer.borderWidth = 2.0
        mapView.mapType = kGMSTypeHybrid
        
        //Set initial marker
        let position = CLLocationCoordinate2DMake(52.391305, 0.650453)
        let marker = GMSMarker(position: position)
        marker.title = "Hello World"
        marker.map = mapView
        
        //Positioning
        mapView.translatesAutoresizingMaskIntoConstraints = false
        map.addSubview(mapView)
        
        let views = ["map": mapView]
        let width = NSLayoutConstraint.constraints(withVisualFormat: "H:|[map]|", options: [], metrics: nil, views: views)
        let height = NSLayoutConstraint.constraints(withVisualFormat: "V:|[map]|", options: [], metrics: nil, views: views)
        map.addConstraints(width)
        map.addConstraints(height)
    }
    
    @IBAction func switchTerrain(_ sender: Any) {
        self.mapView.mapType = kGMSTypeNormal
    }
    
    
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {        
        UIAlertView(title: name, message: "Here is \(name)", delegate: self, cancelButtonTitle: "OK").show()
        infoMarker.snippet = placeID
        infoMarker.position = location
        infoMarker.title = name
        infoMarker.opacity = 0;
        infoMarker.infoWindowAnchor.y = 1
        infoMarker.map = mapView
        mapView.selectedMarker = infoMarker
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

