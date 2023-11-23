import UIKit

final class GenerationAnimationVC: UIViewController {
    
    //MARK: - Properties
    private let viewModel: GenRecipeViewModelLogic = GenRecipeViewModel()
    
    private var recipeModel: RandomRecipe? = nil
    
    private lazy var genBackButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "back_icon"), for: .normal)
        button.layer.masksToBounds = false
        button.addTarget(self,
                         action: #selector(goToMain),
                         for: .touchUpInside)
        
        return button
    }()
    lazy var genBackTitle: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 14)
        label.text = "Back"
        label.textColor = .black
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToMain))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    lazy var mainImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "pizza")
        image.contentMode = .scaleAspectFit
        return image
    }()
    lazy var generatingTitle: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 20)
        label.text = "Generating..."
        label.textColor = .black
        return label
    }()
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchRandomRecipe()
        genBind()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }
    func genBind() {
        viewModel.randomRecipe.observe(on: self) { [weak self] recipe in
            guard let self = self else {return}
            self.recipeModel = recipe
        }
    }
    //MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubviews(genBackButton,
                         genBackTitle,
                         mainImage,
                         generatingTitle)
        
        genBackButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(65)
        }
        genBackTitle.snp.makeConstraints { make in
            make.left.equalTo(genBackButton.snp.right)
            make.top.equalToSuperview().offset(68)
        }
        mainImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(genBackTitle.snp.bottom).offset(150)
            make.width.equalTo(78)
            make.height.equalTo(85)
        }
        generatingTitle.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    private func navigateToNextController() {
        let vc = RecipeDetailVC(id: recipeModel?.id ?? 667, backToMain: true)
        Router.shared.push(vc)
    }
    private func startAnimation() {
        let animationDistance: CGFloat = 10

        UIView.animate(withDuration: 1.0, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.mainImage.frame.origin.y += animationDistance
        }, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return }
            self.navigateToNextController()
        }
    }
    @objc
    private func goToMain() {
        Router.shared.pop()
    }
}
