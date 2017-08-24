//==============================
import Foundation
//==============================
class Add {
    //------------------------
    var dictionnary: [String: Bool]!
    var keys: [String] = []
    var values: [Bool] = []
    var arrayOfValues: [String] = []
    //------------------------ Constructeur 
    init() {
        if let dict = Singleton.singletonInstance.dictionnary {
           dictionnary = dict
        } else {
            dictionnary = [:]
        }
        parseDict()
    }
    //------------------------ Fonction pour batir le dictionnaire
    func parseDict() {
        keys = []
        values = []
        for (k, v) in dictionnary {
            keys.append(k)
            values.append(v)
        }
    }
    //------------------------ Fonction pour Crée une nouvelle valeur et initialiser à "false"
    func addValue(keyToAdd: String) {
        dictionnary[keyToAdd] = false
        saveToSingleton()
    }
    //------------------------ Fonction pour enlever la valeur d'une clé dans le dictionnaire
    func removeValue(keyToRemove: String) {
        dictionnary[keyToRemove] = nil
        saveToSingleton()
    }
    //------------------------ Fonction pour Sauvegarder les valeurs dans le Singleton
    func saveToSingleton() {
        parseDict()
        Singleton.singletonInstance.dictionnary = dictionnary
        Singleton.singletonInstance.saveData()
    }
     //------------------------ Fonction pour vider le dictionnaire
    func removeTask(){
        dictionnary = [:]
        self.parseDict()
    }
   //------------------------- Fonction qui compte les valeurs true
    func countTrueValues() -> Int{
        var n = 0
        for i in values {
            if i == true {
                n+=1
            }
        }
        return n
    }
     //------------------------ Fonction qui insert les valeurs "true" dans un tableau
    func trueValues() {
        
        for (x,y) in dictionnary {
            if y == true {
                arrayOfValues.append(x)
            }
        }
    }
    //------------------------ Remettre la valeur du dictionnaire à "flase" en fonction de la clé envoyée en paramètre
    func removeValueTrue(keyTrue: String){
        dictionnary[keyTrue] = false
        saveToSingleton()
    }
    //------------------------
}//end class Add












