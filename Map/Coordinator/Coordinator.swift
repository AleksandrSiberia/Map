//
//  Coordinator.swift
//  Map
//
//  Created by Александр Хмыров on 04.12.2022.
//

import Foundation



class Coordinator: CoordinatorProtocol {



    var locationService = LocationService()

    var routeService = RouteService()



    weak var mapViewController: MapViewController?



    func showMapViewController() -> MapViewController {

        self.locationService.coordinator = self
        

        let controller =  MapViewControllerAssembly.getMapViewController(coordinator: self)

        self.mapViewController = controller

        return controller


    }
}
