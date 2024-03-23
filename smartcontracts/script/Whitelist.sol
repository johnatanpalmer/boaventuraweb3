// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Whitelist {
    address public owner;
    mapping(address => bool) public whitelist;

    event AddressAdded(address indexed wallet);
    event AddressRemoved(address indexed wallet);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Apenas o proprietario pode chamar esta funcao");
        _;
    }

    function addToWhitelist(address wallet) external onlyOwner {
        require(wallet != address(0), "O endereco da carteira e invalido");
        require(!whitelist[wallet], "O endereco ja esta no cadastro de beneficiarios");
        whitelist[wallet] = true;
        emit AddressAdded(wallet);
    }

    function removeFromWhitelist(address wallet) external onlyOwner {
        require(whitelist[wallet], "O endereco nao faz mais parte do cadastro de beneficiarios");
        whitelist[wallet] = false;
        emit AddressRemoved(wallet);
    }

    function isWhitelisted(address wallet) external view returns (bool) {
        return whitelist[wallet];
    }
}