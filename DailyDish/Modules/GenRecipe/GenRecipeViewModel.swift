import Foundation

protocol GenRecipeViewModelLogic: AnyObject {
    func fetchRandomRecipe()
    
    var randomRecipe: Observable<RandomRecipe?> {get}
}

final class GenRecipeViewModel: GenRecipeViewModelLogic {
    
    //MARK: - Binding Values
    var randomRecipe: Observable<RandomRecipe?> = Observable(nil)
    
    //MARK: - Functions
    
    internal func fetchRandomRecipe() {
        ParseManager.shared.getRequest(
            url: API.genRecipe,
            parameters: [:]) {
                (result: RandomRecipe?, error) in
                Router.shared.hideLoader()
                if let result = result {
                    self.randomRecipe.value = result
                }
            }
    }
}
