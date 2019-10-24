//
//  HomeViewController.swift
//  PersonApp
//
//  Created by Eva on 10/11/19.
//  Copyright © 2019 Eva. All rights reserved.
//

import UIKit
import CoreData
class HomeViewController:  UIViewController, AddPersonViewControllerDelegate {
    private enum CellIdentifiers {
        static let list = "PersonsTableViewCell"
    }
    var personsArr = [Person]()
    var searchedPerson = [Person]()
    var searching = false
    @IBOutlet weak var personSearch: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    var refreshControl   = UIRefreshControl()
    var viewModel = AppRequestManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tblView.addSubview(refreshControl)
        
        self.tblView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItems = [add]
        hideKeyboardWhenTappedAround()
    }
    
    @objc func addTapped(){
        let vc = AddPersonViewController.createInstance()
        vc.modalPresentationStyle = .pageSheet
        vc.delegate = self
        
        self.present(vc, animated: true)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        updateData()
    }
    
    func dismissed() {
        dismiss(animated: true, completion: nil)
        updateData()
    }
    
    @objc func refresh(_ sender: Any) {
        updateData()
    }
    
    
    func updateData() {
        viewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                self!.personsArr = (self?.viewModel.arrayOfPerson)!
                self!.searchedPerson = (self?.viewModel.arrayOfPerson)!
                self!.personSearch.delegate = self
                self!.tblView.reloadData()
                self!.refreshControl.endRefreshing()
            }
        }
        viewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                self!.refreshControl.endRefreshing()
            }
        }
        
        let isFetched = UserDefaults.standard.value(forKey: "isAllreadyFetch") as? Bool
        // appDelegate.deleteAll() --> This call delete all save data
        if (isFetched == nil) || !(isFetched ?? false){
            //API calling
            viewModel.getListData()
        }else {
            viewModel.fetchLocalData()
        }
        
        //        RequestManager.getPersons(completionHandler: { response in
        //            DispatchQueue.main.async {
        //                self.personsArr = response
        //                self.personSearch.delegate = self
        //                self.tblView.reloadData()
        //                self.refreshControl.endRefreshing()
        //            }
        //        }
        //            , errorHandler: { error in
        //                DispatchQueue.main.async {
        //                }
        //        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        imageCache.removeAllObjects()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "person" {
            imageCache.removeAllObjects()
            let destVC = segue.destination as! PersonViewController
            destVC.pages = self.personsArr
            destVC.currentPerson = sender as? Person
            
            
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedPerson.count
        } else {
            return personsArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.list, for: indexPath) as! PersonsTableViewCell
        searching ? cell.configure(with: searchedPerson[indexPath.row]) : cell.configure(with:  personsArr[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching {
            performSegue(withIdentifier: "person", sender: searchedPerson[indexPath.row])
        } else {
            performSegue(withIdentifier: "person", sender: personsArr[indexPath.row])
        }
        
    }
    
}


extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedPerson = personsArr.filter({$0.name!.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tblView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tblView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
