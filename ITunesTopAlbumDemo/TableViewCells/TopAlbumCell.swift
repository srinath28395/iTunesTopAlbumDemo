//
//  TopAlbumCell.swift
//  TopAlbums
//
//  Created by Chanappa on 21/10/19.
//

import UIKit

class TopAlbumCell: UITableViewCell {

    private let placeHolderImage = UIImage(systemName: "photo.on.rectangle")
    private let imageSize:CGFloat = 50
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var albumArtImageView: AsyncDownloadingImageView = {
        let imgView = AsyncDownloadingImageView()
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = UIColor.systemFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    lazy var albumTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.text = nil
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = nil
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI() {
        self.addSubview(containerView)
        containerView.addSubview(albumArtImageView)
        containerView.addSubview(albumTitleLabel)
        containerView.addSubview(artistNameLabel)
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 70),
            
            
            albumArtImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            albumArtImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            albumArtImageView.widthAnchor.constraint(equalToConstant: imageSize),
            albumArtImageView.heightAnchor.constraint(equalToConstant: imageSize),
            
            albumTitleLabel.leadingAnchor.constraint(equalTo: albumArtImageView.trailingAnchor, constant: 15),
            albumTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            albumTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            artistNameLabel.leadingAnchor.constraint(equalTo: albumArtImageView.trailingAnchor, constant: 15),
            artistNameLabel.topAnchor.constraint(equalTo: albumTitleLabel.bottomAnchor, constant: 5),
            artistNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            ])
    }
    
    var albumData: Results? {
        didSet {
            guard
                let data = albumData,
                let albumArtwork = data.artworkUrl100,
                let albumTitle = data.name,
                let artistName = data.artistName
            else {
                return
            }
            albumArtImageView.loadImage(withImageURL: albumArtwork, placeHolderImage ?? UIImage())
            albumTitleLabel.text = albumTitle
            artistNameLabel.text = artistName
        }
    }

}
