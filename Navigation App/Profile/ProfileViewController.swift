//
//  ProfileViewController.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 12.8.24..
//

import UIKit

class ProfileViewController: UIViewController {
    let profileHeaderView = ProfileHeaderView()
    fileprivate let data = Post.makePost()
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .plain
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private enum CellReuseID: String, CaseIterable {
        case photo = "PhotoTableViewCell_ReuseID"
        case base = "BaseTableViewCell_ReuseID"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .white
        self.view.backgroundColor = .systemBackground
        self.title = "Profile"
        setupView()
        addSubviews()
        setupConstraints()
        tuneTableView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func tuneTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        
        let headerView = ProfileHeaderView()
        tableView.setAndLayout(headerView: headerView)
        tableView.register(
            PhotosTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.photo.rawValue
        )
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.base.rawValue
        )
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        CellReuseID.allCases.count
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        if section == 0 {
            return 1
        } else {
            return data.count
        }
        
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseID.photo.rawValue,
            for: indexPath
            ) as? PhotosTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
            cell.update()
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.base.rawValue,
                for: indexPath
            ) as? PostTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
            cell.update(data[indexPath.row])
            return cell
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(
        _ tableView: UITableView,
        heightForFooterInSection section: Int
    ) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        if indexPath.section == 0 {
            let gallery = PhotosViewController()
//            gallery.view.backgroundColor = .red
//            gallery.navigationItem.title = "Photo Gallery"
            navigationController?.pushViewController(gallery, animated: true)
        } else {
            print("Did select cell at \(indexPath)")
            let nextViewController = PostDetailsViewController()
            
            let model = data[indexPath.row]
            nextViewController.update(model: model)
            navigationController?.pushViewController(
                nextViewController,
                animated: true
            )
        }
    }
}

