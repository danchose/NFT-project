//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
//идея ERC721 в том что есть токены и их владельцы, и они могут передавать их

contract NFT is ERC721Enumerable, Ownable {
    //uint256 => string
    using Strings for uint256;
    uint256 maxSupply = 8; //кол-во нфтшок 8 максимум
    uint256 cost = 0.001 ether; //0.001 BNB цена его
    string baseURI = "ipfs://QmcQJw8CvPhtqVxFahQ5KM5owZ5iCY4Be9g1gQCM7PbQhr/"; //место где хранить наши нфтишки
    //надо ссылаться на ipfs сразу так как pinata итд могут упасть, а сам ipfs не упадет
    //server
    //IPFS - это децентрализованный способ хранение, pinata один из гейтуейов для IPFS
    //onchain



    constructor() ERC721("HumanCrypto", "HC") {
        
    }
    //если функция существует уже, тогда надо писать override
    function _baseURI() internal override view returns (string memory) {
        return baseURI;
    }

    function tokenURI(uint256 tokenId) public override view returns (string memory){
        _requireMinted(tokenId);
        return bytes(baseURI).length > 0 
            ? 
            //для того что объединить два string => abi.encodePacked
            string(abi.encodePacked(baseURI, tokenId.toString(), ".json"))
            : "";
    } 

    function changeBaseURI(string memory _newBaseURI) public onlyOwner{
        baseURI = _newBaseURI;
    }

    function safeMint(address _to) public payable{
        uint256 _currentSupply = totalSupply();
        require(_currentSupply < maxSupply, "You reached max supply");
        require(msg.value == cost, "Please add valid amount in BNB");
        _safeMint(_to, _currentSupply); //Mint это чеканка монет, создает из ниоткуда монеты
    }
    function withdraw() public onlyOwner{
        (bool success, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(success);
    }
}



