//
//  RouteServise.swift
//  Map
//
//  Created by Александр Хмыров on 05.12.2022.
//

import Foundation
import MapKit



class RouteService: NSObject, MKMapViewDelegate {


    var coordinator: CoordinatorProtocol?



    func setRoute(coordinateStart: CLLocationCoordinate2D, coordinateFinish: CLLocationCoordinate2D, nameFinishLocation: String) {

        let annotationStart = ModelAnnotation(
            coordinate: coordinateStart,
            title: "IPhone")

        let annotationFinish = ModelAnnotation(
            coordinate: coordinateFinish,
            title: nameFinishLocation)

        // delete

        self.coordinator?.mapViewController?.mapViewCustom.showAnnotations([annotationStart, annotationFinish], animated: true)

        let startItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinateStart))

        let finishItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinateFinish))

        let request = MKDirections.Request()
        request.source = startItem
        request.destination = finishItem
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { response, error in

            if let error {
                print("‼️", error.localizedDescription)
                return
            }

            if let routes = response?.routes {
                if routes.isEmpty == false {
                    let route = routes.first!
                    self.coordinator?.mapViewController?.mapViewCustom.addOverlay(route.polyline, level: .aboveRoads)

                    let rect = route.polyline.boundingMapRect

                    self.coordinator?.mapViewController?.mapViewCustom.setRegion(MKCoordinateRegion(rect), animated: true)
                }
            }

        }
    }



    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolygonRenderer(overlay: overlay)
        renderer.lineWidth = 3.5
        renderer.strokeColor = .red

        return renderer

    }

}
