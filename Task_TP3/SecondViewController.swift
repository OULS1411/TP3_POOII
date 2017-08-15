//==============================
import UIKit
//==============================
class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    //---------------------------
    @IBOutlet weak var tableView: UITableView!
    public var defaults = UserDefaults.standard
    var dictionnary: [String: Bool]!
    
    //--------------------------
     let addObject = Add()
    //---------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        //addObject.dictionnary = defaults.object(forKey: "data") as! [String : Bool]!
    }
    //---------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    /*=========================================================================================
     ******************************************************************************************
     ******************************      TableView       **************************************
     ******************************************************************************************
     =========================================================================================*/
    //--------------------------- Fonction qui retourne nombre items du tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundColor = UIColor.clear
        return addObject.dictionnary.count
    }
    //--------------------- Fonction qui remplie la tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"proto")
        cell.textLabel!.text = addObject.keys[indexPath.row]
        cell.textLabel?.textColor = UIColor.white // changer la couleur du text sur la tableView
        cell.backgroundColor = UIColor.clear
        return cell
    }
    //--------------------- Fonction qui select items du tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        selectedCell.contentView.backgroundColor = UIColor.darkGray
    }
       //--------------------- Fonction qui delete la ligne
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            addObject.removeValue(keyToRemove: addObject.keys[indexPath.row])
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
}//============================== end class SecondViewController
