import Foundation
import Moya
import RxSwift

protocol GithubApiTargetType: TargetType {
    associatedtype Response: Codable
}

extension GithubApiTargetType {
    
    var baseURL: URL { return URL(string: "https://api.github.com")! }
    
    var sampleData: Data {
        let path = Bundle.main.path(forResource: "samples", ofType: "json")!
        return FileHandle(forReadingAtPath: path)!.readDataToEndOfFile()
    }
    
    var headers: [String : String]? {
        nil
    }
    
}

enum Github {
    
    struct GetUserProfile: GithubApiTargetType {
        
        typealias Response = User
        
        var path: String { return "/users/\(name)" }
        
        var method: Moya.Method { return .get }
        
        var task: Task { return .requestPlain }
        
        let name: String
        
        init(name: String) {
            self.name = name
        }
        
    }
    
    struct GetRepositories: GithubApiTargetType {

        typealias Response = Repositories
        
        var path: String { return "/search/repositories" }
        
        var method: Moya.Method { return .get }
        
        var task: Task { return .requestParameters(parameters: ["q": search, "sort": "stars"], encoding: URLEncoding.queryString ) }
        
        let search: String
        
        init(search: String) {
            self.search = search
        }
        
    }
    
}

class GithubApi {
    // シングルトン
    static let shared = GithubApi()
    private let provider = MoyaProvider<MultiTarget>()
    
    func request<R>(_ request: R) -> Single<R.Response> where R: GithubApiTargetType {
        
        let target = MultiTarget(request)

//        provider.request(target) { result in
//            switch result {
//            case .success(let response):
//                do {
//                    let data = try response.mapJSON()
//                    print(data)
//                } catch {
//                    print("jsonのパースに失敗" + error.localizedDescription)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
        return provider.rx.request(target)
            .filterSuccessfulStatusCodes()
            .map(R.Response.self)
        
    }
        
}
