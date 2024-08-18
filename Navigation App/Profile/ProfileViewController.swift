//
//  ProfileViewController.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 12.8.24..
//

import UIKit

class ProfileViewController: UIViewController {

    let profileHeaderView = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .white
        self.view.backgroundColor = .red
        self.title = "Profile"
        view.addSubview(profileHeaderView)
        profileHeaderView.frame = view.frame
        /**
         "Далее в ProfileViewController нужно уже закрепить констрейнтами profileHeaderView."
         Без задания отдельного вью бэкграунда в profileHeaderView - это не работает.
         Компилятор ругается на конфликтующие между собой констрейнты, даже со всеми закомментированными элементами не подгружается даже бг колор.
         Если это требуется для сдачи конкретно этого дз, прошу описать, в чем моя ошибка в дискорде
         */
    }
}
