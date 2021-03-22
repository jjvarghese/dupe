//
//  Grid.swift
//  Dupe
//
//  Created by Joshua James on 22.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import SwiftUI

struct Grid: View {
    @State var activeIndices: [Int]
    
    var body: some View {
        VStack {
            ForEach(0 ..< 4) { row in
                HStack {
                    ForEach(0 ..< 4) { section in
                        Square(index: IndexPath(row: row,
                                                section: section),
                               isActive: false)
                    }
                }
            }
        }
    }
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        Grid(activeIndices: [])
    }
}

struct Square: View {
    @State var index: IndexPath
    @State var isActive: Bool
    
    var body: some View {
        let color = isActive ? Color(UIColor.active) : Color(UIColor.base)
        
        Rectangle().fill(color).frame(width: 30,
                                      height: 30,
                                      alignment: .center)
    }
}
