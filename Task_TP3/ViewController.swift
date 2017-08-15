//==============================
import UIKit
//==============================
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    //---------------------------
    @IBOutlet weak var addField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    public var defaults = UserDefaults.standard
    static let singletonInstance = Singleton()
     var jsonParsed:NSMutableDictionary = [:]
    var jsonManager = JsonManager(urlToJsonFile:"http://localhost/dashboard/Ouldyounes/grasset_p10/data.json")
    //---------------------------
    let addObject = Add() //  objet de type ADD..
    //---------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        self.jsonManager.importJSON()
    }
    //---------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*=========================================================================================
     ******************************************************************************************
     ***********************************      BUTTONS       ***********************************
     ******************************************************************************************
     =========================================================================================*/
    
    //-------------------- Bouton ADD - Fonction qui ajoute une donnée a la TableView
    @IBAction func addButton(_ sender: UIButton) {
        addObject.addValue(keyToAdd: addField.text!)
        tableView.reloadData()
        addField.text?.removeAll()
        alert("Task added successfully")
    }
    
    //--------------------- Bouton Save - fonction pour sauvegarder les données dans le serveur
    @IBAction func saveButton(_ sender: UIButton) {
        //alerte pour le bouton save
        let alert = UIAlertController(title: "Save database online", message: "Really want to save database and replace the one online", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            self.reallyDosave()
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction!) in
        }))
        
        present(alert, animated: true, completion: nil)

    }
    
    //--------------------- Bouton Load —— fonction qui va chercher les données sauvegarder sur le serveur et remplacer ce qui se trouve dans le telephone —— ( le bouton save va sauvegarder les données dans le serveur.)
    
    @IBAction func Load(_ sender: UIButton) {
//        alert("Tout est bon")
//        let requestURL: NSURL = NSURL(string: "http://localhost/dashboard/Ouldyounes/grasset_p10/data.json")!
//        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url:requestURL as URL)
//        let session = URLSession.shared
//        let task = session.dataTask(with: urlRequest as URLRequest) {
//            (data, response, error) -> Void in
//            let httpResponse = response as! HTTPURLResponse
//            let statusCode = httpResponse.statusCode
//            if (statusCode == 200) {
//               print("Tout fonctionne correctement...")
//                do{
//                    let json = try JSONSerialization.jsonObject(with:data!, options:.allowFragments)
//                    print(json)
//                    
//                }catch {
//                    print("Erreur Json: \(error)")
//                }
//            } }
//        task.resume()
//      
        self.jsonManager.importJSON()
        self.jsonManager.loading(temp: self.addObject)
        addObject.saveToSingleton()
        tableView.reloadData()
    }
    //--------------------------- Bouton Reset -
    @IBAction func ressetButton(_ sender: UIButton) {
        
        for x in 0 ..< addObject.dictionnary.count
        {
            if Array( addObject.dictionnary.values)[x] {

                addObject.dictionnary[Array( addObject.dictionnary.keys)[x]] = false
            }
        }
        tableView.reloadData()
    }
    
    
    /*=========================================================================================
     ******************************************************************************************
     ***********************************      Functions       *********************************
     ******************************************************************************************
     =========================================================================================*/
    //---------------------------
    func reallyDosave(){
       
        var urlToSend = "http://localhost/dashboard/Ouldyounes/grasset_p10//add.php?json=["
        var counter = 0
        let total = self.addObject.dictionnary.count
        for (a, b) in self.addObject.dictionnary {
            print("Le A = \(a) et le B = \(b)")
        }
        
        for (a, b) in self.addObject.dictionnary {
            let noSpaces = self.replaceChars(originalStr: a, what: " ", byWhat: "_")
            counter += 1
            if counter < total {
                urlToSend += "/\(noSpaces)/,/\(b)/!"
            } else {
                urlToSend += "/\(noSpaces)/,/\(b)/"
            }
        }
        urlToSend += "]"
        
        print(urlToSend)
        
        let session = URLSession.shared
        let urlString = urlToSend
        let url = NSURL(string: urlString)
        let request = NSURLRequest(url: url! as URL)
        
        let dataTask = session.dataTask(with: request as URLRequest) {
            (data:Data?, response:URLResponse?, error:Error?) -> Void in
        }
        dataTask.resume()
    }
    //---------------------------
    func replaceChars(originalStr: String, what: String, byWhat: String) -> String {
        return originalStr.replacingOccurrences(of: what, with: byWhat)
    }
    
    //---------------------------
    func alert(_ theMessage: String){
        let refreshAlert = UIAlertController(title: "Message...", message: theMessage, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        refreshAlert.addAction(OKAction)
        present(refreshAlert, animated: true){}
    }
    
       
    
    /*=========================================================================================
     ******************************************************************************************
     ***********************************      TableView       *********************************
     ******************************************************************************************
     =========================================================================================*/
    
   //---------------------- Fonction qui retourne nombre items du tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundColor = UIColor.clear
        return  addObject.dictionnary.count
    }
    //--------------------- Fonction qui remplie la tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"proto")
        cell.textLabel!.text = Array( addObject.dictionnary.keys)[indexPath.row]
        cell.textLabel!.textColor = UIColor.white // changer la couleur du text sur la tableView
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    //--------------------- Fonction qui select items du tableView
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if Array( addObject.dictionnary.values)[indexPath.row] {
            cell.backgroundColor = UIColor.lightGray//changer la couleur de la selectionne dans la tableView
            
        }
    }
    //--------------------- Fonction qui delete la ligne
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            addObject.removeValue(keyToRemove: addObject.keys[indexPath.row])
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    //---------------------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //changer la couleur de la cellule à la selection
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        selectedCell.contentView.backgroundColor = UIColor.darkGray
        
        if !Array( addObject.dictionnary.values)[indexPath.row] {
            addObject.dictionnary[Array( addObject.dictionnary.keys)[indexPath.row]] = true
        } else {
            addObject.dictionnary[Array( addObject.dictionnary.keys)[indexPath.row]] = false
        }
        tableView.reloadData()
    }
    
    
    



}//end class
//==============================