//
//  Boardview.swift
//  money
//
//  Created by Aman Kumar on 23/11/22.
//

import SwiftUI

struct Boardview: View {
    let rows:Int
    let columns:Int
    let originX:CGFloat = 30
    let originY:CGFloat = 70
    let cellSide:CGFloat = 40
    @State var ghotstPosition = (-1,-1)
    @State var policePosition = (-1,-1)
    @State var isButtonDisabled = false
    
    var body: some View {
        VStack {
            Grid(horizontalSpacing: 2, verticalSpacing: 2, content: {
                ForEach(0..<columns) { col in
                    GridRow {
                        ForEach(0..<rows) { row in
                            ColorSquare()
                                .overlay(getIcon(row: col, col: row))
                        }
                    }
                }
            })
            
            Button {
                changePositions()
            } label: {
                Text("Change Positions")
            }
            .disabled(isButtonDisabled)
            .buttonStyle(.borderedProminent)
            .padding(.top, 30)
        }.onAppear {
            changePositions()
        }
    }
    
    @ViewBuilder func getIcon(row:Int, col: Int) -> some View {
        if ghotstPosition.0 == row && ghotstPosition.1 == col {
            Text("👻")
        }
        
        if policePosition.0 == row && policePosition.1 == col {
            Text("👮")
        }
    }
    
    func changePositions() {
        isButtonDisabled.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            moveGhost()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                movePolice()
                isButtonDisabled.toggle()
            }
        }
    }
    
    func moveGhost() {
        if let newRowPos = (0..<rows).randomElement(), let newColPos = (0..<columns).randomElement() {
            ghotstPosition = (newRowPos, newColPos)
        }
    }
    
    func movePolice() {
        guard let newRowPos = (0..<rows).randomElement(), let newColPos = (0..<columns).randomElement() else { return }
        let newPos = (newRowPos, newColPos)
        if comapare(newPos, ghotstPosition) {
            movePolice()
        }
        else {
            policePosition = (newRowPos, newColPos)
        }
    }
    
    func comapare(_ lhs:(Int, Int), _ rhs: (Int, Int)) -> Bool {
        return lhs.0 == rhs.0 || lhs.1 == rhs.1
    }
}

struct ColorSquare: View {
    let color: Color = .gray
    
    var body: some View {
        color
        .frame(width: 50, height: 50)
    }
}

struct Boardview_Previews: PreviewProvider {
    static var previews: some View {
        Boardview(rows: 4, columns: 4)
    }
}
