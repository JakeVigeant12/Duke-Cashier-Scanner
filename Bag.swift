//
//  Bag.swift
//  eDepositBag
//
//  Created by Jake Vigeant on 11/2/23.

import Foundation
class Bag : ObservableObject{
    static let fileManager = FileManager.default
    static let sandboxUser = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("myProfile.json")
    static let selectionOptions = Bundle.main.url(forResource: "selection_options", withExtension: "json") 
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()

    @Published var cashier: Person?
    @Published var department: String = ""
    @Published var retailLocation: String = ""
    @Published var POSName: String = ""
    @Published var bagNum: Int = 0
    @Published var imageScans: [String:String] = [:]
    @Published var revenueDate: String = ""
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
            // Now you have the JSON data from the
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
                   let dept = jsonObject["departments"] as? [String], let locs = jsonObject["locations"] as? [String:[String]] {
                    self.departments = dept
                    self.locationSelections = locs
                }
                return true
            } catch {
                print("Error parsing JSON: \(error)")
                return false
            }            // You can parse the JSON data as needed
        } catch {
            print("Error loading JSON: \(error)")
            return false
        }
    }




    
    

}
