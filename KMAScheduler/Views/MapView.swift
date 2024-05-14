//
//  MapView.swift
//  swiftUI1
//
//  Created by Анастасія Грисюк on 17.04.2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    var auditorium: String
    
    var body: some View {
        if #available(iOS 17.0, *) {
            VStack {
                Map(position: .constant(.region(region)))
                Text(auditorium)
            }
        }
    }

    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.0005, longitudeDelta: 0.001)
        )
    }
}

//#Preview {
//    MapView(coordinate: CLLocationCoordinate2D(latitude: 50.464187, longitude: 30.520186))
//}

