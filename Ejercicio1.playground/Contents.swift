import Foundation

let CALORIAS_DORMIR = 1.08
let CALORIAS_REPOSO = 1.66

let actividad = "reposo"
let tiempoInput = 180

guard actividad == "dormir" || actividad == "reposo" else {
    print("Error: Actividad invalida. Solo se permite 'dormir' o 'reposo'.")
    fatalError()
}

guard tiempoInput > 0 else {
    print("Error: El tiempo debe ser un numero entero positivo.")
    fatalError()
}

let tiempo = Double(tiempoInput)
let tasaCalorica = actividad == "dormir" ? CALORIAS_DORMIR : CALORIAS_REPOSO
let caloriasConsumidas = tasaCalorica * tiempo

print("Actividad: \(actividad.uppercased())")
print("Tiempo: \(tiempoInput) minutos")
print("Calorias consumidas: \(caloriasConsumidas)")
