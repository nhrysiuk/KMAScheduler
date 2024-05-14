//
//  MapViewViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 14.05.2024.
//

import UIKit
import MapKit
import SwiftUI

class MapViewViewController: UIViewController {

    private var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Скасувати", for: .normal)
        button.setTitleColor(.cobalt, for: .normal)
        button.titleLabel?.font =  Const.mediumFont
        
        return button
    }()
    
    var coordinate: CLLocationCoordinate2D!
    var auditorium: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    private func setupView() {
        let hostingController = UIHostingController(rootView: MapView(coordinate: coordinate, auditorium: auditorium))
        let mapView = hostingController.view!
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        view.addSubview(mapView)
        view.addSubview(backButton)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mapView.topAnchor.constraint(equalTo: backButton.topAnchor, constant:  -30),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        hostingController.didMove(toParent: self)
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
