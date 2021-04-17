import Foundation
import Moya
import RxSwift

class RepositoryModel {
    
    private let disposeBag = DisposeBag()

    func getRepos(search: String, completion: @escaping (Repositories) -> Void) {
        
        GithubApi.shared.request(Github.GetRepositories(search: search))
            .subscribe(onSuccess: { repos in
                completion(repos)
            }, onError: { error in
                print("リポジトリーを取得できませんでした：" + error.localizedDescription)
            }).disposed(by: disposeBag)
        
    }
    
}

