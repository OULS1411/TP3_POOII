//==============================
import Foundation
//==============================
class Add {
    //---------------------------
    var dictionnary: [String: Bool]!
    var keys: [String] = []
    var values: [Bool] = []
    var arrayOfValues: [String] = []
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
     //--------------------------- Function pour vider le dictionnaire
    func removeTask(){
        dictionnary = [:]
        self.parseDict()
    }
    
    //-------------------------- Fonction qui compte les valeurs true
    func countTrueValues() -> Int{
        var n = 0
        for i in values {
            if i == true {
                n+=1
            }
        }
        return n
    }
     //--------------------------
    func trueValues() {
        
        for (x,y) in dictionnary {
            if y == true {
                arrayOfValues.append(x)
            }
        }
    }
    //--------------------------- Remettre la valeur du dictionnaire a flase
    func removeValueTrue(keyTrue: String){
        dictionnary[keyTrue] = false
        saveToSingleton()
    }
    //-----------------------------
}//end class Add












