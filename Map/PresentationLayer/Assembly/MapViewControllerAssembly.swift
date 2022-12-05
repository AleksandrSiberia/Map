//
//  Assenbley.swift
//  Map
//
//  Created by Александр Хмыров on 04.12.2022.
//

import Foundation


class MapViewControllerAssembly {

    class func getMapViewController(coordinator: CoordinatorProtocol) -> MapViewController {

        let controller = MapViewController()

        controller.view.backgroundColor = .white

        controller.coordinator = coordinator

        return controller

    }
}
