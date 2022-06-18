//
//  TeamProfileView.swift
//  leadership
//
//  Created by Harsha Srikara on 6/17/22.
//

import SwiftUI

struct TeamProfileView: View {
    
    var minimumProfile: Link
    var SampleObject = DataManager()
    @State var data: FullTeam = DataManager.placeholderTeam
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(minimumProfile.name)")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            
            List {

                Section(header: Text("Participants")) {
                    ForEach(data.participants, id: \.self) { participant in
                        HStack {
                            Image(systemName: "person.fill")
                            NavigationLink(participant.name, destination: MemberProfileView(minimumProfile: participant))
                        }
                    }
                }

                
                Section(header: Text("Officer")) {
                    HStack {
                        Image(systemName: "star.fill")
                        NavigationLink(data.officer.name, destination: OfficerProfileView(minimumProfile: data.officer))
                    }
                }
                
                Section(header: Text("Director")) {
                    ForEach(data.director, id: \.self) { director in
                        HStack {
                            Image(systemName: "star.fill")
                            NavigationLink(director.name, destination: OfficerProfileView(minimumProfile: director))
                        }
                    }
                }
                
            }
        }
        .task {
            self.data = await SampleObject.getTeam(id: minimumProfile.id)
        }
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamProfileView(minimumProfile: DataManager.placeholderList[0])
    }
}
