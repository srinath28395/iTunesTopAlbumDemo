//
//  AlbumDetailViewController.swift
//  TopAlbums
//
//  Created by Shreenath on 05/07/20.
//

import UIKit

class AlbumDetailViewController: UIViewController {

    let customBlueColor = UIColor(red: 56/255, green: 125/255, blue: 204/255, alpha: 1)
    
    lazy var largeAlbumArtwork: AsyncDownloadingImageView = {
        let img = AsyncDownloadingImageView()
        img.image = nil
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        img.addShadow()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var albumTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = nil
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var artistNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = nil
        lbl.textColor = customBlueColor
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var genereDetailTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = nil
        lbl.textColor = .lightGray
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var copyRightDetailTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = nil
        lbl.textColor = .lightGray
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .light)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var releaseDateTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = nil
        lbl.textColor = .lightGray
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .light)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var viewAlbumButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = customBlueColor
        btn.setTitle("View Album", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 9
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let largeArtworkSize:CGFloat = 200
    
    var albumData:Results?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        dispayData()
    }

}

private extension AlbumDetailViewController {
    func dispayData() {
        guard
            let data = albumData,
            let strURL = data.artworkUrl100,
            let albumTitle = data.name,
            let artistName = data.artistName,
            let generes = data.genres,
            let releaseDate = data.releaseDate,
            let copyright = data.copyright
        else {return}
        largeAlbumArtwork.loadImage(withImageURL: strURL)
        albumTitleLabel.text = albumTitle
        artistNameLabel.text = artistName
        genereDetailTitleLabel.text = generes.map({ (genere) -> String in
            guard let name = genere.name else {return ""}
            return name
        }).joined(separator: ", ")
        releaseDateTitle.text = "RELEASED " + releaseDate
        copyRightDetailTitleLabel.text = copyright
    }
    
    func setupUI() {
        
        view.backgroundColor = .white
        view.addSubview(largeAlbumArtwork)
        view.addSubview(albumTitleLabel)
        view.addSubview(artistNameLabel)
        view.addSubview(genereDetailTitleLabel)
        view.addSubview(copyRightDetailTitleLabel)
        view.addSubview(releaseDateTitle)
        view.addSubview(viewAlbumButton)
        
        NSLayoutConstraint.activate([
            largeAlbumArtwork.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            largeAlbumArtwork.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            albumTitleLabel.topAnchor.constraint(equalTo: largeAlbumArtwork.bottomAnchor, constant: 15),
            albumTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            albumTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            artistNameLabel.topAnchor.constraint(equalTo: albumTitleLabel.bottomAnchor, constant: 5),
            artistNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            artistNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            genereDetailTitleLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 1),
            genereDetailTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            genereDetailTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            releaseDateTitle.topAnchor.constraint(equalTo: genereDetailTitleLabel.bottomAnchor, constant: 8),
            releaseDateTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            
            copyRightDetailTitleLabel.topAnchor.constraint(equalTo: releaseDateTitle.bottomAnchor, constant: 2),
            copyRightDetailTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            copyRightDetailTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            viewAlbumButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            viewAlbumButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            viewAlbumButton.heightAnchor.constraint(equalToConstant: 44),
            viewAlbumButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -40)
            
            ])
        
        viewAlbumButton.addTarget(self, action: #selector(openItunesApp), for: .touchUpInside)
    }
    
    @objc func openItunesApp() {
        guard let urlStr = albumData?.url, let url = URL(string: urlStr) else {return}
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            Alert.showNormalAlertWith(message: "Can not open the url. Please try again")
        }
        
    }
}
