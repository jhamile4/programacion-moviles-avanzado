import Foundation
import FirebaseMessaging
import UserNotifications
import Combine
import UIKit                // For UIApplication and iOS system APIs
class NotificationService: ObservableObject {
    
    @Published var lastNotification: String?
     
    // Request notification permission
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            DispatchQueue.main.async {
                if granted {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                    print("Notification permission granted")
                } else {
                    print("Notification permission denied")
                }
            }
        }
    }
    
    // Send local notification (for testing)
    // Modificado para recibir un tercer parámetro: subtitle
    func sendLocalNotification(title: String, subtitle: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle // 👈 NUEVO CAMPO: Subtítulo de la notificación
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error sending local notification: \(error)")
            } else {
                print("Local notification sent with subtitle!")
            }
        }
    }
}

