//
//  CoordinatorPratocol.swift
//  Map
//
//  Created by Александр Хмыров on 04.12.2022.
//

import Foundation


protocol CoordinatorProtocol {

    var mapViewController: MapViewController? { get set }

    var routeService: RouteService { get set }
    
    var locationService: LocationService { get set }
    
    func showMapViewController() -> MapViewController


}
