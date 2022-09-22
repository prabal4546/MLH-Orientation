//
//  HomeViewModel.swift
//  OrientationHack
//
//  Created by Prabaljit Walia on 22/09/22.
//

import SwiftUI

class HomeViewModel: ObservableObject{
    @Published var coins:[CryptoModel]?
    @Published var currentCoin:CryptoModel?
    
    init(){
        Task{
            do{
                try await fetchData()
            }catch{
                print(error)
            }
        }
    }
    
    func fetchData() async throws{
        guard let url = url else{return}
        let session = URLSession.shared
        
        let response = try await session.data(from: url)
        let jsonData = try JSONDecoder().decode([CryptoModel].self, from: response.0)
        
        await MainActor.run(body: {
            self.coins = jsonData
            if let firstCoin = jsonData.first{
                self.currentCoin = firstCoin
                print("WORKING->>\(jsonData)")
            }
        })
    }
}
