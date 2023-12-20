//SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

contract MyContract {
    uint public a;
    uint public b;

    function setDetails(uint _a, uint _b) external {
        a = _a;
        b = _b;
    }

    function sub() public view returns (uint) {
        if (a > b) {
            return a - b;
        } else {
            return b - a;
        }
    }
}

contract ExampleContract {
    function sub(uint a, uint b) public pure returns (uint) {
        if (a > b) {
            return a - b;
        } else {
            return b - a;
        }
    }
}

contract Inbox {
    string message;

    function setMessage(string calldata _message) public {
        message = _message;
    }

    function getMessage() public view returns (string memory) {
        return message;
    }

    function getLength() public view returns (uint) {
        return bytes(message).length;
    }
}

contract CheckAddress {
    function checkEqual(
        address _acc1,
        address _acc2
    ) public pure returns (bool) {
        return (_acc1 == _acc2);
    }

    function getBalance(address _account) public view returns (uint) {
        return _account.balance;
    }
}

contract BytesArray {
    bytes1 a = 0x12;
    bytes2 b = 0x1234;

    function compare() public view returns (bool) {
        return b > a;
    }

    function bitOperations() public view returns (bytes2) {
        return a & b;
    }

    function leftShift() public view returns (bytes1) {
        return a << 1;
    }

    function returnAtIndex(uint _index) public view returns (bytes1) {
        return b[_index];
    }
}

contract Array {
    uint[] public numArray = [1, 2, 3, 4, 5];

    function arrayLength() public view returns (uint) {
        return numArray.length;
    }

    function elementByIndex(uint i) public view returns (uint) {
        return numArray[i];
    }

    function addValue(uint n) public {
        numArray.push(n);
    }

    function popValue() public {
        numArray.pop();
    }
}

contract Struct {
    struct Student {
        string name;
        uint roll_num;
        bool qualified;
    }

    Student[] public students;

    function addStudent(
        string calldata _name,
        uint _roll_num,
        bool _qualified
    ) public {
        students.push(Student(_name, _roll_num, _qualified));
        // students.push(Student({roll_num: _roll_num, name: _name, qualified: _qualified}));
    }
}

contract Enum {
    enum playerLevel {
        Beginner,
        Intermediate,
        Advanced
    }

    playerLevel public level;

    function setLevel(playerLevel _level) public {
        level = _level;
    }

    function getLevel() public view returns (playerLevel) {
        return level;
    }
}

contract Mappinngs {
    mapping(address => uint) public balances;

    function setBalance(address _address, uint _balance) public {
        balances[_address] = _balance;
    }

    function getBalance(address _address) public view returns (uint) {
        return balances[_address];
    }
}

contract ValueTypeVariables {
    uint num = 2;

    function modify(uint _val) public pure returns (uint) {
        _val = _val + 1;
        return _val;
    }

    function modifyNum() public view returns (uint) {
        return modify(num);
    }

    function getNum() public view returns (uint) {
        return num;
    }
}

contract RequireRevertAssert {
    uint x = 1;
    uint y = 2;
    address owner = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    function Require() public view {
        require(msg.sender == owner, "You must be the owner!");
    }

    function Revert() public view {
        if (msg.sender != owner) {
            revert("You must be owner!");
        }
    }

    function Assert() public view {
        assert(x + y == 3);
    }
}

contract Modifier {
    address owner = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address a;
    address b;
    address c;
    uint count;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
        count++;
    }

    function example1() public onlyOwner {
        a = msg.sender;
    }

    function example2() public onlyOwner {
        b = msg.sender;
    }

    function example3() public onlyOwner {
        c = msg.sender;
    }
}

contract ConstructorExample {
    uint public price;
    address public owner;

    constructor(uint _price) {
        price = _price;
        owner = msg.sender;
    }

    function changePrice(uint _price) public {
        require(msg.sender == owner);
        price = _price;
    }

    function getPrice() public view returns (uint) {
        return price;
    }
}

contract Event {
    event ProductAdded(uint productId, uint productPrice);

    // mapping(uint => uint) public ProductAdded;

    function addProduct(uint _productId, uint _productPrice) public {
        emit ProductAdded(_productId, _productPrice);
        // ProductAdded[_productId] = _productPrice;
    }
}

contract InheritanceParent {
    uint public num = 10;

    function increment() public {
        num++;
    }
}

contract InheritanceChild is InheritanceParent {
    function decrement() public {
        num--;
    }

    // function incrementAndDecrement() public {
    //     increment();
    //     decrement();
    // }
}

contract Visibility {
    uint public num = 10;
    string internal str = "hello";
    address myAdd = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    function publicFunc() public view returns (uint) {
        return num;
    }

    function privateFunc() private view returns (uint) {
        return num;
    }

    function internalFunc() internal view returns (uint) {
        return num;
    }

    function externalFunc() external view returns (uint) {
        return num;
    }
}

contract VisibilityChild is Visibility {
    function testInternalVariable() public view returns (string memory) {
        return str;
    }

    function testInternalFunction() public view returns (uint) {
        uint x = internalFunc();
        return x;
    }
}

contract Payable {
    bool paid;
    //  bool sent;
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function payment() public payable {
        require(msg.value == 0 ether, "Amount not sufficient!");
        paid = true;
    }

    //   function withdraw() public {
    //      require(msg.sender == owner, "Only owner can withdraw!");
    //      owner.transfer(address(this).balance);
    //   }

    // // SEND
    //   function withdraw() public {
    //     require(msg.sender == owner, "Only owner can execute withdrawal!");
    //     bool sent = owner.send(address(this).balance);
    //     require(sent, "Failure to send Ether.");
    //   }

    // // CALL
    function withdraw() public {
        require(msg.sender == owner, "You must be the owner!");
        (bool sent, ) = owner.call{value: address(this).balance}("");
        require(sent, "Failure to send Ether.");
    }
}
