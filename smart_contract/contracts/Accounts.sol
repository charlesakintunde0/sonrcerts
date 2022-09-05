// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Account {
    // account type enum'
    enum AccountType {Verifier, Requester}


    // account struct
    struct account {
        string name;
        string email;
        AccountType accountType;
        uint verificationPrice;
    }

    event Registered (address user);

    address public owner;
    address[] private verifiers;
    mapping (address => account) private accounts;


    modifier addVerifier(AccountType _aType)
    {
        _;
        if(_aType == AccountType.Verifier){
            bool found = false;
            for (uint i=0; i<verifiers.length; i++){
                if (msg.sender == verifiers[i]){
                found = true;
                    break;
                }
            }
            if(!found){
                verifiers.push(msg.sender);
            }
        }
    }

    constructor()
    {
        owner = msg.sender;
    }


    function register(string memory _name,string memory _email, AccountType _aType, uint price)
    public 
    payable
    addVerifier(_aType)
    {
        emit Registered(msg.sender);
        accounts[msg.sender] = account({
            name: _name,
            email: _email,
            accountType: _aType,
            verificationPrice: price
        });
    }

    function getAccount()
    public
    view
    returns (string memory name, string memory email, AccountType aType,uint price)
    {
        name = accounts[msg.sender].name;
        email = accounts[msg.sender].email;
        aType = accounts[msg.sender].accountType;
        price = accounts[msg.sender].verificationPrice;

        return (name,email,aType,price);
    }

    function verifiersCount()
    public
    view
    returns (uint total) {
        return verifiers.length;
    }

    function getVerifier(uint pIndex)
    public 
    view
    returns (address verifier, string memory name, string memory email, AccountType aType, uint price)
    {
        address verifierAddr = verifiers[pIndex];
        name = accounts[verifierAddr].name;
        email = accounts[verifierAddr].email;
        aType = accounts[verifierAddr].accountType;
        price = accounts[verifierAddr].verificationPrice;


        return (verifierAddr,name,email,aType,price);
    }


    function getPrice(address _account)
    public
    view
    returns(uint price){
        return (accounts[_account].verificationPrice);
    }


    // function kill()
    // public{
    //     if (msg.sender == owner) selfdestruct(owner);
    // }


    
}