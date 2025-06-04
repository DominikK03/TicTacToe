//
//  FILOQueue.swift
//  TicTacToe
//
//  Created by Dominik on 27/05/2025.
//


struct FILOQueue<T> {
    private var elements: [T] = []

    mutating func enqueue(_ element: T) {
        elements.insert(element, at: 0)
    }

    mutating func dequeue() -> T? {
        guard !elements.isEmpty else { return nil }
        return elements.popLast()
    }

    var first: T? {
        elements.first
    }

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
