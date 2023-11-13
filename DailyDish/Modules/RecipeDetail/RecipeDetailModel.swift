import Foundation

struct RecipeModel: Codable {
    let name, description: String
    let image: String
    let tags: [String]
    let minutes: Int
    let ingredients, steps: [String]
}
