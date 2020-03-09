//
//  ContactsViewModel.swift
//  PicPaymentMVVM
//
//  Created by Hundily Cerqueira on 18/02/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func show()
    func showError()
    func routerRegisterCreditCard(contact: Contact)
    func routerPayment(_ contact: Contact, _ creditCard: CreditCard)
}

class ContactsViewModel {
    private var contactsList: [Contact] = []
    private let service: ContactService?
    weak var delegate: ViewModelDelegate?
    private var creditCard: CreditCard?
    private var selectedContact: Contact?
    
    var count: Int {
        return contactsList.count
    }
    
    private var filterContacts: [Contact] = [] {
        didSet {
            self.delegate?.show()
        }
    }
    
    init() {
        service = ContactService()
    }
    
    func fetchContacts() {
        guard let service = service else { return }
        
        service.fetchContact() { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case let .success(contacts):
                for contact in contacts {
                    strongSelf.contactsList.append(contact)
                }
                strongSelf.delegate?.show()
            case let .failure(error):
                print("error", error)
//                self.allContacts = [ContactListCellType.error(error)]
            }
        }
    }
    
    func getContactsAt(_ index: Int) -> Contact {
        if filterContacts.count > 0 {
            return filterContacts[index]
        }

        return contactsList[index]
    }
    
    func getContactsCount() -> Int {
        if filterContacts.count > 0 {
            return filterContacts.count
        }
        
        return contactsList.count
    }
    
    func clearFilterContacts() {
        self.filterContacts.removeAll()
    }
    
    func filterContacts(by name: String) {
        let listFilter = contactsList.filter { contact in
            return contact.name.uppercased().contains(name.uppercased())
            || contact.username.uppercased().contains(name.uppercased())
        }
        if listFilter.isEmpty {
            print(listFilter.isEmpty)
//            filterContacts = [.error(.empty(.contact))]
        } else {
            filterContacts = listFilter
        }
    }
    
    func handleTapOnContact(contact: Contact) {
        if let cardPase = UserDefaults.standard.object(forKey: "CREDIT_CARD") as? Data {
            let decoder = JSONDecoder()
            if let card = try? decoder.decode(CreditCard.self, from: cardPase) {
                self.creditCard = card
            }
        }
        
        if let card = creditCard {
        self.delegate?.routerPayment(contact, card)
        } else {
            self.delegate?.routerRegisterCreditCard(contact: contact)
        }
    }
}
