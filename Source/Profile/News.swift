//
//  News.swift
//  Navigation
//
//  Created by Арсений Корнилов on 16.03.2022.
//

import Foundation

struct News: Decodable {

    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMMM d, yyyy"
        df.locale = Locale(identifier: "en_EN")
        return df
    }()
    
    struct Article: Decodable {
        let author, title, description, publishedAt, likes, views, pic, id: String
    

        var publishedAtString: String {
            return News.dateFormatter.string(from: self.publishedAt.toDate() ?? Date())
        }

        enum CodingKeys: String, CodingKey {
            case author, title, description, publishedAt, likes, views, pic, id
        }
    }

    let articles: [Article]
}






extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
}
