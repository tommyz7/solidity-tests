pragma solidity 0.4.17;


// import 'zeppelin-solidity/contracts/math/SafeMath.sol';
// import './DoublyLinkedListOfParticipants.sol';


contract Sale {
    // using SafeMath for uint256;
    // using SafeMath for uint32;
    // using DoublyLinkedListOfParticipants for DoublyLinkedListOfParticipants.Elements;

    // struct Participant {
    //     uint256 etherPaid;
    //     uint32 quantityOrdered;
    //     string transportationDetails;
    // }

    // bytes32 public title;
    // string public description;
    // bytes32 public image;
    // bytes32 public url;

    // // in Wei
    // uint256 public regularPrice;
    // uint256 public discountPrice;
    // uint256 public transportationPrice;

    // uint32 public targetQuantity;
    // uint32 public reservedQuantity;

    // // unix timestamps
    // uint256 public startTime;
    // uint256 public endTime;

    // DoublyLinkedListOfParticipants.Elements public participants;

    // modifier onlyActive() {
    //     require(isActive());
    //     _;
    // }

    // function Sale(
    //     bytes32 _title, 
    //     string _description, 
    //     bytes32 _image,
    //     bytes32 _url,
    //     uint256 _regularPrice,
    //     uint256 _discountPrice,
    //     uint256 _transportationPrice,
    //     uint32 _targetQuantity
    //     ) {
    //     require(_regularPrice > _discountPrice);
    //     require(_targetQuantity > 0);
    //     require(_title != "");
    //     title = _title;
    //     description = _description;
    //     image = _image;
    //     url = _url;
    //     regularPrice = _regularPrice;
    //     discountPrice = _discountPrice;
    //     transportationPrice = _transportationPrice;
    //     targetQuantity = _targetQuantity;
    // }

    // function addParticipant(
    //     address participant,
    //     uint32 quantityOrdered,
    //     string transportationDetails
    //     ) public onlyActive returns(bool) {
    //     require(discountPrice.mul(quantityOrdered) <= msg.value);
    //     require(quantityOrdered <= targetQuantity.sub(reservedQuantity));
    //     // participants.addElement(
    //     //     participant,
    //     //     Participant({
    //     //         etherPaid: msg.value,
    //     //         quantityOrdered: quantityOrdered,
    //     //         transportationDetails: transportationDetails
    //     //     })
    //     // );
    //     return true;
    // }

    // function removeParticipant(address participant) public returns (bool) {
    //     return participants.removeElement(participant);
    // }

    // function isActive() public constant returns(bool) {
    //     return startTime < now && now < endTime;
    // }
}


// contract BuyItTogetherDB {
    // address[] public sales;

    /**
     * @dev Adds new Sale
     * @param title title of sale
     * @return index index of added sale (ID)
     */
    // function addSale(string title) public returns (uint256 index) {
        // sales.push(new Sale());
    // }

    // function removeSale() {

    // }
// }
