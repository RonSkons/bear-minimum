//
//  BearImageCircle.swift
//  BearMinimum
//
//  Created by Ron Friedman on 2022-12-22.
//

import SwiftUI

struct BearImageCircle: View {
    var body: some View {
        Image("Bear")
            .resizable().frame(width: 100, height: 100)
            .clipShape(Circle())
            .shadow(radius: 7)
    }
}

struct BearImageCircle_Previews: PreviewProvider {
    static var previews: some View {
        BearImageCircle()
    }
}
