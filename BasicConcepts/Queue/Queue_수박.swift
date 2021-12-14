//
//  Queue_수박.swift
//  AlgorithmStudy
//
//  Created by kjs on 2021/12/09.
//

import Foundation

struct Queue<AnyType> {
    private var linkedList = LinkedList()

    var head: AnyType? {
        linkedList.head?.value
    }

    var tail: AnyType? {
        linkedList.tail?.value
    }

    var isEmpty: Bool {
        linkedList.head == nil
    }

    mutating func insert(_ value: AnyType) {
        linkedList.append(value)
    }

    mutating func delete() -> AnyType? {
        defer {
            linkedList.removeFirst()
        }

        return linkedList.head?.value
    }
}


// MARK: - components
extension Queue {
    private class Node {
        private(set) var value: AnyType
        weak var prev: Node?
        var next: Node?

        init(value: AnyType, next: Node? = nil) {
            self.value = value
        }

        func updateValue(by value: AnyType) {
            self.value = value
        }
    }

    private struct LinkedList {
        private(set) var head: Node?
        private(set) weak var tail: Node?

        var isEmpty: Bool {
            return head == nil
        }

        mutating func append(_ value: AnyType) {
            let newNode = Node(value: value)

            if isEmpty {
                head = newNode
            } else {
                tail?.next = newNode
                newNode.prev = tail
            }

            tail = newNode
        }

        var target: Node? {
            return head?.next
        }

        mutating func remove(target: Node?) {
            var targetToDelete = head

            while target !== targetToDelete {
                targetToDelete = targetToDelete?.next
            }

            if let previousNode = targetToDelete?.prev {
                previousNode.next = targetToDelete?.next
                previousNode.next?.prev = previousNode
            } else {
                head = targetToDelete?.next
            }
        }

        mutating func removeFirst() {
            head = head?.next
        }

        mutating func removeLast() {
            tail = tail?.prev
            tail?.next = nil
        }

        init() { }

        init(headValue: AnyType) {
            self.append(headValue)
        }
    }
}
