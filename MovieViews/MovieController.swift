//
//  MovieController.swift
//  MovieViews
//
//  Created by Scott Bolin on 10/20/20.
//

import Foundation

class MovieController {
    
    struct Movie: Hashable {
        let title: String
        let genre: String
        let year: Int // use Int for now, not date
        let identifier = UUID()
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
    
    struct MovieCollection: Hashable {
        let genre: String
        let movies: [Movie]
        let identifier = UUID()
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
    
    var collections: [MovieCollection] {
        return _collections
    }
    
    init() {
        generateCollecions() // hard coded for now...
    }
    fileprivate var _collections = [MovieCollection]()
}

extension MovieController {
    func generateCollecions() {
        _collections = [
            MovieCollection(genre: "The New iPad Pro",
                            movies: [Movie(title: "Bringing Your Apps to the New iPad Pro", genre: "Tech Talks", year: 2018),
                                     Movie(title: "Designing for iPad Pro and Apple Pencil", genre: "Tech Talks", year: 2019),
                                     Movie(title: "Desinging for Lidar on iPhone 12", genre: "Tech Talks", year: 2020)]),
            
            MovieCollection(genre: "iPhone and Apple Watch",
                            movies: [Movie(title: "Building Apps for iPhone XS, iPhone XS Max, and iPhone XR",
                                           genre: "Tech Talks", year: 2018),
                                     Movie(title: "Designing for Apple Watch Series 4",
                                           genre: "Tech Talks", year: 2018),
                                     Movie(title: "Developing Complications for Apple Watch Series 4",
                                           genre: "Tech Talks", year: 2018),
                                     Movie(title: "What's New in Core NFC",
                                           genre: "Tech Talks", year: 2018)]),
            
            MovieCollection(genre: "App Store Connect",
                            movies: [Movie(title: "App Store Connect Basics", genre: "App Store Connect", year: 2017),
                                     Movie(title: "App Analytics Retention", genre: "App Store Connect", year: 2018),
                                     Movie(title: "App Analytics Metrics", genre: "App Store Connect", year: 2019),
                                     Movie(title: "App Analytics Overview", genre: "App Store Connect", year: 2020),
                                     Movie(title: "TestFlight", genre: "App Store Connect", year: 2020)]),
            
            MovieCollection(genre: "Apps on Your Wrist",
                            movies: [Movie(title: "What's new in watchOS", genre: "Conference 2018", year: 2018),
                                     Movie(title: "Updating for Apple Watch Series 3", genre: "Tech Talks", year: 2018),
                                     Movie(title: "Planning a Great Apple Watch Experience",
                                           genre: "Conference 2017", year: 2017),
                                     Movie(title: "News Ways to Work with Workouts", genre: "Conference 2018", year: 2018),
                                     Movie(title: "Siri Shortcuts on the Siri Watch Face",
                                           genre: "Conference 2018", year: 2018),
                                     Movie(title: "Creating Audio Apps for watchOS", genre: "Conference 2018", year: 2018),
                                     Movie(title: "Designing Notifications", genre: "Conference 2018", year: 2018)]),
            
            MovieCollection(genre: "Speaking with Siri",
                            movies: [Movie(title: "Introduction to Siri Shortcuts", genre: "Conference 2018", year: 2018),
                                     Movie(title: "Building for Voice with Siri Shortcuts",
                                           genre: "Conference 2018", year: 2018),
                                     Movie(title: "What's New in SiriKit", genre: "Conference 2017", year: 2017),
                                     Movie(title: "Making Great SiriKit Experiences", genre: "Conference 2017", year: 2017),
                                     Movie(title: "Increase Usage of You App With Proactive Suggestions",
                                           genre: "Conference 2018", year: 2018)])
        ]
    }
}
