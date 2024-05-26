//
//  ImageDetailViewController.swift
//  AstroPicture
//
//  Created by AMRUT WAGHMARE on 26/05/24.
//

import UIKit
import SDWebImage

class ImageDetailViewController: UIViewController {
    static let identfire = "ImageDetailViewController"
    
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel: ImageDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previewImageView.contentMode = .scaleAspectFill
        setupData()
    }
    
    func setupData() {
        let apod = viewModel?.apod
        previewImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        previewImageView.sd_setImage(with: URL(string: apod?.url ?? ""), placeholderImage: UIImage(named: "cell_placeholder"))
        titleLabel.text = apod?.title
        dateLabel.text = apod?.date
        descriptionLabel.text = apod?.explanation
    }
}
