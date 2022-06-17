//
//  ContentView.swift
//  leadership
//
//  Created by Harsha Srikara on 6/15/22.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    var SampleObject = DataManager()
    @State var DataObj = DataManager.placeholderList
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Image(systemName: "star.fill")
                    NavigationLink("Leadership", destination: OfficerView())
                }
                HStack {
                    Image(systemName: "person.fill")
                    NavigationLink("Membership", destination: MemberView())
                }
                HStack {
                    Image(systemName: "person.3.fill")
                    NavigationLink("Programs", destination: ProgramView())
                }
                HStack {
                    Image(systemName: "flag.fill")
                    NavigationLink("Events", destination: EventsView())
                }
            }
            .navigationTitle("ACM Leadership")
        }
    }
}

struct OfficerView: View {
    var SampleObject = DataManager()
    @State var DataObj = DataManager.placeholderList
    
    var body: some View {
        List(DataObj, id: \.self) { officer in
            HStack {
                NavigationLink(officer.name, destination: OfficerProfileView(minimumProfile: officer))
            }
        }
        .navigationTitle("Officers")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            self.DataObj = await SampleObject.getOfficers()
        }
    }
}

struct MemberView: View {
    var SampleObject = DataManager()
    @State var DataObj = DataManager.placeholderList
    
    var body: some View {
        List(DataObj, id: \.self) { member in
            HStack {
                NavigationLink(member.name, destination: MemberProfileView(minimumProfile: member))
            }
        }
        .navigationTitle("Members")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            self.DataObj = await SampleObject.getMembers()
        }
    }
}

struct ProgramView: View {
    var SampleObject = DataManager()
    @State var DataObj = DataManager.placeholderList
    
    var body: some View {
        List(DataObj, id: \.self) { team in
            HStack {
                NavigationLink(team.name, destination: TeamProfileView(minimumProfile: team))
            }
        }
        .navigationTitle("Programs")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            self.DataObj = await SampleObject.getPrograms()
        }
    }
}

struct EventsView: View {
    var SampleObject = DataManager()
    @State var DataObj = DataManager.placeholderList
    
    var body: some View {
        List(DataObj, id: \.self) { event in
            HStack {
                NavigationLink(event.name, destination: EventProfileView(minimumProfile: event))
            }
        }
        .navigationTitle("Events")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            self.DataObj = await SampleObject.getEvents()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
