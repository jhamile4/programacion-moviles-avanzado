//
//  ViewController.swift
//  ActividadDesarrollo
//
//  Created by Tecsup on 27/04/26.
//

import UIKit

// Estructura de los datos
struct Cultura {
    let nombre: String
    let region: String
    let descripcion: String
    let imagen: String
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tablaCulturas: UITableView!
    
    var listaCulturas: [Cultura] = [
        Cultura(nombre: "Chavín", region: "Áncash", descripcion: "Cultura del Horizonte Temprano.", imagen: "chavin"),
        Cultura(nombre: "Paracas", region: "Ica", descripcion: "Famosos por sus mantos.", imagen: "paracas")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Conectamos la tabla con el código
        tablaCulturas.dataSource = self
        tablaCulturas.delegate = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1. Verificamos que el ID sea el que pusiste en la flecha (sgDetalle)
        if segue.identifier == "sgDetalle" {
            
            // 2. Verificamos que el destino sea tu clase de detalle
            if let pantallaDetalle = segue.destination as? DetalleViewController,
               let cultura = sender as? Cultura {
                
                // 3. PASAMOS LA INFORMACIÓN a la variable del segundo controlador
                pantallaDetalle.culturaRecibida = cultura
            }
        }
    }    // Cuántas filas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaCulturas.count
    }

    // Qué dice cada fila
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        cell.textLabel?.text = listaCulturas[indexPath.row].nombre
        cell.detailTextLabel?.text = listaCulturas[indexPath.row].region
        cell.imageView?.image = UIImage(named: listaCulturas[indexPath.row].imagen)
        return cell
    }

    // Qué pasa al tocar una fila
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let seleccionada = listaCulturas[indexPath.row]
        performSegue(withIdentifier: "sgDetalle", sender: seleccionada)
    }
}
