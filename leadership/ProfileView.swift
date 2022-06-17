//
//  ProfileView.swift
//  leadership
//
//  Created by Harsha Srikara on 6/16/22.
//

import SwiftUI

struct ProfileView: View {
    
    var data: Link
    
    var body: some View {
        VStack {
            Text("\(data.name)")
                .font(.title2)
            .fontWeight(.bold)
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(data: DataManager.placeholderList[0])
    }
}
