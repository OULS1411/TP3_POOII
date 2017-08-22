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
    //--------------------------- Fonction pour batir le dictionnaire 
    func parseDict() {
        keys = []
        values = []
        for (k, v) in dictionnary {
            keys.append(k)
            values.append(v)
        }
    }
    //--------------------------- Fonction pour Crée une valeur et initialiser a false
    func addValue(keyToAdd: String) {
        dictionnary[keyToAdd] = false
        saveToSingleton()
    }
    //---------------------------
    func removeValue(keyToRemove: String) {
        dictionnary[keyToRemove] = nil
        saveToSingleton()
    }
    //--------------------------- Fonction pour Sauvegarder les valeurs dans le Singleton
    func saveToSingleton() {
        parseDict()
        Singleton.singletonInstance.dictionnary = dictionnary
        Singleton.singletonInstance.saveData()
    }
     //--------------------------- Fonction pour vider le dictionnaire
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
     //-------------------------- Function qui insert les valeurs true dans un Array
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












