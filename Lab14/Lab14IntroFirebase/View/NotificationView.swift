import SwiftUI

struct NotificationView: View {
    @StateObject private var notificationService = NotificationService()
    @State private var notificationTitle = "¡Hola!"
    @State private var notificationSubtitle = "Actualización importante" // 👈 NUEVO CAMPO: Subtítulo de la tarea
    @State private var notificationBody = "Esta es una notificación de prueba"
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Push Notifications")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary) // Se adapta a modo claro/oscuro
            
            // Contenedor de la Notificación de Prueba
            VStack(spacing: 15) {
                Text("Test Notifications")
                    .font(.headline)
                    .foregroundColor(.primary) // Cambiado a color primario
                
                TextField("Notification Title", text: $notificationTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(.black) // Mantiene texto visible en los inputs
                
                // 👈 NUEVO CAMPO DE LA TAREA
                TextField("Notification Subtitle", text: $notificationSubtitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(.black)
                
                TextField("Notification Body", text: $notificationBody)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(.black)
                
                Button(action: {
                    // 👈 ENVIAMOS LOS TRES CAMPOS AL SERVICIO
                    notificationService.sendLocalNotification(
                        title: notificationTitle,
                        subtitle: notificationSubtitle,
                        body: notificationBody
                    )
                }) {
                    Text("Send Test Notification")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple) // 🎨 NUEVO COLOR: Botón Morado llamativo
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 5)
            }
            .padding()
            // 🎨 NUEVO COLOR DE FONDO: Gris elegante translúcido (en lugar del azul fuerte)
            .background(Color(UIColor.systemGroupedBackground))
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2) // Sombra sutil
            
            Spacer()
        }
        .padding()
        .onAppear {
            notificationService.requestNotificationPermission()
        }
    }
}

#Preview {
    NotificationView()
}
