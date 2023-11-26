//
//  Bag.swift
//  eDepositBag
//
//  Created by Jake Vigeant on 11/2/23.

import Foundation
class Bag : ObservableObject{
    static let fileManager = FileManager.default
    static let testURL = Bundle.main.url(forResource: "test_pdf", withExtension: "pdf")
    static let sandboxUser = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("myProfile.json")
    static let selectionOptions = Bundle.main.url(forResource: "selection_options", withExtension: "json") 
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    // TODO change when deployed
    let SERVER_BASE = "http://localhost:8080/"

    @Published var cashier: Person?
    @Published var department: String = ""
    @Published var retailLocation: String = ""
    @Published var POSName: String = ""
    @Published var bagNum: Int = 0
    @Published var imageScans: [String:String] = [:]
    @Published var revenueDate: String = ""
    @Published var messages: [Message] = []

    var departments: [String] = []
    var locationSelections: [String:[String]] = [:]
    var POSNameSelections: [String:[String]] = [:]

    

    func logout() {
        cashier = nil
    }
    //load Person object from saved user
    func load(url :URL) -> Bool{
       
       //location of the url passed in
       print("Loading from: \(url.path)")
       let tempData: Data
       //check if the url passed exists.
       if Bag.fileManager.fileExists(atPath: url.path){
           do {
               tempData = try Data(contentsOf: url)
               print(tempData)
               if tempData.count == 0{
                   print("hi")
               }
           } catch let error as NSError {
               print(error)
               return false
           }
           do {
               self.cashier = try decoder.decode(Person.self, from: tempData)
               return true
           } catch {
               return false
           }

       }
        return false
       }
    
    //update the users profile in sandbox
    func save() -> Bool {
        print("Saving to \(Bag.sandboxUser)")
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(cashier)
            try jsonData.write(to: Bag.sandboxUser)
            return true
        } catch {
            print("Error saving Use: \(error)")
            return false
        }
    }
    
    func parseOptions(url: URL) -> Bool {
        do {
            let jsonData = try Data(contentsOf: url)
            do {
                //extract all of the selection options
                if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
                   let dept = jsonObject["departments"] as? [String], let locs = jsonObject["locations"] as? [String:[String]] {
                    self.departments = dept
                    self.locationSelections = locs
                }
                return true
            } catch {
                print("Error parsing JSON: \(error)")
                return false
            }
        } catch {
            print("Error loading JSON: \(error)")
            return false
        }
    }

    // load user messages
    func fetchMessages() -> Bool {
        guard let url = URL(string: (SERVER_BASE + "messages/\(cashier!.duid)"))
        else{
            print("Invalid URL")
            return false
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            // Handle the response
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
                if let data = data {
                    let responseString = String(data: data, encoding: .utf8)
                    print("Response: \(responseString ?? "")")
                    
                }
            }
        }

        task.resume()
        return true

    }



    
    

}
