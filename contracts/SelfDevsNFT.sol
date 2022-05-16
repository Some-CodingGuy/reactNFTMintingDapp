// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract SelfDevsNFT is ERC721, Ownable{
    
    uint256 public mintPrice;               // Price of the minting process
    uint256 public totalSupply;             // Total of the already minted NFTs
    uint256 public maxSupply;               // Max amount of NFTs that will be in the collection
    uint256 public maxPerWallet;            // Max ammount someone can mint per wallet
    bool public isPublicMintEnabled;        // Is the minting enabled
    string internal baseTokenUri;           // URI of the collection of images
    address payable public withdrawWallet;  // Wallet that will contain the money going into this contract, so it can be withdrawn
    mapping(address => uint256) public walletMints; // Mapping of the amount of mints each wallet has made

    constructor() payable ERC721('SelfDevsNFT', 'SDNFT'){ // ERC721 takes 2 arguments, the name and symbol of the nfts
        mintPrice = 0.02 ether;
        totalSupply = 0;
        maxSupply = 1000;
        maxPerWallet = 5;
        // Set withdraw wallet address
    }

    function setIsPublicMintEnabled(bool _isPublicMintEnabled) external onlyOwner {     // OnlyOwner tells us that only the owner can execute this function, in this case the owner being the person deploying the contract
        isPublicMintEnabled = _isPublicMintEnabled;
    }

    function setBaseTokenUri(string calldata _baseTokenUri) external onlyOwner {
        baseTokenUri = _baseTokenUri;
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory){
        require(_exists(_tokenId), 'Token does not exist');
        return string(abi.encodePacked(baseTokenUri, Strings.toString(_tokenId), ".json"));
    }

    function withdraw() external onlyOwner{
        (bool success, ) = withdrawWallet.call{value: address(this).balance}('');
        require(success, 'Withdraw failed');
    }

    function mint(uint256 _quantity) public payable {       // payable specifies that there is a transfer of ethereum required
        require(isPublicMintEnabled, 'Minting is not yet enabled');
        require(msg.value == _quantity * mintPrice, 'Wrong mint value');    // Here we make sure that the minter is paying the right amount to mint the NFTs
        require(totalSupply + _quantity <= maxSupply, 'Sold out');  // Making sure that when we get close to the max supply, no one tries to mint over the limit
        require(walletMints[msg.sender] + _quantity <= maxPerWallet, 'Exceeded the max amount you can mint');
        
        // We will do this process _quantity times:
        //      What we here do is we take the next tokenId from the collection (ipfs://address/tokenId)
        //      We intrement the amount of the total supply (already minted NFTs)
        //      And we use the safe mint function from the ERC721 standard to safe mint the NFT to the function caller address
        
        // Note to self: when doing changes caused by certain interactions, make sure to do the changes before the interaction itself to avoid security issues
        for (uint256 i = 0; i < _quantity ; i++){
            uint256 newTokenId = totalSupply + 1;
            totalSupply++;
            _safeMint(msg.sender, newTokenId);
        }
    }

}