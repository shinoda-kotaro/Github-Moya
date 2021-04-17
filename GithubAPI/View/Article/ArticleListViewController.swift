import UIKit
import RxSwift
import RxCocoa
import RxRelay
import SafariServices

class ArticleListViewController: UIViewController {
    
    @IBOutlet weak var articleListTableView: UITableView!
    
    private var searchController: UISearchController!
    private var searchText: String!
    
    private let viewModel = ArticleListViewModel()
    
    private let disposeBag = DisposeBag()
    
    private var repos = [Repository]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        setBinding()
        setSearchController()
    }
    
    // サーチバーの設定
    private func setSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
//        searchController.delegate = self
        navigationItem.searchController = searchController
    }
    
    // テーブルビューの設定
    private func setTableView() {
        articleListTableView.delegate = self
        articleListTableView.dataSource = self
        articleListTableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        // cell タップ時
        articleListTableView.rx.itemSelected.subscribe(onNext: { [unowned self] indexPath in
            let safariVC = SFSafariViewController(url: NSURL(string: repos[indexPath.row].htmlUrl)! as URL)
            safariVC.modalPresentationStyle = .pageSheet
            present(safariVC, animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
    
    // バインディングの設定
    private func setBinding() {
        viewModel.userState.subscribe(onNext: { user in
            print(user.login)
        }).disposed(by: disposeBag)
        
        viewModel.repoState.subscribe(onNext: { repos in
            self.repos = repos.items
            DispatchQueue.main.async {
                self.articleListTableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
    
}


extension ArticleListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = repos[indexPath.row].name
        return cell
    }
    
}

extension ArticleListViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate{
    // 検索バーの文字が変更されるたびに呼び出される
    func updateSearchResults(for searchController: UISearchController) {
        self.searchText = searchController.searchBar.text
    }
    
    // 検索ボタンが押された時に発火
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !searchText.isEmpty {
            viewModel.getRepo(search: searchText)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // 編集終了時に(キーボードがしまわれた時)処理
    }
    
}
