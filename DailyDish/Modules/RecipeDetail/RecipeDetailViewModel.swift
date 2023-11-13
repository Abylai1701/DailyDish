import Foundation

protocol RecipeDetailViewModelLogic: AnyObject {
    func fetchRecipeDetail(id: Int)
    
    var randomRecipe: Observable<RecipeModel?> {get}
}

final class RecipeDetailViewModel: RecipeDetailViewModelLogic {
    
    //MARK: - Binding Values
    var randomRecipe: Observable<RecipeModel?> = Observable(nil)
    
    //MARK: - Functions
    
    internal func fetchRecipeDetail(id: Int) {
        Router.shared.showLoader()
        ParseManager.shared.getRequest(
            url: API.recipeDetail(id: id),
            parameters: [:]) {
                (result: RecipeModel?, error) in
                Router.shared.hideLoader()
                if let result = result {
                    self.randomRecipe.value = result
                }
            }
    }
}
