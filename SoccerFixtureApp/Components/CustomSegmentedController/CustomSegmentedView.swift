//
//  CustomSegmentedView.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 22/02/2025.
//

import Combine
import UIKit

class CustomSegmentedView: UIView {
    
    @Published var selectedIndex: Int = 0
    var viewModel: CustomSegmentedViewModel?
    
    var cancellables = Set<AnyCancellable>()
    
    var collecctionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubViews()
    }
    
    func configureSubViews() {
        addSubview(collecctionView)
        collecctionView.isScrollEnabled = false
        collecctionView.pin(to: self)
        
    }
    
    func setupBindings() {
        
        collecctionView.dataSource = viewModel
        collecctionView.delegate = viewModel
        
        collecctionView.register(OptionCell.self, forCellWithReuseIdentifier: OptionCell.identifier)
        
        viewModel?.$selectedIndex.sink(receiveValue: { [weak self] index in
            guard let self else { return }
            selectedIndex = index
            collecctionView.reloadData()
        })
        .store(in: &cancellables)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(with options: [String]) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        viewModel = .init(options: options)
        setupBindings()
    }
}

extension CustomSegmentedViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleSelection(at: indexPath.row)
    }
}
extension CustomSegmentedViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: ((collectionView.bounds.width ) - CGFloat(8 * options.count)) / CGFloat(options.count),
            height: collectionView.bounds.height)
    }
}
extension CustomSegmentedViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionCell.identifier, for: indexPath) as? OptionCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: options[indexPath.row])
        return cell
    }
}
