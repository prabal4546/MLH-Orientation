//
//  CanvasView.swift
//  OrientationHack
//
//  Created by Prabaljit Walia on 21/09/22.
//


import SwiftUI

struct Line {
    var points = [CGPoint]()
    var color: Color = .red
    var lineWidth: Double = 1.0
}

struct CanvasView: View {
    
    @State private var currentLine = Line()
        @State private var lines: [Line] = []
        @State private var thickness: Double = 1.0
    
    var body: some View {
        
        VStack{
            
            
            Text("Draw Your Achievement!")
                .font(Font.system(size: 40, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(

                        LinearGradient(
                            colors: [.purple, .blue, .green, .orange ,.red],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            
            
            
            
            Canvas {context, size in
                
                for line in lines {
                                    var path = Path()
                                    path.addLines(line.points)
                                    context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
                                }
                
            }
            .frame(width: 300, height: 400, alignment: .center)
            .border(.red)
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged({ value in
                    let newPoint = value.location
                    currentLine.points.append(newPoint)
                    self.lines.append(currentLine)
                  })
                .onEnded({ value in
                    self.lines.append(currentLine)
                    self.currentLine = Line(points: [], color: currentLine.color, lineWidth: thickness)
                })
                )
            
        }
        
    }
}

struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasView()
    }
}
