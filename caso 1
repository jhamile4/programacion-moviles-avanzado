import Foundation

let paises = ["Argentina", "Bolivia", "Brasil", "Chile", "Colombia",
              "Ecuador", "México", "Perú", "Paraguay", "Uruguay", "Venezuela"]

var gdp2025: [Double] = [683.371, 57.086, 2256.910, 347.174, 438.121,
                         130.529, 1862.740, 318.480, 47.398, 84.986, 82.767]

let gdp2026: [Double] = [667.922, 0, 2292.690, 363.299, 462.251,
                         134.711, 2030.999, 326.608, 51.669, 90.640, 79.916]

print("ACCEDER A ELEMENTOS")
if let indexBolivia = paises.firstIndex(of: "Bolivia") {
    print("GDP de Bolivia (2025): \(gdp2025[indexBolivia]) Billones USD\n")
}

print("MODIFICAR ELEMENTOS")

if let indexPeru = paises.firstIndex(of: "Perú") {
    gdp2025[indexPeru] = gdp2026[indexPeru]
    print("GDP de Perú actualizado (2026): \(gdp2025[indexPeru]) Billones USD")

    gdp2025[indexPeru] = 318.480
    print("GDP de Perú restaurado (2025): \(gdp2025[indexPeru]) Billones USD\n")
}

print("CÁLCULO DE PROMEDIO")

let promedioReduce = gdp2025.reduce(0, +) / Double(gdp2025.count)
print("Promedio del GDP (método reduce): \(String(format: "%.3f", promedioReduce)) Billones USD\n")

print("GDP MÁS ALTO")
if let maxGDP = gdp2025.max(),
   let indexMax = gdp2025.firstIndex(of: maxGDP) {
    print("País con GDP más alto: \(paises[indexMax])")
    print("GDP máximo: \(maxGDP) Billones USD\n")
}

print("FILTRAR PAÍSES CON GDP > 300 BILLONES")

let paisesConGDP = Array(zip(paises, gdp2025))

let paisesFiltrados = paisesConGDP.filter { $0.1 > 300 }

for (pais, gdp) in paisesFiltrados {
    print("  - \(pais): \(gdp) Billones USD")
}
print()

print("ORDENAR PAÍSES POR GDP")

let paisesOrdenados = paisesConGDP.sorted { $0.1 < $1.1 }

for (index, (pais, gdp)) in paisesOrdenados.enumerated() {
    print("  \(index + 1). \(pais): \(gdp) Billones USD")
}
print()

struct Inca: Hashable, Equatable {
    let nombre: String
}

print("LISTA DE INCAS DEL IMPERIO INCAICO")

let incasSet: Set<Inca> = [
    Inca(nombre: "Manco Cápac"),
    Inca(nombre: "Sinchi Roca"),
    Inca(nombre: "Lloque Yupanqui"),
    Inca(nombre: "Mayta Cápac"),
    Inca(nombre: "Cápac Yupanqui"),
    Inca(nombre: "Inca Roca"),
    Inca(nombre: "Yáhuar Huácac"),
    Inca(nombre: "Viracocha Inca"),
    Inca(nombre: "Pachacútec"),
    Inca(nombre: "Túpac Yupanqui"),
    Inca(nombre: "Huayna Cápac"),
    Inca(nombre: "Huáscar"),
    Inca(nombre: "Atahualpa")
]

print(" ")

for inca in incasSet.sorted(by: { $0.nombre < $1.nombre }) {
    print("  • \(inca.nombre)")
}

print()
