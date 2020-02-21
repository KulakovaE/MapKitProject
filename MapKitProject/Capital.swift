//
//  Capital.swift
//  MapKitProject
//
//  Created by Elena Kulakova on 2020-02-21.
//  Copyright © 2020 Elena Kulakova. All rights reserved.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
