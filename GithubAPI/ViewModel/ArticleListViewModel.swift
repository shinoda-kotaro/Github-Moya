import Foundation
import RxSwift
import RxRelay

class ArticleListViewModel {
    
    let userState = PublishRelay<User>()
    let repoState = PublishRelay<Repositories>()
    
    private let userModel = UserModel()
    private let repoModel = RepositoryModel()
    
    func getUser(name: String) {
        userModel.getUser(name: name) { user in
            self.userState.accept(user)
        }
    }
    
    func getRepo(search: String) {
        repoModel.getRepos(search: search) { repos in
            self.repoState.accept(repos)
        }
    }
    
}
