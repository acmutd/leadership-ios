//
//  ContentView.swift
//  leadership
//
//  Created by Harsha Srikara on 6/15/22.
//

import SwiftUI
import FirebaseFirestore
import GoogleSignIn
import GoogleSignInSwift

struct ContentView: View {
    var SampleObject = DataManager()
    @State var DataObj = DataManager.placeholderList
    let signInConfig = GIDConfiguration(clientID: "INSERT-TOKEN-HERE")
    @State var signedIn: Bool = false
    @State var currentUser: GIDProfileData = GIDProfileData()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Explore ACM")) {
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
                
                if(!signedIn) {
                    Section(header: Text("Dive Deeper")) {
                        Button("Sign In With Google", action: handleSignInButton)
                    }
                } else {
                    Section(header: Text("Welcome \(currentUser.name)")) {
                        Button("Sign Out", action: signOut)
                    }
                }
            }
            .navigationTitle("ACM Leadership")
        }
        .onOpenURL { url in
            GIDSignIn.sharedInstance.handle(url)
        }
        .onAppear {
            GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                // Check if `user` exists; otherwise, do something with `error`
            }
        }
        Text("Designed by Harsha Srikara")
        .font(.footnote)
        .foregroundColor(.secondary)
        .frame(maxWidth: .infinity)
        .background(Color(.systemGroupedBackground))
    }
    
    func handleSignInButton() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            print("There is no root view controller!")
            return
        }
        
        GIDSignIn.sharedInstance.signIn(with: signInConfig,
                                        presenting: rootViewController) { user, error in
            guard let user = user else {
                print("Error! \(String(describing: error))")
                return
            }
            signedIn = true
            currentUser = user.profile!
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        signedIn = false
    }
}

struct OfficerView: View {
    var SampleObject = DataManager()
    @State var DataObj = DataManager.placeholderList
    @State private var searchText = ""
    
    var body: some View {
        List(searchResults, id: \.self) { officer in
            HStack {
                NavigationLink(officer.name, destination: OfficerProfileView(minimumProfile: officer))
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("Officers")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            self.DataObj = await SampleObject.getOfficers()
        }
    }
    
    var searchResults: [Link] {
        if searchText.isEmpty {
            return DataObj
        } else {
            return DataObj.filter { $0.name.contains(searchText) }
        }
    }
}

struct MemberView: View {
    var SampleObject = DataManager()
    @State var DataObj = DataManager.placeholderList
    @State private var searchText = ""
    
    var body: some View {
        List(searchResults, id: \.self) { member in
            HStack {
                NavigationLink(member.name, destination: MemberProfileView(minimumProfile: member))
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("Members")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            self.DataObj = await SampleObject.getMembers()
        }
    }
    
    var searchResults: [Link] {
            if searchText.isEmpty {
                return DataObj
            } else {
                return DataObj.filter { $0.name.contains(searchText) }
            }
        }
}

struct ProgramView: View {
    var SampleObject = DataManager()
    @State var DataObj = DataManager.placeholderList
    @State private var searchText = ""
    
    var body: some View {
        List(searchResults, id: \.self) { team in
            HStack {
                NavigationLink(team.name, destination: TeamProfileView(minimumProfile: team))
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("Programs")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            self.DataObj = await SampleObject.getPrograms()
        }
    }
    
    var searchResults: [Link] {
            if searchText.isEmpty {
                return DataObj
            } else {
                return DataObj.filter { $0.name.contains(searchText) }
            }
        }
}

struct EventsView: View {
    var SampleObject = DataManager()
    @State var DataObj = DataManager.placeholderList
    @State private var searchText = ""
    
    var body: some View {
        List(searchResults, id: \.self) { event in
            HStack {
                NavigationLink(event.name, destination: EventProfileView(minimumProfile: event))
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("Events")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            self.DataObj = await SampleObject.getEvents()
        }
    }
    
    var searchResults: [Link] {
            if searchText.isEmpty {
                return DataObj
            } else {
                return DataObj.filter { $0.name.contains(searchText) }
            }
        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
