//
//  LeagueInfoVC.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 22/02/2025.
//

import Combine
import UIKit

class LeagueInfoVC: UIViewController {
    
    let titleContainer = UIView()
    let customSegmentedView = CustomSegmentedView(with: [
        "Table",
        "Fixtures",
        "Teams"
    ])
    
    var competition: Competition? = nil
    
    private var pageViewController: UIPageViewController!
    private var pages: [UIViewController] = []
    @Published var currentIndex = 0
    
    var viewModel: LeagueInfoViewModel?// = TableViewModel()
    var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationAndTabBar(hidden: true)
        configureCustomSegmentedView()
        setLeftAlignedTitle(title ?? "")
        
        setupPageViewController()
        setupBindings()
    }
    
    func configureCustomSegmentedView() {
        view.addSubview(customSegmentedView)
        customSegmentedView.anchor(top: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor, leading: view.leadingAnchor, height: 100)
        let dividerView = UIView()
        dividerView.backgroundColor = .gray.withAlphaComponent(0.3)
        customSegmentedView.addSubview(dividerView)
        dividerView.anchor(trailing: customSegmentedView.trailingAnchor, bottom: customSegmentedView.bottomAnchor, leading: customSegmentedView.leadingAnchor, height: 1)
    }
    
    func setupBindings() {
        customSegmentedView.$selectedIndex.sink { [weak self] index in
            guard let self else { return }
            pageViewController.setViewControllers([pages[index]], direction: index > currentIndex ? .forward : .reverse, animated: true, completion: nil)
            print("Here is current Index: \(currentIndex) - Index: \(index)")
            currentIndex = index
        }
        .store(in: &cancellable)
    }
    
    func setLeftAlignedTitle(_ title: String) {
        
        let backIcon = UIImageView(image: UIImage(systemName: "chevron.left"))
        backIcon.tintColor = .black
        let backButton = UIButton(frame: .zero)
//        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
//        backButton.tintColor = .clear
        backButton.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        // Create a UILabel for the title
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        
        titleContainer.addSubview(backIcon)
        titleContainer.addSubview(titleLabel)
        titleContainer.addSubview(backButton)
        
        view.addSubview(titleContainer)
        titleContainer.anchor(top: view.topAnchor, trailing: view.trailingAnchor, leading: view.leadingAnchor, height: 100)
        
        backIcon.anchor(bottom: titleContainer.bottomAnchor, leading: titleContainer.leadingAnchor, paddingLeft: 16, paddingBottom: 10, width: 12, height: 20)
        
        titleLabel.anchor(leading: backIcon.trailingAnchor, paddingLeft: 10)
        titleLabel.centerAnchor(axis: .vertical, on: backIcon)
        
        backButton.anchor(top: titleLabel.topAnchor, trailing: titleLabel.trailingAnchor, bottom: titleContainer.bottomAnchor, leading: backIcon.leadingAnchor)
        
        backButton.backgroundColor = .clear
    }
    
    @objc func handleBackButton(button: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func setNavigationAndTabBar(hidden: Bool) {
        self.navigationController?.setNavigationBarHidden(hidden, animated: true)
        tabBarController?.tabBar.isHidden = hidden
    }
    
    private func setupPageViewController() {
        // Initialize the PageViewController
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        // Create pages
        let tableVC = TableController()
        let fixtureVC = FixtureController()
        let teamVC = TeamController()
        
        
        tableVC.competition = competition
        fixtureVC.competition = competition
        teamVC.competition = competition
        
        viewModel = LeagueInfoViewModel()
        
        if let code = competition?.code {
            viewModel?.fetchTeamStandings(code: code)
        }
        
        tableVC.viewModel = viewModel
        teamVC.viewModel = viewModel
        
        pages = [tableVC, fixtureVC, teamVC]
        
        
        // Set the initial page
        if let firstPage = pages.first {
            pageViewController.setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }
        
        // Add the PageViewController as a child
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.view.anchor(top: customSegmentedView.bottomAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor)
        pageViewController.didMove(toParent: self)
    }
}

// MARK: - UIPageViewControllerDataSource
extension LeagueInfoVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else { return nil }
        return pages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }
}

// MARK: - UIPageViewControllerDelegate
//extension LeagueInfoVC: UIPageViewControllerDelegate {}
extension LeagueInfoVC: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard completed, let visibleVC = pageViewController.viewControllers?.first,
              let index = pages.firstIndex(of: visibleVC) else { return }
        
        currentIndex = index
        customSegmentedView.viewModel?.handleSelection(at: index)
    }
}
