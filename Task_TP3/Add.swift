//==============================
import Foundation
//==============================
class Add {
    //---------------------------
    var dictionnary: [String: Bool]!
    var keys: [String] = []
    var values: [Bool] = []
    //---------------------------
    init() {
        if let dict = Singleton.singletonInstance.dictionnary {
           dictionnary = dict
        } else {
            dictionnary = [:]
        }
        parseDict()
    }
    //---------------------------
    func parseDict() {
        keys = []
        values = []
        for (k, v) in dictionnary {
            keys.append(k)
            values.append(v)
        }
    }
    //---------------------------
    func addValue(keyToAdd: String) {
        dictionnary[keyToAdd] = false
        saveToSingleton()
    }
    //---------------------------
    func removeValue(keyToRemove: String) {
        dictionnary[keyToRemove] = nil
        saveToSingleton()
    }
    //---------------------------
    func saveToSingleton() {
        parseDict()
        Singleton.singletonInstance.dictionnary = dictionnary
        Singleton.singletonInstance.saveData()
    }
     //---------------------------
    
    func removeTask(){
        dictionnary = [:]
        self.parseDict()
    }
    
    //--------------------------
    func countTrue() -> Int{
        var n = 0
        for i in values {
            if i == true {
                n+=1
            }
        }
        return n
    }
}
//==============================











