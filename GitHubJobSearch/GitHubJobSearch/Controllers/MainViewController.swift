//
//  ViewController.swift
//  GitHubJobSearch
//
//  Created by Eugene Berezin on 12/14/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit

class MainViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    fileprivate let cellId = "searchCellId"
    fileprivate let headerCellId = "header"
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "GitHub Jobs"
        collectionView.backgroundColor = .lightGray
        collectionView.register(SearchViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)
        setupSearchBar()
        
    }
    
    

    
    
    fileprivate var jobResults = [Result]()
    
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        //searchController.searchBar.text = "Black"
        searchController.searchBar.tintColor = .lightGray
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .black
        textFieldInsideSearchBar?.placeholder = "Position"
        let myTextField: UISearchBar = UISearchBar(frame: CGRect(x: 10, y: searchController.searchBar.frame.height + 50, width: view.frame.size.width - 30 , height: 50))
               myTextField.value(forKey: "searchField")
               myTextField.backgroundColor = UIColor.purple
               myTextField.placeholder = "Location"
               myTextField.layer.cornerRadius = 12
               
               searchController.view.addSubview(myTextField)
    
    }
    
    
    
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//
//        
//        
//    }
    
    
    var timer: Timer?
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        // introduce some delay before performing the search
        // throttling the search
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            // this will actually fire my search
            Service.shared.fetchJobs(description: searchText, city: searchText) { (result, err) in
                self.jobResults = result
                
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
        })
    }
    
    
    @objc func fetchJobs(description: String, city: String) {
        
        Service.shared.fetchJobs(description: city , city: city) {[weak self] (result, err) in
            if let err = err {
                print("Failed to fetch jobs:", err)
                return
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
    

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 1.0, bottom: 1.0, right: 1.0)
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

