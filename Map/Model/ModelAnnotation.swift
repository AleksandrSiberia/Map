//
//  ModelAnnotation.swift
//  Map
//
//  Created by Александр Хмыров on 04.12.2022.
//

import Foundation
import MapKit


class ModelAnnotation: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D

    var title: String?


    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
    }

}
