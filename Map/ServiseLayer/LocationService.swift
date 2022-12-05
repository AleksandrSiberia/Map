//
//  LocationService.swift
//  Map
//
//  Created by Александр Хмыров on 04.12.2022.
//

import Foundation
import CoreLocation


class LocationService: NSObject, CLLocationManagerDelegate {


    var coordinator: CoordinatorProtocol?

    lazy var locationManager = CLLocationManager()

    lazy var geocoder = CLGeocoder()




    override init() {
        super.init()
        
        self.locationManager.delegate = self

    }




    func getLocationByAddress(address: String, completionHandler: @escaping (CLLocationCoordinate2D?) -> Void  ) {

        self.geocoder.geocodeAddressString(address) { clPlacemark, error in

            if let error {
                print("‼️", error.localizedDescription)
                completionHandler(nil)
            }
            if let location = clPlacemark?.first?.location {

                completionHandler(location.coordinate)
            }
        }
    }




    func getLocationPhone(completion: (CLLocation?) -> Void) {

        let location = self.locationManager.location
        completion(location)
    }

    

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

        switch manager.authorizationStatus {

        case .notDetermined:
            print("notDetermined")

        case .restricted, .denied:
            print("denied, restricted")

        case .authorizedAlways, .authorizedWhenInUse:
            print("🏓 authorizedWhenInUse, authorizedAlways")

        self.locationManager.startUpdatingLocation()

        manager.requestLocation()



        @unknown default:
            print("@unknown default")
        }
    }


    




    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let locations = locations.first?.coordinate  {


        self.coordinator?.mapViewController?.mapViewCustom.setCenter(locations, animated: true)

            let annotation = ModelAnnotation(coordinate: locations, title: "IPhone")


            if let annotation = self.coordinator?.mapViewController?.currentAnnotation {
                self.coordinator?.mapViewController?.mapViewCustom.removeAnnotation(annotation)
            }

            self.coordinator?.mapViewController?.mapViewCustom.addAnnotation(annotation)

            self.coordinator?.mapViewController?.currentAnnotation = annotation

            
            self.coordinator?.mapViewController?.currentLocation = locations


        print("🥨 didUpdateLocations")


        }
    }



    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("‼️", error.localizedDescription)
  
    }



}
