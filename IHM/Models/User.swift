import Foundation

/// Represents a club member's profile.
struct User: Codable, Identifiable, Equatable {
    var id: String
    var nickname: String
    var name: String
    var surname: String
    var city: String
    var country: String

    enum CodingKeys: String, CodingKey {
        case id
        case nickname
        case name
        case surname
        case city
        case country
    }
}
