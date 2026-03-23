
import Foundation
func funcB(_ nombre: String) -> Bool {
    return nombre == "UNI"
}
func funcC(_ nombre: String) -> Bool {
    return nombre == "UNAL"
}
func funcD(_ nombre: String) -> Bool {
    return nombre == "UPM"
}
func funcA(_ nombre: String, _ intentosRestantes: Int) {
    
    if intentosRestantes == 0 {
        print("No se encontró '\(nombre)'. Se superó el límite de intentos.")
        return
    }
    if nombre == "TECSUP" || nombre == "MIT" {
        print("Encontrado '\(nombre)' en FUNC A")
        return
    }
    if intentosRestantes == 2 && funcB(nombre) {
        print("Encontrado '\(nombre)' en FUNC B")
        return
    }
    if intentosRestantes == 1 && funcC(nombre) {
        print("Encontrado '\(nombre)' en FUNC C")
        return
    }
    
    funcA(nombre, intentosRestantes - 1)
}
funcA("UPM", 2)
funcA("UNI", 2)
funcA("TECSUP", 2)
funcA("UNAL", 2)
