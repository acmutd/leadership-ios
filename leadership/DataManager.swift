//
//  SampleData.swift
//  leadership
//
//  Created by Harsha Srikara on 6/16/22.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Link: Hashable {
    var id: String
    var name: String
}

struct FullOfficer: Hashable {
    var id: String
    var name: String
    var email: String
    var start: String
    var end: String
    var acm_email: String
    var linkedin: String
    var role_list: [String]
    var accolades: [String]
    var teams: [Link]
    var events: [Link]
}

struct FullMember: Hashable {
    var id: String
    var name: String
    var email: [String]
    var netid: String
    var classification: String
    var major: String
    var participation: [String]
    var teams: [Link]
}

struct FullTeam: Hashable {
    var id: String
    var name: String
    var participants: [Link]
    var officer: Link
    var director: [Link]
    var tags: [String]
}

struct FullEvent: Hashable {
    var id: String
    var name: String
    var date_start: String
    var date_end: String
    var team: [Link]
    var director: Link
    var filter: [String]
}

class DataManager: NSObject {
    
    var db: Firestore!
    static let placeholderOfficer = FullOfficer(id: "hCIvRwwOqqptxkQbHjBp", name: "Harsha Srikara", email: "harshasrikara@gmail.com", start: "09 Apr, 2019", end: "May 31, 2022", acm_email: "harsha.srikara@acmutd.co", linkedin: "https://linkedin.com/in/harshasrikara", role_list: ["HackUTD Experience Officer", "HackUTD Technical Lead", "Director of Development", "Strategic Advisor"], accolades: ["Congratulations"], teams: [], events: [])
    static let placeholderMember = FullMember(id: "5aTBO9QPtGNGdyMK3rPD", name: "Jafar Ali", email: [], netid: "jaa190000", classification: "Freshman", major: "Computer Science", participation: ["Projects", "Projects F19"], teams: [])
    static let placeholderTeam = FullTeam(id: "yGRXQVdfGmVHxonxTyvJ", name: "HashPost", participants: [], officer: Link(id: "hCIvRwwOqqptxkQbHjBp", name: "Harsha Srikara"), director: [], tags: ["Projects"])
    static let placeholderEvent = FullEvent(id: "UDjOvVIjZcKVktrABWVv", name: "Hacktoberfest", date_start: "17 Oct, 2020", date_end: "17 Oct, 2020", team: [], director: Link(id: "hCIvRwwOqqptxkQbHjBp", name: "Harsha Srikara"), filter: ["hackathon"])
    static let placeholderList: [Link] = [
        Link(id: "hCIvRwwOqqptxkQbHjBp", name: "Harsha Srikara"),
    ]
    
    var firebaseData: [Link]!
    
    override init() {
        super.init()
        
        // setup
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    
    func getOfficers() async -> [Link] {
        let docRef = db.collection("total").document("allinone")
        
        var result: [Link] = []
        
        do {
            let document = try await docRef.getDocument()
            let dataDescription = document.data()
            
            for officer in (dataDescription?["officers"] as! [[String: Any]]) {
                result.append(Link(id: officer["id"] as! String, name: officer["name"] as! String))
            }
        } catch {
            print("Oops")
        }
        
        return result
    }
    
    func getOfficer(id: String) async -> FullOfficer {
        let docRef = db.collection("officer").document(id)
        let dateF = DateFormatter()
        dateF.dateStyle = .medium

        var name: String = ""
        var email: String = ""
        var acm_email: String = ""
        var start: String = ""
        var end: String = ""
        var linkedin: String = ""
        var role_list: [String] = []
        var accolades: [String] = []
        var teams: [Link] = []
        var events: [Link] = []
        
        
        do {
            let document = try await docRef.getDocument()
            let dataDescription = document.data()
            
            name = dataDescription?["name"] as! String
            email = dataDescription?["email"] as? String ?? "test@email.com"
            acm_email = dataDescription?["acm_email"] as! String
            start = dateF.string(from: (dataDescription?["start"] as AnyObject).dateValue())
            end = dateF.string(from: (dataDescription?["end"] as AnyObject).dateValue())
            linkedin = dataDescription?["linkedin"] as! String
            role_list = dataDescription?["role_list"] as! [String]
            accolades = dataDescription?["accolades"] as? [String] ?? []
            
            for team in (dataDescription?["teams"] as? [[String: Any]] ?? []) {
                teams.append(Link(id: team["id"] as! String, name: team["name"] as! String))
            }
            
            for event in (dataDescription?["events"] as? [[String: Any]] ?? []) {
                events.append(Link(id: event["id"] as! String, name: event["name"] as! String))
            }
            
        } catch {
            print("Oops")
        }
        
        if (end == "Jun 19, 2021") {
            end = "Present"
        }
        
        return FullOfficer(id: id, name: name, email: email, start: start, end: end, acm_email: acm_email, linkedin: linkedin, role_list: role_list, accolades: accolades, teams: teams, events: events)
    }
    
    func getMember(id: String) async -> FullMember {
        let docRef = db.collection("participants").document(id)

        var name: String = ""
        var email: [String] = []
        var netid: String = ""
        var classification: String = ""
        var major: String = ""
        var participation: [String] = []
        var teams: [Link] = []
        
        
        do {
            let document = try await docRef.getDocument()
            let dataDescription = document.data()
            
            name = dataDescription?["name"] as! String
            email = dataDescription?["email"] as? [String] ?? []
            netid = dataDescription?["netid"] as! String
            classification = dataDescription?["classification"] as! String
            major = dataDescription?["major"] as! String
            participation = dataDescription?["email"] as! [String]
            

            for team in (dataDescription?["teams"] as? [[String: Any]] ?? []) {
                teams.append(Link(id: team["id"] as! String, name: team["name"] as! String))
            }
            
        } catch {
            print("Oops")
        }
        
        return FullMember(id: id, name: name, email: email, netid: netid, classification: classification, major: major, participation: participation, teams: teams)
    }
    
    func getTeam(id: String) async -> FullTeam {
        let docRef = db.collection("teams").document(id)

        var name: String = ""
        var tags: [String] = []
        var officer: Link = Link(id: "hCIvRwwOqqptxkQbHjBp", name: "Harsha Srikara")
        var participants: [Link] = []
        var directors: [Link] = []
        
        do {
            let document = try await docRef.getDocument()
            let dataDescription = document.data()
            
            name = dataDescription?["name"] as! String
            tags = dataDescription?["tags"] as! [String]
            for participant in (dataDescription?["participants"] as? [[String: Any]] ?? []) {
                participants.append(Link(id: participant["id"] as! String, name: participant["name"] as! String))
            }
            
            for director in (dataDescription?["director"] as? [[String: Any]] ?? []) {
                directors.append(Link(id: director["id"] as! String, name: director["name"] as! String))
            }
            
            officer = Link(id: (dataDescription?["officer"] as? [String: Any])?["id"] as! String, name: (dataDescription?["officer"] as? [String: Any])?["name"] as! String)
            
        } catch {
            print("Oops")
        }
        
        return FullTeam(id: id, name: name, participants: participants, officer: officer, director: directors, tags: tags)
    }
    
    func getEvent(id: String) async -> FullEvent {
        let docRef = db.collection("event_leadership").document(id)
        let dateF = DateFormatter()
        dateF.dateStyle = .medium

        var name: String = ""
        var date_start: String = ""
        var date_end: String = ""
        var team: [Link] = []
        var director: Link = Link(id: "hCIvRwwOqqptxkQbHjBp", name: "Harsha Srikara")
        var filter: [String] = []
        
        
        do {
            let document = try await docRef.getDocument()
            let dataDescription = document.data()
            
            name = dataDescription?["name"] as! String
            date_start = dateF.string(from: (dataDescription?["date_start"] as AnyObject).dateValue())
            date_end = dateF.string(from: (dataDescription?["date_end"] as AnyObject).dateValue())
            filter = dataDescription?["filter"] as! [String]
            for officer in (dataDescription?["team"] as? [[String: Any]] ?? []) {
                team.append(Link(id: officer["id"] as! String, name: officer["name"] as! String))
            }
            
            director = Link(id: (dataDescription?["director"] as? [String: Any])?["id"] as! String, name: (dataDescription?["director"] as? [String: Any])?["name"] as! String)
            
        } catch {
            print("Oops")
        }
        
        return FullEvent(id: id, name: name, date_start: date_start, date_end: date_end, team: team, director: director, filter: filter)
    }
    
    func getMembers() async -> [Link] {
        let docRef = db.collection("total").document("participants")
        
        var result: [Link] = []
        
        do {
            let document = try await docRef.getDocument()
            let dataDescription = document.data()
            
            for officer in (dataDescription?["participants"] as! [[String: Any]]) {
                result.append(Link(id: officer["id"] as! String, name: officer["name"] as! String))
            }
        } catch {
            print("Oops")
        }
        
        return result
    }
    
    func getPrograms() async -> [Link] {
        let docRef = db.collection("total").document("teams")
        
        var result: [Link] = []
        
        do {
            let document = try await docRef.getDocument()
            let dataDescription = document.data()
            
            for officer in (dataDescription?["teams"] as! [[String: Any]]) {
                result.append(Link(id: officer["id"] as! String, name: officer["name"] as! String))
            }
        } catch {
            print("Oops")
        }
        
        return result
    }
    
    func getEvents() async -> [Link] {
        let docRef = db.collection("total").document("events_leadership")
        
        var result: [Link] = []
        
        do {
            let document = try await docRef.getDocument()
            let dataDescription = document.data()
            
            for officer in (dataDescription?["events"] as! [[String: Any]]) {
                result.append(Link(id: officer["id"] as! String, name: officer["name"] as! String))
            }
        } catch {
            print("Oops")
        }
        
        return result
    }
}
