//
//  HomeView.swift
//  OrientationHack
//
//  Created by Prabaljit Walia on 21/09/22.
//

import SwiftUI
//import CoreLocation
//import WeatherKit
//import Charts


//struct HomeView: View {
//    let weatherService = WeatherService.shared
//    @StateObject private var locationManager = LocationManager()
//    @State private var weather:Weather?
//    var body: some View {
//        VStack{
//            if let weather{
//                VStack{
//                    Text("\(weather.currentWeather.temperature.formatted())")
//                }
//            }
//        }.task(id: locationManager.currentLocation) {
//            do{
//                if let location = locationManager.currentLocation{
//                    self.weather = try await weatherService.weather(for: location)
//                    print("PRINTING WEATHER \(weather)")
//                }
//
//            }catch{
//                print("ERROR: \(error)")
//            }
//        }
//    }
//}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
//
//// MARK: LOCATION MANAGER
//class LocationManager: NSObject, ObservableObject {
//
//    @Published var currentLocation: CLLocation?
//    private let locationManager = CLLocationManager()
//
//    override init() {
//        super.init()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.distanceFilter = kCLDistanceFilterNone
//        locationManager.requestAlwaysAuthorization()
//        locationManager.startUpdatingLocation()
//        locationManager.delegate = self
//    }
//
//}
//extension LocationManager: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        guard let location = locations.last, currentLocation == nil else { return }
//
//        DispatchQueue.main.async {
//            self.currentLocation = location
//        }
//    }
//}
//
