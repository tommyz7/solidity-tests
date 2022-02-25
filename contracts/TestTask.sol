// Copyright SECURRENCY INC.
// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;
pragma experimental ABIEncoderV2;

// import "remix_tests.sol"; // this import is automatically injected by Remix.

/// File containe 3 smart contracts.
/// - TestTask for tasks solutions (2 task to be solved)
/// - Task1Test tests for task 1
/// - Task2Test tests for task 2

/// To check your's results, please deploy a smart contract with tests related to
/// to the task and run a functions. Each call will emit an event with test details.
/// To be sure that your solution work's properly, pay your attention to the
/// "passed" field in the log output, it must be equal to "true".
/// "passed": true - expected result for all tests.


/**
 * @title Solidity test task 1
 */
contract TestTask {

    ///             ///
    ///    Task 1   ///
    ///             ///

    /// @notice https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Strings.sol
    function uintToString(uint256 value) internal pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT licence
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    /// @notice https://ethereum.stackexchange.com/questions/8346/convert-address-to-string
    function addressToString(address account) public pure returns(string memory) {
        bytes memory data = abi.encodePacked(account);

        bytes memory alphabet = "0123456789abcdef";
        bytes memory str = new bytes(data.length * 2);
        for (uint i = 0; i < data.length; i++) {
            str[i*2] = alphabet[uint8(data[i] >> 4)];
            str[1+i*2] = alphabet[uint8(data[i] & 0x0f)];
        }

        return string(bytes.concat("0x", checksumEncode(str)));
    }

    /// @notice https://eips.ethereum.org/EIPS/eip-55
    function checksumEncode(bytes memory addr) public pure returns (bytes memory) {
        bytes32 hashedAddress = keccak256(addr);

        for (uint i = 0; i < addr.length; i++) {
            uint8 hashVal;
            if (i % 2 == 0) {
                // hi
                hashVal = uint8(hashedAddress[i/2] >> 4);
            } else {
                // lo
                hashVal = uint8(hashedAddress[i/2] & 0x0f);
            }

            // if it's not a number and the corresponding hex digit (nibble) is > 7, make upper
            if (uint8(addr[i]) > 58 && hashVal > 7) {
                addr[i] = bytes1(uint8(addr[i]) - 32);
            }
        }

        return addr;
    }

    /**
     * @dev Test task condition:
     * @dev by a condition, a function getString accepts some template
     * @dev and we agreed that {account} in the template must be
     * @dev replaced by an "account" variable from the function,
     * @dev "{number}" must be replaced by a "number" variable
     * @dev Example
     * @dev template = "Example: {account}, {number}"
     * @dev result = "Example: 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c, 1250"
     *
     * @notice You can see more examples in a tests.
     *
     * @return result Updated template by a task condition
     */
    function buildStringByTemplate(string calldata template) external pure returns (string memory) {
        // 0x4549502d3535
        address account = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;
        uint number = 1250;
        // I don't see any use for that variable so it's commented
        // string memory result;

        /**
         * Write your code here
         * Try to do with the lowest gas consumption.
         * If you will use some libraries or ready solutions,
         * please add links in the "notice" comments section before the function.
         */

        bytes calldata _template = bytes(template);
        uint256 templateLength = _template.length;

        bytes memory accountTemplate = bytes("{account}");
        bytes32 accountTemplateHash = keccak256(accountTemplate);

        bytes memory numberTemplate = bytes("{number}");
        bytes32 numberTemplateHash = keccak256(numberTemplate);

        bytes memory completed = new bytes(0);
        uint256 startIndex = 0;

        for (uint256 i = 0; i < templateLength; i++) {
            // check account
            if (i + accountTemplate.length <= templateLength) {
                if (keccak256(_template[i:i+accountTemplate.length]) == accountTemplateHash) {
                    // match found

                    completed = bytes.concat(completed, _template[startIndex:i], bytes(addressToString(account)));

                    i = i + accountTemplate.length - 1;
                    startIndex = i + 1;
                }
            }

            // check number
            if (i + numberTemplate.length <= templateLength) {
                if (keccak256(_template[i:i+numberTemplate.length]) == numberTemplateHash) {
                    // match found

                    completed = bytes.concat(completed, _template[startIndex:i], bytes(uintToString(number)));

                    i = i + numberTemplate.length - 1;
                    startIndex = i + 1;
                }
            }
        }

        completed = bytes.concat(completed, _template[startIndex:templateLength]);

        return string(completed);
    }

    ///             ///
    ///    Task 2   ///
    ///             ///

    function getSlice(bytes memory word, uint256 start, uint256 end) public pure returns (bytes memory result) {
        if (start >= end) {
            return new bytes(0);
        }

        uint256 resultLength = end - start;
        result = new bytes(resultLength);

        for (uint256 i = 0; i < resultLength; i++) {
            result[i] = word[i + start];
        }
    }

    /**
     * @dev Test task condition 2:
     *
     * @dev Write a function which takes an array of strings as input and outputs
     * @dev with one concatenated string. Function also should trim mirroring characters
     * @dev of each two consecutive array string elements. In two consecutive string elements
     * @dev "apple" and "electricity", mirroring characters are considered to be "le" and "el"
     * @dev and as a result these characters should be trimmed from both string elements,
     * @dev and concatenated string should be returned by the function. You may assume that
     * @dev array will consist of at least of one element, each element won't be an empty string.
     * @dev You may also assume that each element will contain only ascii characters.
     *
     * @dev Example 1
     * @dev input:  "apple", "electricity", "year"
     * @dev output: "appectricitear"
     *
     * @notice You can see more examples in a Task2Test smart contract.
     *
     * @return result Minimized string by a task condition
     */
    function trimMirroringChars(string[] memory data) public pure returns (string memory) {
        string memory result;

        /**
        * Write your code here
        * Try to do with the lowest gas consumption.
        * If you will use some libraries or ready solutions,
        * please add links in the "notice" comments section before the function.
        */

        uint256 matchPrev;

        for (uint256 i = 0; i < data.length - 1; i++) {
            bytes memory word1 = bytes(data[i]);
            bytes memory word2 = bytes(data[i+1]);

            uint256 shorterWordLength = word1.length < word2.length ? word1.length : word2.length;
            uint256 matchLength = 0;

            for (uint256 j = 0; j < shorterWordLength; j++) {
                if (word1[word1.length - 1 - j] == word2[j]) {
                    matchLength = j + 1;
                } else {
                    break;
                }
            }

            // if all word is a match, there is nothing to add to result
            if (matchLength < word1.length) {
                result = string(bytes.concat(
                    bytes(result),
                    getSlice(word1, matchPrev, word1.length - matchLength)
                ));
            }

            // on last run add word2 as well because we are matching just front of that word
            if (i == data.length - 2) {
                // if all word is a match, there is nothing to add to result
                if (matchLength < word2.length) {
                    result = string(bytes.concat(
                        bytes(result),
                        getSlice(word2, matchLength, word2.length)
                    ));
                }
            }

            matchPrev = matchLength;
        }

        return result;
     }
}
