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
        collectionView.backgroundColor = UIColor(named: "background")
        collectionView.register(SearchViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)
        setupSearchBar()
        
    }
    

    fileprivate var jobResults = [Result]()
    
    let citySearchBar = UISearchBar()
        

    fileprivate func setupSearchBar() {
        
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .lightGray
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor(named: "textColor")
        textFieldInsideSearchBar?.placeholder = "Position"
        textFieldInsideSearchBar?.tag = 0
        searchController.view.addSubview(citySearchBar)
        citySearchBar.frame =  CGRect(x: 10, y: searchController.searchBar.frame.height + 50, width: view.frame.size.width - 30 , height: 50)
        citySearchBar.value(forKey: "searchField")
        citySearchBar.backgroundColor = UIColor(named: "background")
        citySearchBar.placeholder = "Location"
        citySearchBar.layer.cornerRadius = 12
        citySearchBar.delegate = self
        citySearchBar.tag = 2
        
    }
    

    
    var timer: Timer?
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
        if let position = searchController.searchBar.text , let city = citySearchBar.text  {
            timer?.invalidate()
            
            
                timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in

                    // this will actually fire my search
                    Service.shared.fetchJobs(description: position, city: city) { (result, err) in
                        self.jobResults = result


                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }

                })
            
            
            print("This is city", city)
            print("This is position,", position)
            
        }
        
        
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
        detailVC.jobResult = jobResults[indexPath.item]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
   init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}

