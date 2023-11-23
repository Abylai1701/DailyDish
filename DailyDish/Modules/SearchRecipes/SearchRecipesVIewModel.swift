import Foundation

protocol SearchRecipesVIewModelLogic: AnyObject {
    func fetchRecipes(recipe: String)
    
    var recipes: Observable<[RandomRecipe]> {get}
}

final class SearchRecipesVIewModel: SearchRecipesVIewModelLogic {
    
    //MARK: - Binding Values
    var recipes: Observable<[RandomRecipe]> = Observable([])

    //MARK: - Functions
    
    internal func fetchRecipes(recipe: String) -> Void {
        let parameters: Parameters = ["search": recipe]
        
        ParseManager.shared.getRequest(
            url: API.search,
            parameters: parameters) {
                (result: [RandomRecipe]?, error) in
                if let result = result {
                    self.recipes.value = result
                }
            }
    }
}
