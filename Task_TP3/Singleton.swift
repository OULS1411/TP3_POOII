//==============================
import Foundation
//==============================
class Singleton {
    //---------------------------
    static let singletonInstance = Singleton()
    let userDefault = UserDefaults.standard // userDefault garde localement les données 
    //---------------------------
    var dictionnary: [String: Bool]!
    
    //---------------------------
       init() {
        if userDefault.object(forKey: "data") ==  nil {// Si la boite est vide,"data"c'est le nom de la boite
            userDefault.setValue(dictionnary, forKey: "data") // remplir la boite
        } else {
            dictionnary = userDefault.object(forKey: "data") as! [String : Bool]!
        }
    }
    //---------------------------
    func saveData() {
        userDefault.setValue(dictionnary, forKey: "data")
    }
    //---------------------------
}
//==============================



