//
//  ArticleListViewController.swift
//  GithubAPI
//
//  Created by 信田　虎太郎 on 2021/04/17.
//

import UIKit

class ArticleListViewController: UIViewController  {
    
    @IBOutlet weak var articleListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setTableView()
    }
    
    private func setTableView() {
        articleListTableView.delegate = self
        articleListTableView.dataSource = self
        articleListTableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

}


extension ArticleListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "タイトル"
        return cell
    }
    
}
