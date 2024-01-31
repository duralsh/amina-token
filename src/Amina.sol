// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Amina is ERC20 {
    uint256 public maxSupply;
    address public taxAddress;
    uint256 public constant TAX_PERCENTAGE = 1;

    constructor(string memory _name, string memory _symbol, uint256 _maxSupply, address _taxAddress) 
        ERC20(_name, _symbol) 
    {
        maxSupply = _maxSupply;
        taxAddress = _taxAddress;
    }

    function mint(address to, uint256 amount) public virtual {
        require(totalSupply() + amount <= maxSupply, "Max supply exceeded");
        _mint(to, amount);
    }

    function burn(address from, uint amount) public virtual {
        _burn(from, amount);
    }

    function _update(address sender, address recipient, uint256 amount) internal virtual override {
        uint256 tax = (amount * TAX_PERCENTAGE) / 100;
        uint256 amountAfterTax = amount - tax;

        super._update(sender, taxAddress, tax);
        super._update(sender, recipient, amountAfterTax);
    }
}
