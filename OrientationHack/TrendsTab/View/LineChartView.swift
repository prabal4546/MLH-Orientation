//
//  LineChartView.swift
//  OrientationHack
//
//  Created by Prabaljit Walia on 22/09/22.
//

import SwiftUI
import Charts


// MARK: LINE GRAPH
struct LineGraph: View {
    
    // Number of plots
    var data: [Double]
    var profits:Bool = false
    
    @State var currentPlot = ""
    
    // Offset ...
    @State var offset: CGSize = .zero
    @State var showPlot = false
    @State var translation: CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            
            let height  = proxy.size.height
            let width   = (proxy.size.width) / CGFloat(data.count - 1)
            
            let maxPoint = (data.max() ?? 0) + 100
            let minPoint = data.min() ?? 0
            
            let points = data.enumerated().compactMap { item -> CGPoint in
                // getting progress and multiplying with height ...
                let progress = (item.element - minPoint) / (maxPoint-minPoint)
                let pathHeight = progress * (height - 50)
                // width ...
                let pathWidth = width * CGFloat(item.offset)
                
                // Since we need peak to top not bottom ...
                return CGPoint(x: pathWidth, y: -pathHeight + height)
            }
            
            
            ZStack {
                
                // Converting plot as points ...
                
                
                // Path ...
                Path { path in
                    // drawing the points
                    path.move(to: CGPoint(x: 0, y: 0))
                    
                    path.addLines(points)
                }
                .strokedPath(StrokeStyle(lineWidth: 2.5,
                                         lineCap: .round,
                                         lineJoin: .round))
                .fill(
                    // Gradient ...
                    LinearGradient(colors: [
                        profits ? Color.red : Color.green,
                        profits ? Color.red : Color.green],
                                   
                                   startPoint: .leading,
                                   endPoint: .trailing)
                )
                
                // Path Background Coloring
                FillBG()
                // Clipping the shape ...
                    .clipShape(
                        Path { path in
                            // drawing the points
                            path.move(to: CGPoint(x: 0, y: 0))
                            
                            path.addLines(points)
                            path.addLine(to: CGPoint(x: proxy.size.width,
                                                     y: height))
                            path.addLine(to: CGPoint(x: 0,
                                                     y: height))
                        }
                    )
            }
            .overlay(
                // Drag Indicator ...
                VStack(spacing: 0) {
                    
                    Text(currentPlot)
                        .font(.caption.bold())
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .background(.blue, in: Capsule())
                        .offset(x: translation < 10 ? 30 : 0)
                        .offset(x: translation > (proxy.size.width - 60) ? -30 : 0)
                    
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 1, height: 45)
                        .padding(.top)
                    
                    Circle()
                        .fill(.blue)
                        .frame(width: 22, height: 22)
                        .overlay(
                            Circle()
                                .fill(.white)
                                .frame(width: 12, height: 12)
                        )
                    
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 1, height: 45)
                    
                }
                // Fixed Frame ...
                // For Gesture Calculation
                    .frame(width: 80, height: 170)
                // 170 / 2 = 85 - 15 (circle ring size)
                    .offset(y: 70)
                    .offset(offset)
                    .opacity(showPlot ? 1 : 0),
                alignment: .bottomLeading
            )
            .contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        withAnimation { showPlot = true }
                        let translation = value.location.x - 40
                        // Getting index ...
                        let index = max(min(Int((translation / width).rounded() + 1), data.count - 1), 0)
                        currentPlot = "$ \(data[index])"
                        self.translation = translation
                        // removing half width
                        offset = CGSize(width: points[index].x - 40, height: points[index].y - height)
                    }).onEnded({ value in
                        withAnimation { showPlot = false }
                    })
            )
        }
        .overlay(
            VStack(alignment: .leading) {
                let max = data.max() ?? 0
                let min = data.min() ?? 0
                Text(max.doubleToCurrency())
                    .font(.caption.bold())
                
                Spacer()
                
                VStack(alignment:.leading){
                    Text(min.doubleToCurrency())
                    Text("Last Week")
                        .font(.caption)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        )
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder
    func FillBG() -> some View {
        let color = profits ? Color.red : Color.green
        LinearGradient(colors: [color.opacity(0.6), color.opacity(0.1)],
                       startPoint: .top,
                       endPoint: .bottom)
    }
}



