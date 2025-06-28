//
//  AstronautView.swift
//  Moonshot
//
//  Created by Deepak Kumar Behera on 08/06/25.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                    
                    Text(astronaut.description)
                        .padding()
                }
            }
            .background(.darkBackground)
            .navigationTitle(astronaut.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    let astronaut: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    AstronautView(astronaut: astronaut["aldrin"]!)
        .preferredColorScheme(.dark)
}
