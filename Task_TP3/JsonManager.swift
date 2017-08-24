/*==================================*/
import Foundation
/*==================================*/
class JsonManager
{
    //----------------------------
    var jsonParsed:NSMutableDictionary = [:]
    var urlToJsonFile: String = ""
    //---------------------------- Constructeur
    init(urlToJsonFile: String) {
        self.urlToJsonFile = urlToJsonFile
    }
    //----------------------------
    func parser(_ jsonFilePath: String) -> NSMutableDictionary { // convertir le ficher json en dictionnaire
        let data = try! Data(contentsOf: URL(string: jsonFilePath)!)
        return try! JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
    }
    //---------------------------- jsonParsed reçoit se qu'on a recuperer du JSON
    func importJSON() {
        self.jsonParsed = self.parser(self.urlToJsonFile)
    }
    //---------------------------- Fonction pour extraire les clés et les valeurs et les envoyers dans le dictionnaire
    func loading(temp: Add) {
        temp.keys = []
        temp.values = []
        
        for (a,b) in jsonParsed {
            temp.keys.append(a as! String)
            
            let str = b as! String
            
            if str == "true"{
                temp.values.append(true)
            }else{
                temp.values.append(false)
            }
        }
        for i in 0 ..< temp.keys.count {
            temp.dictionnary[temp.keys[i]] = temp.values[i]
        }
    }
}//end class JsonManager
/*==================================*/















