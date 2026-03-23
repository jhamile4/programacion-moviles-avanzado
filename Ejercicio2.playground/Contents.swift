import Foundation

func calcularPago(precioUnitario: Double, cantidad: Int, descuento: Double) -> Double {
    let subtotal = precioUnitario * Double(cantidad)
    let montoDescuento = subtotal * (descuento / 100)
    let pagoTotal = subtotal - montoDescuento
    return pagoTotal
}

let precioUnitario = 50.0
let cantidad = 4
let descuento = 10.0

let subtotal = precioUnitario * Double(cantidad)
let montoDescuento = subtotal * (descuento / 100)
let pagoTotal = calcularPago(precioUnitario: precioUnitario, cantidad: cantidad, descuento: descuento)

print("Precio unitario: \(precioUnitario)")
print("Cantidad: \(cantidad)")
print("Subtotal: \(subtotal)")
print("Descuento: \(descuento)%")
print("Monto descuento: \(montoDescuento)")
print("Pago total: \(pagoTotal)")

