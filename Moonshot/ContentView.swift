//
//  ContentView.swift
//  Moonshot
//
//  Created by Deepak Kumar Behera on 06/06/25.
//

import SwiftUI

struct ContentView: View {
    let astronaut: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    var columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    @State private var toggle: Bool = false
    var body: some View {
        if !toggle {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(missions) { mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astronaut)
                            } label: {
                                VStack {
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding()
                                    
                                    VStack {
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundStyle(.white)
                                        Text(mission.formattedLaunchDate)
                                            .font(.caption)
                                            .foregroundStyle(.white.opacity(0.7))
                                    }
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .background(.lightBackground)
                                }
                            }
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                .background(.darkBackground)
                .preferredColorScheme(.dark)
                .navigationTitle("Moonshot")
                .toolbar {
                    Toggle(toggle ? "Change to Grid View" : "Change to List View", isOn: $toggle)
                }
            }
        } else {
            NavigationStack {
                VStack {
                    List(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronaut)
                        } label: {
                            HStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:75, height: 75)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 5)
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.7))
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .cornerRadius(20)
                            .background(.lightBackground)
                        }
                    }
                    .listStyle(.inset)
                }
                .background(.darkBackground)
                .preferredColorScheme(.dark)
                .navigationTitle("Moonshot")
                .toolbar {
                    Toggle(toggle ? "Change to Grid View" : "Change to List View", isOn: $toggle)
                }
            }
        }
    }
}
struct Astronaut: Identifiable, Codable {
    var id: String
    var name: String
    var description: String
}
struct Mission: Identifiable, Codable {
    var id: Int
    var displayName: String {
        "Apollo \(id)"
    }
    var image: String {
        "apollo\(id)"
    }
    var launchDate: Date?
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    var crew: [CrewRole]
    struct CrewRole: Codable {
        var name: String
        var role: String
    }
    var description: String
}
#Preview {
    ContentView()
}
