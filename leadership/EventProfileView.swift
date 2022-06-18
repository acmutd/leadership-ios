//
//  EventProfileView.swift
//  leadership
//
//  Created by Harsha Srikara on 6/17/22.
//

import SwiftUI

struct EventProfileView: View {
    
    var minimumProfile: Link
    var SampleObject = DataManager()
    @State var data: FullEvent = DataManager.placeholderEvent
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(minimumProfile.name)")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom)
            HStack {
                if (data.date_start == data.date_end) {
                    Text("\(data.date_start)")
                } else {
                    Text("\(data.date_start) to \(data.date_end)")
                }
            }
            Spacer()
            
            List {
                Section(header: Text("Team")) {
                    ForEach(data.team, id: \.self) { officer in
                        HStack {
                            Image(systemName: "person.fill")
                            NavigationLink(officer.name, destination: OfficerProfileView(minimumProfile: officer))
                        }
                    }
                }
                Section(header: Text("Director")) {
                    HStack {
                        Image(systemName: "star.fill")
                        NavigationLink(data.director.name, destination: OfficerProfileView(minimumProfile: data.director))
                    }
                }
            }
        }
        .task {
            self.data = await SampleObject.getEvent(id: minimumProfile.id)
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventProfileView(minimumProfile: DataManager.placeholderList[0])
    }
}
