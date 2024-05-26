//
//  ImageListTableViewCell.swift
//  AstroPicture
//
//  Created by AMRUT WAGHMARE on 26/05/24.
//

import UIKit

class ImageListTableViewCell: UITableViewCell {
    static let identifire = "ImageListTableViewCell"
    
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    //Configures the appearance of the table view cell.
    private func setupCell() {
        previewImageView.contentMode = .scaleAspectFill
        self.selectionStyle = .none
        previewImageView.clipsToBounds = true
        previewImageView.layer.cornerRadius = 10
        
    }
}
