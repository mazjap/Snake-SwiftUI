//
//  Queue.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 1/14/22.
//

import Foundation

protocol Queue {
    associatedtype Element
    
    var count: Int { get }
    
    @discardableResult
    mutating func push(_ element: Element) -> Bool
    mutating func pop() -> Element?
    func peek() -> Element?
}

struct ArrayQueue<Element>: Queue {
    private var data: [Element]
    
    var count: Int {
        data.count
    }
    
    mutating func push(_ element: Element) -> Bool {
        data = [element] + data
        return true
    }
    
    mutating func pop() -> Element? {
        data.popLast()
    }
    
    func peek() -> Element? {
        data.last
    }
}

struct NodeQueue<Element>: Queue { // Doubly Linked List
    private var head: Node?
    private var tail: Node?
    
    var count: Int {
        var currentNode = head
        var total = 0
        
        while let node = currentNode {
            total += 1
            currentNode = node.next
        }
        
        return total
    }
    
    mutating func push(_ element: Element) -> Bool {
        let newNode = Node(element)
        
        if let head = head {
            self.head = newNode
            newNode.next = head
        }
        
        if let tail = tail {
            tail.next = newNode
            self.tail = newNode
        } else if head != nil {
            tail = head
        } else {
            head = newNode
            tail = newNode
        }
        
        return true
    }
    
    mutating func pop() -> Element? {
        var element: Element? = nil
        
        if let tail = tail {
            if head === tail {
                element = tail.value
                self.head = nil
                self.tail = nil
            } else {
                element = tail.value
                let newTail = tail.prev
                self.tail = newTail
                newTail?.next = nil
            }
        }
        
        return element
    }
    
    func peek() -> Element? {
        return tail?.value
    }
}

extension NodeQueue {
    class Node {
        var value: Element
        
        var next: Node? {
            didSet {
                next?.prev = self
            }
        }
        
        var prev: Node? {
            didSet {
                prev?.next = self
            }
        }
        
        init(_ value: Element) {
            self.value = value
        }
    }
}
