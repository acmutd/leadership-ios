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
        VStack(spacing: 0) {
            Spacer()
            Text("\(minimumProfile.name)")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            
            List {

                Section(header: Text("Participants")) {
                    ForEach(data.participants, id: \.self) { participant in
                        HStack {
                            NavigationLink(participant.name, destination: MemberProfileView(minimumProfile: participant))
                        }
                    }
                }

                
                Section(header: Text("Officer")) {
                    HStack {
                        NavigationLink(data.officer.name, destination: OfficerProfileView(minimumProfile: data.officer))
                    }
                }
                
                Section(header: Text("Director")) {
                    ForEach(data.director, id: \.self) { director in
                        HStack {
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
