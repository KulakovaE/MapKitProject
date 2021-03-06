//
//  ViewController.swift
//  MapKitProject
//
//  Created by Elena Kulakova on 2020-02-21.
//  Copyright © 2020 Elena Kulakova. All rights reserved.
//

import UIKit
import MapKit

//This I need to change the color for the pin
class MyPointAnnotation : MKPointAnnotation {
    var pinTintColor: UIColor?
}

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        self.mapView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(rightNavBtnClicked))
    }
    
    @objc func rightNavBtnClicked(action: UIAlertAction) {
        let ac = UIAlertController(title: "Welcome!", message: "How do you like to see the map?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Satelite", style: .default, handler: { (action) in
            DispatchQueue.main.async {
                self.mapView.mapType = .satellite
            }
        }))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: { (action) in
            DispatchQueue.main.async {
                self.mapView.mapType = .hybrid
            }
        }))
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: { (action) in
            DispatchQueue.main.async {
                self.mapView.mapType = .standard
            }
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        present(ac, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard annotation is Capital else { return nil }
        let identifirer = "Capital"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifirer) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifirer)
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            //changing color for the pinAnnotation
            annotationView?.pinTintColor = UIColor.blue
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        
        if let annotation = annotation as? MyPointAnnotation {
            annotationView?.pinTintColor = annotation.pinTintColor
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        ac.addAction(UIAlertAction(title: "Wiki", style: .default, handler: { (action) in
            DispatchQueue.main.async {
                //do the DI to show wikipedia view for the clicked city
                if let webViewController = self.storyboard?.instantiateViewController(identifier: "WebViewController") as? WebViewController {
                    if let placeName = placeName {
                        webViewController.city = placeName
                        self.navigationController?.pushViewController(webViewController, animated: true)
                    }
                }
            }
        }))
        present(ac, animated: true)
    }
}

