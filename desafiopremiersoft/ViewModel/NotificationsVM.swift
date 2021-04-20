//
//  NotificationsVM.swift
//  desafiopremiersoft
//
//  Created by Rodrigo Ventura on 19/04/21.
//

import Foundation


struct NotificationsVM {
    
    func getNotifications(completion: @escaping ([NotificationElements])->()) {
    
        let apiUrl = "https://api.jsonbin.io/b/607db4d70ed6f819beb03020"
        
        guard let url = URL(string: apiUrl) else { return }
        
         URLSession.shared.dataTask(with: url) {data, response, error in
            
            if let error = error {
                print("Deu erro: \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Response Vazio")
            return
            }
            print("Response statusCode: \(response.statusCode)")
            guard let data = data else {
                print("Vazio Data")
                return
            }
            do {
              let result = try JSONDecoder().decode(Notification.self, from: data)
                completion(result.notifications)
                print(result)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
