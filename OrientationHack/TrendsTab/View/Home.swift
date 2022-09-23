//
//  Home.swift
//  OrientationHack
//
//  Created by Prabaljit Walia on 22/09/22.
//

import SwiftUI
import Charts
struct Home: View {
    @State  var currentCoin:String = "BTC"
    @Namespace var animation
    @StateObject var homeViewModel:HomeViewModel = HomeViewModel()
    var body: some View {
        VStack{
            if let coins = homeViewModel.coins, let coin = homeViewModel.currentCoin{
                HStack(spacing: 10){
                    AsyncImage(url: URL(string: coin.image), transaction: .init(animation: .spring())) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                case .failure:
                                    Text("Failed fetching image. Make sure to check your data connection and try again.")
                                        .foregroundColor(.red)
                                @unknown default:
                                    Text("Unknown error. Please try again.")
                                        .foregroundColor(.red)
                                }
                            }
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading, spacing: 5) {
                        Text(coin.name)
                            .font(.callout)
                        Text(coin.id)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                CustomControl(coins: coins)
                VStack(alignment: .leading, spacing: 10) {
                    Text(coin.current_price.doubleToCurrency())
                        .font(.largeTitle)
                    Text("\(coin.price_change)")
                        .font(.caption)
                        .foregroundColor(coin.price_change < 0 ? Color.white:Color.black)
                        .padding()
                        .background{
                            Capsule()
                                .fill(coin.price_change<0 ? .red:.green)
                        }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                lineGraph(coin: coin)
//                    .frame(height: 400)
                          .padding(4)
//                          .background(Color.gray.opacity(0.1).cornerRadius(16))
//                          .padding()
                    
            }else{
                ProgressView()
            }
            
            
            
        }.padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    // MARK: Custom Segmented Control
    @ViewBuilder
    func CustomControl(coins: [CryptoModel])->some View{
        ScrollView(.horizontal, showsIndicators: false){
            
            HStack(spacing:10) {
                ForEach(coins){coin in
                    Text(coin.symbol.uppercased())
                        .foregroundColor(currentCoin == coin.symbol.uppercased() ? .white:.gray)
                        .padding(.vertical,5)
                        .padding(.horizontal,10)
                        .contentShape(Rectangle())
                        .background{
                            if currentCoin == coin.symbol.uppercased(){
                                Rectangle()
                                    .fill(Color.gray)
                                    .matchedGeometryEffect(id: "SegmentSelection", in: animation)
                            }
                        }.onTapGesture {
                            homeViewModel.currentCoin = coin
                            withAnimation{currentCoin = coin.symbol.uppercased()}
                        }
                }
            }
        }.background{
            RoundedRectangle(cornerRadius: 5, style: .continuous)
        }.padding(.vertical)
    }
    
    // MARK: Graph View
    @ViewBuilder
    func lineGraph(coin: CryptoModel)->some View{
        GeometryReader{_ in
            LineGraph(data: coin.last_7days_price.price, profits: coin.price_change<0)
        }.padding(.vertical,30)
            .padding(.bottom,20)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

