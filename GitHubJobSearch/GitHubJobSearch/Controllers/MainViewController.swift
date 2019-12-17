//
//  ViewController.swift
//  GitHubJobSearch
//
//  Created by Eugene Berezin on 12/14/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit

class MainViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    fileprivate let cellId = "searchCellId"
    fileprivate let headerCellId = "header"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "GitHub Jobs"
        collectionView.backgroundColor = .lightGray
        collectionView.register(SearchViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)
    
        
    }
    
    fileprivate var jobResults = [Result]()
    
    
    @objc func fetchJobs() {
        let header = HeaderCell()
        var jobDescription = ""
        var searchCity = ""
        
        Service.shared.fetchJobs(description: jobDescription , city: searchCity) {[weak self] (result, err) in
            if let err = err {
                print("Failed to fetch jobs:", err)
                return
            }
            
            DispatchQueue.main.async {
                jobDescription = header.positionTextField.text ?? ""
                searchCity = header.cityTextField.text ?? ""
                
                print(jobDescription, searchCity)
            }
            
            self?.jobResults = result
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            
           
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellId, for: indexPath) as! HeaderCell
        //header.layer.cornerRadius = 12
        header.searchButton.addTarget(self, action: #selector(fetchJobs), for: .touchUpInside)
           return header
       }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 150)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchViewCell
        cell.layer.cornerRadius = 12
        let jobResult = jobResults[indexPath.item]
        cell.jobResult = jobResult
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        
           return .init(width: view.frame.width - 20, height: 180)
       }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = JobDetailsViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
   init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}

