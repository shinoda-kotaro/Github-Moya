import Foundation
import Moya
import RxSwift

class UserModel {
    
    private let disposeBag = DisposeBag()
    
    func getUser(name: String, completion: @escaping (User) -> Void) {
        
        GithubApi.shared.request(Github.GetUserProfile(name: name))
            .subscribe(onSuccess: { user in
                completion(user)
            }, onError: { error in
                print("ユーザーを取得できませんでした：" + error.localizedDescription)
            }).disposed(by: disposeBag)
        
    }
    
}
