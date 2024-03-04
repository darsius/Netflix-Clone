import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let upcomingVC = UINavigationController(rootViewController: UpcomingViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let downloadsVC = UINavigationController(rootViewController: DownloadsViewController())
        
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        upcomingVC.tabBarItem.image = UIImage(systemName: "play.circle")
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        downloadsVC.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        view.tintColor = .label
        
        setViewControllers([homeVC, upcomingVC, searchVC, downloadsVC], animated: true)
        
    }


}

