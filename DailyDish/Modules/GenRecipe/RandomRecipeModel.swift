import Foundation


struct RandomRecipe: Codable {
    let id: Int
    let name, description: String
    let image: String
}
