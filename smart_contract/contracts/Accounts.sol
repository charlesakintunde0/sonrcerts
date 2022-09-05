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

    address private owner;
    address[] private verifiers;
    mapping (address => account) private accounts;


    modifier addVerifier(AccountType _aType)
    {
        _;
        if(_aType == AccountType.Verifier){
            bool found = false;
            for (uint i=0; i<verifiers.length, i++){
                if (msg.sender == verifiers[i]){
                    found true;
                    break;
                }
            }
            if(!found){
                verifiers.push(msg.sender);
            }
        }
    }

    constructor()
    public
    {
        owner = msg.sender;
    }


    function register(string _name,)
    
}