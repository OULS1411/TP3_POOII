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
        addObject.trueValues() // appel de la fonction "trueValues" dans la classe Add
    }
    //---------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK:--------------TableView
    //--------------------------- Fonction qui retourne nombre items du tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundColor = UIColor.clear
        return addObject.countTrueValues()
    }
    //--------------------- Fonction qui remplie la tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"proto")
        cell.textLabel!.text = addObject.arrayOfValues[indexPath.row]
        cell.textLabel?.textColor = UIColor.white // changer la couleur du text sur la tableView
        cell.backgroundColor = UIColor.clear
        return cell
    }
    //--------------------- Fonction qui select l'items du tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        selectedCell.contentView.backgroundColor = UIColor (red: 0.40, green: 0.73, blue: 0.68, alpha: 1.0)
    }
    
       //--------------------- Fonction qui supprime la rangé de la tableView
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            addObject.removeValueTrue(keyTrue: addObject.arrayOfValues[indexPath.row])
            addObject.arrayOfValues.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
}//============================== end class SecondViewController
