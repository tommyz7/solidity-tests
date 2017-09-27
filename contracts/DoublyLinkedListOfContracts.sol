pragma solidity ^0.4.15;


contract DoublyLinkedListOfContracts {
    bytes32 public head;
    bytes32 public tail;
    uint256 public size;
    // store all contracts here
    mapping(bytes32 => Element) public elements;

    struct Element {
        bytes32 previous;
        bytes32 next;
        address data;
    }

    function contracts(bytes32 key) public returns (address) {
        return elements[key].data;
    }

    function _addElement(bytes32 key, address value) internal returns (bool success) {
        Element storage elem = elements[key];
        if (elem.data != 0) {
            return false;
        }

        if (size == 0) {
            head = key;
            tail = key;
        } else {
            elements[head].next = key;
            elem.previous = head;
            head = key;
        }
        elem.data = value;
        size++;
        return true;
    }

    function _removeElement(bytes32 key)
            internal
            returns (bool success, address removedAddr) {
        Element storage elem = elements[key];
        if (size == 0 || elem.data == 0) {
            return (false, 0x0);
        } else if (size == 1) {
            head = 0x0;
            tail = 0x0;
        } else if (key == head) {
            head = elem.previous;
        } else if (key == tail) {
            tail = elem.next;
        } else {
            elements[elem.previous].next = elem.next;
            elements[elem.next].previous = elem.previous;
        }
        removedAddr = elem.data;
        delete elements[key];
        size--;
        success = true;
    }
}