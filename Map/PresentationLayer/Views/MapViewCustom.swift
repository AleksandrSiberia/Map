//
//  CustomMapView.swift
//  Map
//
//  Created by Александр Хмыров on 04.12.2022.
//

import MapKit


class MapViewCustom: MKMapView {

    lazy var defaultLocation = CLLocation(latitude: 52.2978, longitude: 104.296).coordinate


    lazy var regionIrkutsk = MKCoordinateRegion(center: defaultLocation, latitudinalMeters: 10_000, longitudinalMeters: 10_000)



    init() {
        super.init(frame: .zero)

        mapType = .mutedStandard
        showsScale = true
        translatesAutoresizingMaskIntoConstraints = false

        setRegion(regionIrkutsk, animated: true)



    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func addNewAnnotation(name: String, location: CLLocationCoordinate2D) {
        addAnnotation(ModelAnnotation(coordinate: location, title: name))
    }
}
