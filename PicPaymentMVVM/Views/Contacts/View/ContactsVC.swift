//
//  ContactsVC.swift
//  PicPaymentMVVM
//
//  Created by Hundily Cerqueira on 18/02/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

import UIKit

class ContactsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = ContactsViewModel()
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.searchBar.placeholder = L10n.placeHolderSearch
        return search
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupNavigation()
        viewModel.fetchContacts()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
        tableView.registerNib(ContactTableViewCell.self)
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Contacts"
        navigationItem.searchController = searchController
    }
}

extension ContactsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getContactsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ContactTableViewCell

        cell.data = viewModel.getContactsAt(indexPath.row)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = viewModel.getContactsAt(indexPath.row)
        let navController = UINavigationController(rootViewController: CreditCardVC(contact: contact))
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
}

extension ContactsVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.lowercased(), !searchText.isEmpty {
            viewModel.filterContacts(by: searchText)
        }
    }
}

extension ContactsVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setLayout(state: .enabled)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setLayout(state: .disabled)
        viewModel.clearFilterContacts()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setLayout(state: .disabled)
        viewModel.clearFilterContacts()
    }
}

extension ContactsVC: ViewModelDelegate {
    
    func show() {
        self.tableView.reloadData()
    }

}
