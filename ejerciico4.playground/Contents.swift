import Foundation

let capitalInicial: Double = 50000.0

// En lugar de readLine(), asignamos el valor directamente para probar
let inputSimulado = "0.15" // Cambia este número para probar diferentes casos

if let tasaInteres = Double(inputSimulado) {
    let intereses = capitalInicial * tasaInteres
    print("Intereses generados: $\(intereses)")
    
    var capitalFinal = capitalInicial
    
    if intereses > 7000 {
        capitalFinal += intereses
        print("Los intereses superan $7000. Se reinvierten.")
    } else {
        print("Los intereses no superan $7000. No se reinvierten.")
    }
    
    print("Capital final en la cuenta: $\(capitalFinal)")
}
