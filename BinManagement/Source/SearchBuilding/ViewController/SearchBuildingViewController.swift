//
//  SearchBuildingViewController.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/15.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class SearchBuildingViewController: UIViewController {
    // 서버 연동 테스트 위해 임시로 catapi 사용
    var arrayCat : [BuildingModel] = []
    
    private lazy var header = SearchBuildingTabHeader(frame: .zero)
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
    ).then {
        $0.backgroundColor = .clear
        $0.register(
            BuildingListCell.self,
            forCellWithReuseIdentifier: BuildingListCell.identifier
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        config()
        configCollectionView()
        
        let input = BuildingAPIInput(limit: 10, page: 0)
        BuildingDataManager().buildingDataManager(input, self)
    }
    
    private func config() {
        layout()
    }
    
    private func configCollectionView() {
        collectionView.dataSource = self
//        collectionView.delegate = self
    }
    
    private func layout() {
        view.addSubviews([
            header,
            collectionView
        ])
        
        header.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in

            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(95)
                )
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(900)
                ),
                subitems: [item]
            )
            
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
    }
}


extension SearchBuildingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCat.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BuildingListCell.identifier,
            for: indexPath
        ) as? BuildingListCell else { return UICollectionViewCell() }

        if let urlString = arrayCat[indexPath.row].url {
            let url = URL(string: urlString)
            cell.imageView.kf.setImage(with: url)
        }
        
        if let buildingId = arrayCat[indexPath.row].id {
                cell.buildingNameLabel.text = "Building ID: \(buildingId)"
            } else {
                cell.buildingNameLabel.text = "No ID available"
            }

        return cell
    }
}

extension SearchBuildingViewController {
    func successAPI(_ result : [BuildingModel]) {
        arrayCat = result
        collectionView.reloadData()
    }
    
    
}
