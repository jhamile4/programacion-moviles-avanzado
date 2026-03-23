let capitalInicial: Double = 50000
print("Ingresa la tasa de interés (ej: 0.08): ", terminator: "")

if let input = readLine(), let tasaInteres = Double(input) {
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
} else {
    print("Tasa inválida")
}

print("\nPresiona Enter para salir...")
_ = readLine()

