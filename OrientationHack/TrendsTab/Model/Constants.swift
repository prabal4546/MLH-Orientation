//
//  Constants.swift
//  OrientationHack
//
//  Created by Prabaljit Walia on 22/09/22.
//

import Foundation

let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&sparkline=true&price_change_percentage=24h")
extension Double{
    func doubleToCurrency()->String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: .init(value: self)) ?? ""
    }
}
