import Foundation
func funcB(_ nombre: String) -> Bool {
    return nombre == "UNI"
}

func funcC(_ nombre: String) -> Bool {
    return nombre == "UNALM"
}

func funcD(_ nombre: String) -> Bool {
    return nombre == "UPN"
}

func funcA(_ nombre: String, _ maxLlamadas: Int) {
    if nombre == "TECSUP" || nombre == "MIT" {
        print("Encontrado '\(nombre)' en FUNC A")
        return
    }
    
    if maxLlamadas >= 2 && funcB(nombre) {
        print("Encontrado '\(nombre)' en FUNC B")
        return
    }
    
    if maxLlamadas >= 3 && funcC(nombre) {
        print("Encontrado '\(nombre)' en FUNC C")
        return
    }
    
    if maxLlamadas >= 4 && funcD(nombre) {
        print("Encontrado '\(nombre)' en FUNC D")
        return
    }
    
    print("No se encontro '\(nombre)'. Se supero el limite de \(maxLlamadas) llamadas.")
}
funcA("UPN", 2)
funcA("TECSUP,2)
