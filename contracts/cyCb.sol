pragma solidity ^0.8.0;

contract IDSERC721{
    // Token name
    string  _nameNFT;

    // Token symbol
    string  _symbolNFT;

    // Mapping from token ID to owner address
    mapping(uint256 => address)  _owners;

    // Mapping owner address to token count
    mapping(address => uint256)  _balancesNFT;

    event TransferNFT(address, address, uint256);
    /**
     * @dev Initializes the contract by setting a `name` and a `symbol` to the token collection.
     */
    constructor() {
        _nameNFT = "IDSNFTTOKEN";
        _symbolNFT = "IDSNFT";
    }
        function mintNFT(address to, uint256 tokenId) internal virtual {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");

        _balancesNFT[to] += 1;
        _owners[tokenId] = to;

        emit TransferNFT(address(0), to, tokenId);

    }

        function transferNFT(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual {
        require(ownerOfNFT(tokenId) == from, "ERC721: transfer from incorrect owner");
        require(to != address(0), "ERC721: transfer to the zero address");

        _balancesNFT[from] -= 1;
        _balancesNFT[to] += 1;
        _owners[tokenId] = to;

        emit TransferNFT(from, to, tokenId);
    }

        /**
     * @dev See {IERC721-balanceOf}.
     */
    function balanceOfNFTOwner(address owner) public view virtual  returns (uint256) {
        require(owner != address(0), "ERC721: balance query for the zero address");
        return _balancesNFT[owner];
    }

        /**
     * @dev See {IERC721-ownerOf}.
     */
    function ownerOfNFT(uint256 tokenId) public view virtual  returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");
        return owner;
    }

    /**
     * @dev See {IERC721Metadata-name}.
     */
    function nameOfNFT() public view virtual  returns (string memory) {
        return _nameNFT;
    }

    /**
     * @dev See {IERC721Metadata-symbol}.
     */
    function symbolOfNFT() public view virtual  returns (string memory) {
        return _symbolNFT;
    }
    
     /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view virtual  returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = "";
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId)) : "";
    }
        
     /**
     * @dev Destroys `tokenId`.
     * The approval is cleared when the token is burned.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     *
     * Emits a {Transfer} event.
     */
    function _burn(uint256 tokenId) internal virtual {
        address owner = ownerOfNFT(tokenId);

        _balancesNFT[owner] -= 1;
        delete _owners[tokenId];

        emit TransferNFT(owner, address(0), tokenId);

    }

     /**
     * @dev Returns whether `tokenId` exists.
     *
     * Tokens can be managed by their owner or approved accounts via {approve} or {setApprovalForAll}.
     *
     * Tokens start existing when they are minted (`_mint`),
     * and stop existing when they are burned (`_burn`).
     */
    function _exists(uint256 tokenId) internal view virtual returns (bool) {
        return _owners[tokenId] != address(0);
    }
    }