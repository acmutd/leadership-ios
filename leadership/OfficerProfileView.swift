//
//  OfficerProfileView.swift
//  leadership
//
//  Created by Harsha Srikara on 6/17/22.
//

import SwiftUI

struct OfficerProfileView: View {
    
    var minimumProfile: Link
    var SampleObject = DataManager()
    @State var data: FullOfficer = DataManager.placeholderOfficer
    @State var accoladeText = ""
    @State private var alert: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(minimumProfile.name)")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom)
            HStack {
                Text("\(data.start) to \(data.end)")
            }
            Spacer()
            
            List {
                Section(header: Text("Roles")) {
                    ForEach(data.role_list, id: \.self) { role in
                        Text(role)
                    }
                }
                
                if data.teams.count > 0 {
                    Section(header: Text("Teams")) {
                        ForEach(data.teams, id: \.self) { team in
                            HStack {
                                NavigationLink(team.name, destination: TeamProfileView(minimumProfile: team))
                            }
                        }
                    }
                }
                
                if data.events.count > 0 {
                    Section(header: Text("Events")) {
                        ForEach(data.events, id: \.self) { event in
                            HStack {
                                NavigationLink(event.name, destination: EventProfileView(minimumProfile: event))
                            }
                        }
                    }
                }
                
                if data.accolades.count > 0 {
                    Section(header: Text("Accolades")) {
                        ForEach(data.accolades, id: \.self) { accolade in
                            Text(accolade)
                        }
                    }
                }
                
                if data.end == "Present" {
                    Section(header: Text("Give an Accolade")) {
                        TextField("Congratulations", text: $accoladeText)
                        Button("Send Accolade", action: submitAccolade)
                            .alert(isPresented: $alert) {
                                Alert(title: Text("Yay, you've sent an accolade!"), message: Text("Note: This feature has not yet been implemented"))
                            }
                    }
                }
                
            }
        }
        .task {
            self.data = await SampleObject.getOfficer(id: minimumProfile.id)
        }
    }
    
    func submitAccolade() -> Void {
        print(accoladeText)
        accoladeText = ""
        alert = true
    }
}

struct OfficerView_Previews: PreviewProvider {
    static var previews: some View {
        OfficerProfileView(minimumProfile: DataManager.placeholderList[0])
    }
}
