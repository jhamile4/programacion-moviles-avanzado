import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var TablaContacto: UITableView!
    
    var contactos = [Contacto]()
    
    func conexion() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        TablaContacto.delegate = self
        TablaContacto.dataSource = self
        cargarInfoCoreData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = TablaContacto.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let unContacto = contactos[indexPath.row]
        
        celda.textLabel?.text = unContacto.nombre
        
        let telefono = unContacto.telefono ?? ""
        let direccion = unContacto.direccion ?? ""
        celda.detailTextLabel?.text = "\(telefono) | \(direccion)"
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let contexto = conexion()
            let contactoAEliminar = contactos[indexPath.row]
            
            contexto.delete(contactoAEliminar)
            
            do {
                try contexto.save()
                contactos.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func cargarInfoCoreData() {
        let contexto = conexion()
        let fetchRequest: NSFetchRequest<Contacto> = Contacto.fetchRequest()
        
        do {
            contactos = try contexto.fetch(fetchRequest)
            TablaContacto.reloadData()
        } catch {
            print("Error: \(error)")
        }
    }

    @IBAction func agregarContacto(_ sender: UIBarButtonItem) {
        let alerta = UIAlertController(title: "Nuevo Contacto", message: "Ingrese los datos del contacto", preferredStyle: .alert)
        
        alerta.addTextField { (txt) in txt.placeholder = "Nombre" }
        alerta.addTextField { (txt) in txt.placeholder = "Teléfono" }
        alerta.addTextField { (txt) in txt.placeholder = "Dirección" }
        
        let botonGuardar = UIAlertAction(title: "Guardar", style: .default) { _ in
            guard let nombreInput = alerta.textFields?[0].text, !nombreInput.isEmpty,
                  let telefonoInput = alerta.textFields?[1].text,
                  let direccionInput = alerta.textFields?[2].text else { return }
            
            let contexto = self.conexion()
            let nuevoContacto = Contacto(context: contexto)
            
            nuevoContacto.nombre = nombreInput
            nuevoContacto.telefono = telefonoInput
            nuevoContacto.direccion = direccionInput
            
            do {
                try contexto.save()
                self.cargarInfoCoreData()
            } catch {
                print("Error: \(error)")
            }
        }
        
        let botonCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alerta.addAction(botonGuardar)
        alerta.addAction(botonCancelar)
        
        present(alerta, animated: true, completion: nil)
    }
}
