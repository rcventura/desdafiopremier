//
//  NotificationViewController.swift
//  desafiopremiersoft
//
//  Created by Rodrigo Ventura on 19/04/21.
//

import UIKit

class NotificationViewController: UIViewController {
    
    
    var dataSections: [String] = ["Não Lidas", "Lidas"]
    
    var tableViewNotifications = UITableView()
    let notificationApi = NotificationsVM()
    var notificationsList = [NotificationElements]()
    
    var result: Notification?
    
    
    func setupTableView() {
        self.tableViewNotifications.frame = self.view.frame
        self.tableViewNotifications.dataSource = self
        self.view.addSubview(tableViewNotifications)
        
        self.tableViewNotifications.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    
    }
    
    func itensForSections(section: Int) -> Int {
        var arrayNotificationsList:[NotificationElements] = []
        for value in self.notificationsList {
            if value.isRead == true {
                arrayNotificationsList.append(value)
            } else if value.isRead == false {
                arrayNotificationsList.append(value)
            }
        }
        return arrayNotificationsList.count
    }
    
    
    
    
  
    // MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        notificationApi.getNotifications {
            data in
            self.notificationsList = data
            DispatchQueue.main.async {
                self.tableViewNotifications.reloadData()
                print(data)
            }
        }
      view.backgroundColor = .white
    }
}

extension NotificationViewController: UITableViewDataSource {
    // NUMERO DE SECTIONS VINDO DO ARRAY DATASECTIONS
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // TITULO DAS SECTIONS VINDO DO ARRAY DATASECTIONS
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        

         // return self.result?.notifications[section].isRead
        
        if (section == 0) {
            return "Nao lida"
        } else if (section == 1) {
            return "Lidas"
        }
        return ""
    }
    
    // NUMERO DE LINHAS POR SECTIONS VINDO DA API
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            self.itensForSections(section: section)
        } else if (section == 1) {
            self.itensForSections(section: section)
        }
        return 0
    }
    
    
    // DADOS PEGOS DA API PARA ALIMENTAR A CELULA
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.notificationsList[indexPath.row].id + "   -   " + self.notificationsList[indexPath.row].content
        
        
        return cell
        
    }
    
    
}
