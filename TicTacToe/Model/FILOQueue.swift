//
//  FILOQueue.swift
//  TicTacToe
//
//  Created by Dominik on 27/05/2025.
//


struct FILOQueue<T> {
    private var elements: [T] = []

    // Dodawanie na początek
    mutating func enqueue(_ element: T) {
        elements.insert(element, at: 0)
    }

    // Usuwanie z końca (ostatni element w tablicy)
    mutating func dequeue() -> T? {
        guard !elements.isEmpty else { return nil }
        return elements.popLast()
    }

    // Dostęp do pierwszego (czyli najnowszego)
    var first: T? {
        elements.first
    }

    // Dostęp do ostatniego (czyli najstarszego)
    var last: T? {
        elements.last
    }

    func isEmpty() -> Bool {
        elements.isEmpty
    }

    func size() -> Int {
        elements.count
    }
}