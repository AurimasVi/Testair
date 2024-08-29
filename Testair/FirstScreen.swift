//
//  FirstScreen.swift
//  Testair
//
//  Created by Aurimas Vidutis on 26/08/2024.
//

import UIKit

class FirstScreen: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogo()
        
    }
    
    func setupLogo() {
        let logoImage = "Logo.png"
        let image = UIImage(named: logoImage)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        view.backgroundColor = .black
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.transitionToMainScreen()
        }
    }
    
    private func transitionToMainScreen() {
        let mainViewController = MainViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
        
    }
    
    
}

