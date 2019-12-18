///Vamos a crear la asignación de productos, como si se trataran de zombies de criptozombies

pragma solidity ^0.4.19;

contract Creadorreferenciapaquetes {

    event NuevoPaquete(uint PaqueteId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Paquete {
        string name;
        uint dna;
    }

    Paquete[] public paquetes;

    mapping (uint => address) public paqueteToOwner;
    mapping (address => uint) ownerPaqueteCount;

    function _creacionPaquete(string _name, uint _dna) private {
        uint id = paquetes.push(Paquete(_name, _dna)) - 1;
        paqueteToOwner[id] = msg.sender;
        ownerPaqueteCount[msg.sender]++;
        NuevoPaquete(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomPaquete(string _name) public {
        require(ownerPaqueteCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _creacionPaquete(_name, randDna);
    }

}

///cOMPROBADO CON REMIX IDE

