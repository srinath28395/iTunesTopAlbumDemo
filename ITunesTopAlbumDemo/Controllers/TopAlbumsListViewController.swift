//
//  TopAlbumsListViewController.swift
//  TopAlbums
//
//  Created by Chanappa on 21/10/19.
//

import UIKit

class TopAlbumsListViewController: UITableViewController {

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .gray)
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    var albumListArray = [Results]()
    let albumCellHeigh:CGFloat = 70
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.register(TopAlbumCell.self, forCellReuseIdentifier: TopAlbumCell.self.description())
        getTop100AlbumList()
        self.title = "Top Albums"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumListArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopAlbumCell.self.description(), for: indexPath) as? TopAlbumCell else {
            return UITableViewCell()
        }
        
        cell.albumData = albumListArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }

    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return albumCellHeigh
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let albumName = albumListArray[indexPath.row].name, let artistName = albumListArray[indexPath.row].artistName else {return .zero}
        
        let albumTextheight = albumName.height(withConstrainedWidth: tableView.frame.size.width - 88, font: UIFont.boldSystemFont(ofSize: 18))
        let artistTextHeight = artistName.height(withConstrainedWidth: tableView.frame.size.width - 88, font: UIFont.systemFont(ofSize: 16))
        let padding: CGFloat = 36
        
        let totalHeight = albumTextheight + artistTextHeight + padding
        
        return totalHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentAlbum = albumListArray[indexPath.row]
        let detailController = AlbumDetailViewController()
        detailController.albumData = currentAlbum
        navigationController?.pushViewController(detailController, animated: true)
    }
    
}

private extension TopAlbumsListViewController {
    
    func showLoader() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0)
            ])
    }
    
    func hideLoader() {
        activityIndicator.removeFromSuperview()
    }
    
    func manageSuccessResponse(withResultModel results: [Results]) {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.albumListArray.removeAll()
            weakSelf.albumListArray = results
            weakSelf.tableView.reloadData()
        }
    }
    
    func getTop100AlbumList() {
        
        showLoader()
        let baseURL = NetworkManager.sharedInstance.baseURl
        let endPoint = NetworkManager.EndPoints.topAlbums(100).value()
        let strURL = baseURL + endPoint
        let httpMethod = NetworkManager.HttpMethod.get
    
        guard let url = URL(string: strURL) else { return }
        
        NetworkManager.sharedInstance.callWebservice(withUrl: url, httpMethod: httpMethod, parameters: nil, header: nil) { [weak self] (data, response, error) in
            
            guard let weakSelf = self else { return }
            
            DispatchQueue.main.async {
                weakSelf.hideLoader()
            }
            
            if let err = error {
                Alert.showNormalAlertWith(message: err.localizedDescription)
            }
            
            if let data = data, let httpResponse = response as? HTTPURLResponse, !data.isEmpty, httpResponse.statusCode == 200 {
                
                guard
                    let json = try? JSONSerialization.jsonObject(with: data, options:[]),
                    let jsonDictionary = json as? [String:Any],
                    let feed = jsonDictionary["feed"] as? [String:Any],
                    let feedData = try? JSONSerialization.data(withJSONObject: feed, options: .prettyPrinted),
                    let feedModel = try? JSONDecoder().decode(Feed.self
                        , from: feedData),
                    let resultAry = feedModel.results
                else {
                    return
                }
                
                weakSelf.manageSuccessResponse(withResultModel: resultAry)
                
            }
            
        }
    }
}
