//
//  ViewController.swift
//  Map
//
//  Created by Александр Хмыров on 04.12.2022.
//

import UIKit



class MapViewController: UIViewController {


    var coordinator: CoordinatorProtocol?

    var arrayAnnotation: [ModelAnnotation] = []


    private lazy var buttonAddAnnotation: UIBarButtonItem = {

        var buttonAddAnnotation = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(actionButtonAddAnnotation))


        return buttonAddAnnotation
    }()




    private lazy var buttonDeleteAnnotation: UIBarButtonItem = {

        var buttonAddAnnotation = UIBarButtonItem(image: UIImage(systemName: "xmark.bin"), style: .plain, target: self, action: #selector(actionButtonDeleteAnnotation))

        return buttonAddAnnotation
    }()



   lazy var mapViewCustom: MapViewCustom = {

        var mapViewCustom = MapViewCustom()
        return mapViewCustom
    }()




    
    override func viewDidLoad() {
        super.viewDidLoad()

        [self.mapViewCustom].forEach {
            self.view.addSubview($0) }

        self.navigationItem.rightBarButtonItems = [self.buttonDeleteAnnotation, self.buttonAddAnnotation ]

        setupLayoutConstraints()


    }



    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.coordinator?.locationService.locationManager.requestWhenInUseAuthorization()




    }



    private func setupLayoutConstraints() {

        let safeAreaGuide = self.view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([

            self.mapViewCustom.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            self.mapViewCustom.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            self.mapViewCustom.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            self.mapViewCustom.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),

        ])
    }



    
    @objc func actionButtonAddAnnotation() {

        let alertWriteAddress = UIAlertController(title: "Добавить метку", message: "напишите адрес", preferredStyle:  .alert)

        alertWriteAddress.addTextField() { textField in

            textField.keyboardType = .namePhonePad
        }


        let actionWriteAddress = UIAlertAction(title: "Ok", style: .default) {_ in

            let address = alertWriteAddress.textFields?.first?.text ?? ""


            self.coordinator?.locationService.getLocationByAddress(address: address) { location in

                if let location {

                    let annotation = ModelAnnotation(coordinate: location, title: address)

                    self.arrayAnnotation.append(annotation)

                    self.mapViewCustom.addAnnotation(annotation)


                    let alertSuccessAddAddress = UIAlertController(title: "Метка добавлена", message: nil, preferredStyle: .actionSheet)

                    let actionSuccessAddAddress = UIAlertAction(title: "Ok", style: .cancel) { _ in

                        self.mapViewCustom.setCenter(location, animated: true)
                    }

                    alertSuccessAddAddress.addAction(actionSuccessAddAddress)

                    self.navigationController?.present(alertSuccessAddAddress, animated: true)


                }



                else {

                    let alertError = UIAlertController(title: nil, message: "Адрес не найден, попробуйте еще раз", preferredStyle: .actionSheet)
                    let actionError = UIAlertAction(title: "Ok", style: .cancel)

                    alertError.addAction(actionError)

                    self.navigationController?.present(alertError, animated: true)
                }

            }

        }

        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)

        alertWriteAddress.addAction(actionWriteAddress)

        alertWriteAddress.addAction(actionCancel)

        self.navigationController?.present(alertWriteAddress, animated: true)



    }



    @objc func actionButtonDeleteAnnotation() {

        if self.arrayAnnotation.isEmpty == false {

            let alert = UIAlertController(title: nil, message: "удалить метки?", preferredStyle: .alert)

            let actionDelete = UIAlertAction(title: "Delete", style: .destructive) {_ in

                self.mapViewCustom.removeAnnotations(self.arrayAnnotation)
            }

            alert.addAction(actionDelete)

            let actionNo = UIAlertAction(title: "No", style: .cancel)

            alert.addAction(actionNo)

            self.navigationController?.present(alert, animated: true)

        }


        
        else {

            let alert = UIAlertController(title: nil, message: "у вас нет меток для удаления", preferredStyle: .actionSheet)

            let action = UIAlertAction(title: "Ok", style: .cancel)

            alert.addAction(action)

            self.navigationController?.present(alert, animated: true)
        }
    }

}



