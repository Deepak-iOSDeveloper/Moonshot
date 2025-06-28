//
//  MissionView.swift
//  Moonshot
//
//  Created by Deepak Kumar Behera on 08/06/25.
//

import SwiftUI
struct CrewMember {
    var role: String
    var astronaut: Astronaut
}

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal) { width, axis in
                            width * 0.6
                        }
                        .padding(.top)
                    Text(mission.formattedLaunchDate)
                    VStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 2)
                            .foregroundStyle(.lightBackground)
                            .padding(.vertical)
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        Rectangle()
                            .frame(height: 2)
                            .foregroundStyle(.lightBackground)
                            .padding(.vertical)
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    CrewView(crew: crew)
                }
                .padding(.bottom)
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
        }
    }
}

#Preview {
    let mission: [Mission] = Bundle.main.decode("missions.json")
    let astronaut: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    MissionView(mission: mission[0], astronauts: astronaut)
        .preferredColorScheme(.dark)
}
