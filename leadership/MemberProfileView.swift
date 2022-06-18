//
//  MemberProfileView.swift
//  leadership
//
//  Created by Harsha Srikara on 6/17/22.
//

import SwiftUI

struct MemberProfileView: View {
    
    var minimumProfile: Link
    var SampleObject = DataManager()
    @State var data: FullMember = DataManager.placeholderMember
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(minimumProfile.name)")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom)
            Spacer()
            
            List {
                if data.teams.count > 0 {
                    Section(header: Text("Teams")) {
                        ForEach(data.teams, id: \.self) { team in
                            HStack {
                                NavigationLink(team.name, destination: TeamProfileView(minimumProfile: team))
                            }
                        }
                    }
                }
            }
        }
        .task {
            self.data = await SampleObject.getMember(id: minimumProfile.id)
        }
    }
}

struct MemberView_Previews: PreviewProvider {
    static var previews: some View {
        MemberProfileView(minimumProfile: DataManager.placeholderList[0])
    }
}
