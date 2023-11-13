import Foundation

enum API {
    //MARK: - URLs
    static let prodURL              = "http://46.101.199.49"
    
 
    static let genRecipe               = "recipe/random"
    static let search                  = "recipe/search"

    static func recipeDetail
    (id: Int) -> String {             "recipe/\(id)" }
}
