//
//  AlertItem.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 08.01.2025.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    // MARK: - Network Alerts
    static let invalidURL = AlertItem(title: Text("Ошибка"),
                                      message: Text("Ошибка соединения с сервером. Обратитесь в поддержку."),
                                      dismissButton: .default(Text("OK")))
    static let invalidResponse = AlertItem(title: Text("Ошибка"),
                                           message: Text("Некорректный ответ от сервера."),
                                           dismissButton: .default(Text("OK")))
    static let invalidData = AlertItem(title: Text("Ошибка"),
                                       message: Text("Получены некорректные данные."),
                                       dismissButton: .default(Text("OK")))
    static let unableToComplete = AlertItem(title: Text("Ошибка"),
                                            message: Text("Не можем выполнить запрос, проверьте соединение с интернетом."),
                                            dismissButton: .default(Text("OK")))
}
