//
//  ImageListViewController.swift
//  AstroPicture
//
//  Created by AMRUT WAGHMARE on 25/05/24.
//

import UIKit
import Combine
import SDWebImage

class ImageListViewController: UIViewController {
    
    // MARK: @IBOutles
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Private Properties
    private var viewModel: ImageListViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ImageListViewModel()
        self.title = "Astor Picture"
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        setupTableView()
        bindViewModel()
        viewModel?.fetchImageData()
    }
    
    // MARK: - Private Methods
    //Configures delegates and datasouce of table view.
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        let imageListTableViewCell = UINib(nibName: ImageListTableViewCell.identifire, bundle: nil)
        tableView.register(imageListTableViewCell, forCellReuseIdentifier: ImageListTableViewCell.identifire)
    }
    
    private func bindViewModel() {
        // Subscribe to view model updates
        viewModel?.$apods
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    if self?.viewModel?.apods.count ?? 0 > 0 {
                        self?.activityIndicator.stopAnimating()
                    }
                    self?.tableView.reloadData()
                }
            }
            .store(in: &cancellables)
        
        // Subscribe to view model error messages
        viewModel?.$errorMessage
            .sink { [weak self] errorMessage in
                DispatchQueue.main.async {
                    if let message = errorMessage {
                        self?.activityIndicator.stopAnimating()
                        self?.showError(message)
                    }
                }
            }
            .store(in: &cancellables)
    }

    // Display error message in an alert
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Table View Delegate and DataSource
extension ImageListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.apods.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageListTableViewCell.identifire, for: indexPath) as? ImageListTableViewCell else {
            return ImageListTableViewCell()
        }
        let apod = viewModel?.apods[indexPath.item]
        cell.titleLabel?.text = apod?.title
        cell.dateLabel?.text = apod?.date
        cell.previewImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.previewImageView.sd_setImage(with: URL(string: apod?.url ?? ""), placeholderImage: UIImage(named: "cell_placeholder"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let apod = viewModel?.apods[indexPath.row], let imageDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: ImageDetailViewController.identfire) as? ImageDetailViewController else { return }
        imageDetailViewController.viewModel = ImageDetailViewModel(apod: apod)
        self.navigationController?.pushViewController(imageDetailViewController, animated: true)
    }
}

// MARK: - Test Hooks

#if DEBUG
extension ImageListViewController {
    var testHooks: TestHooks {
        TestHooks(target: self)
    }
    struct TestHooks {
        var target: ImageListViewController
        var viewModel : ImageListViewModel? {
            return target.viewModel
        }
        
        func setViewModel(viewModel : ImageListViewModel?) {
            target.viewModel = viewModel
        }
        
    }
}
#endif
