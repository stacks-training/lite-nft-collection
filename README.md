
# Documentation

## auth contract

### 1. Login 

Overview
The login function is responsible for authenticating a user based on their address. If the user does not exist, it will register the user and return a success message. If the user already exists, it will simply return a success message.

#### Function Signature

```
(define-public (login (user-address principal) (user-picture (string-utf8 256)))
```

Parameters
- user-address (principal): The unique address of the user attempting to log in. This is a required parameter.
- user-picture (string-utf8 256): The picture associated with the user. This is also a required parameter and is used for registration if the user does not exist.

Returns

- Success: If the user exists or is successfully registered, the function returns:
ok "Login successful": A success message indicating that the login was successful.
- Error: If the user does not exist and registration fails, the function returns:
err ERR_USER_ALREADY_EXISTS: An error indicating that the user already exists (this should not occur in normal operation since the existence is checked before registration).


### 2. Get user data

Overview
The get-user-data function retrieves the data associated with a specific user based on their address. It checks if the user exists in the system and returns the corresponding user data or an error if the user does not exist.

#### Function Signature

```
(define-read-only (get-user-data (user-address principal))
```

Parameters
- user-address (principal): The unique address of the user whose data is being requested. This is a required parameter.

Returns
- Success: If the user exists, the function returns:
- ok user-data: The user data associated with the provided address, which includes details such as the user's picture and address.
- Error: If the user does not exist, the function returns:
- err ERR_USER_NOT_EXIST: An error indicating that the user does not exist in the system.


----

## collection contract
Overview
The NFT Collection Contract is designed to manage a collection of Non-Fungible Tokens (NFTs) on the Stacks blockchain. This contract allows users to create, store, and retrieve NFTs associated with specific addresses (principals). Each NFT has attributes such as name, logo, and address.

### 1. create-collections

Overview:

The create-collection function allows users to create a new NFT collection within the contract. This function initializes a collection with specified attributes and associates it with the user's address (principal). It ensures that each collection is unique and properly registered in the contract's state.

Signature:
```
(define-public (create-collection (name (string-ascii 100)) (description (string-ascii 256)) (logo (string-ascii 256)))
``` 

Parameters
- name (string-ascii 100): The name of the collection. This is a required parameter and must be a string of ASCII characters with a maximum length of 100.
- description (string-ascii 256): A brief description of the collection. This is a required parameter and must be a string of ASCII characters with a maximum length of 256.
- logo (string-ascii 256): A URL or path to the logo image of the collection. This is a required parameter and must be a string of ASCII characters with a maximum length of 256.

Returns
- Success: If the collection is created successfully, the function returns:
ok "Collection creation successful": A success message indicating that the collection has been created.
- Error: If the creation fails (e.g., due to validation issues), the function may return:
err "Error message": An error message indicating the reason for the failure.

Example Usage
Here’s an example of how to call the create-collection function:
```
(create-collection "My NFT Collection" "A collection of unique NFTs" "https://example.com/logo.png")
```

### 2.  get-all-collections

Overview:

The get-all-collections function retrieves a list of all NFT collections stored in the contract. This function is useful for displaying all collections available within the contract, allowing users to view the various NFT collections that have been created.

Signature:
```
(define-read-only (get-all-collections)
``` 

Returns
- Success: If the function executes successfully, it returns:
ok <list of collections>: A list of all collections associated with the contract. Each collection is represented as a tuple containing its attributes (e.g., name, description, logo, etc.).
- Error: If there are no collections available, the function may return:
err "No collections found": An error message indicating that no collections are currently stored in the contract.

Example Usage
Here’s an example of how to call the get-all-collections function:
```
(get-all-collections)
```

### 3.  get-collections-by-owner

Overview:

The get-collections-by-owner function retrieves a list of NFT collections associated with a specific user address (owner). This function is useful for displaying all collections owned by a particular user, allowing them to view their own NFT collections.

Signature:
```
(define-read-only (get-all-collections)
``` 

Returns
- Success: If the user has collections, the function returns:
ok <list of collections>: A list of collections associated with the caller's address. Each collection is represented as a tuple containing its attributes (e.g., name, description, logo, etc.).
- Error: If the user does not have any collections, the function returns:
err "No collections found for this address": An error indicating that no collections are associated with the specified address.


Example Usage
Here’s an example of how to call the get-collections-by-owner function:
```
(get-collections-by-owner)
```

### 4.  create-nft

Overview:

The create-nft function allows users to create a new Non-Fungible Token (NFT) within a specified collection. This function initializes the NFT with specified attributes and associates it with the user's address (principal). It ensures that each NFT is unique and properly registered in the contract's state.

Signature:
```
(define-public (create-nft (collection-id uint) (name (string-ascii 256)) (description (string-ascii 256)) (image (string-ascii 256)) (price uint))
```

Parameters

- collection-id (uint): The unique identifier of the collection to which the NFT belongs. This is a required parameter.
- name (string-ascii 256): The name of the NFT. This is a required parameter and must be a string of ASCII characters with a maximum length of 256.
description (string-ascii 256): A brief description of the NFT. This is a required parameter and must be a string of ASCII characters with a maximum length of 256.
- image (string-ascii 256): A URL or path to the image representing the NFT. This is a required parameter and must be a string of ASCII characters with a maximum length of 256.
- price (uint): The price of the NFT in the specified currency. This is a required parameter.


Returns
- Success: If the NFT is created successfully, the function returns:
ok "NFT creation successful": A success message indicating that the NFT has been created.
- Error: If the creation fails (e.g., due to validation issues or if the collection does not exist), the function may return:
- err "Error message": An error message indicating the reason for the failure.


Example Usage
Here’s an example of how to call the create-nft function:
```
(create-nft u1 "My Unique NFT" "This is a description of my NFT" "https://example.com/nft-image.png" u500)
```

### 5.  get-all-nfts

Overview:

The get-all-nfts function retrieves a list of all Non-Fungible Tokens (NFTs) stored in the contract. This function is useful for displaying all NFTs available within the contract, allowing users to view the various NFTs that have been created.

Signature:
```
(define-read-only (get-all-nfts)
``` 

Returns
- Success: If the function executes successfully, it returns:
ok <list of NFTs>: A list of all NFTs associated with the contract. Each NFT is represented as a tuple containing its attributes (e.g., name, description, image, price, etc.).
- Error: If there are no NFTs available, the function may return:
err "No NFTs found": An error message indicating that no NFTs are currently stored in the contract.


Example Usage
Here’s an example of how to call the get-all-nfts function:
```
(get-all-nfts)
```

### 6.  get-nfts-by-owner

Overview:

The get-nfts-by-owner function retrieves a list of Non-Fungible Tokens (NFTs) associated with a specific user address (owner). This function is useful for displaying all NFTs owned by a particular user, allowing them to view their own NFT holdings.

Signature:
```
(define-read-only (get-nfts-by-owner)
``` 

Returns
- Success: If the user has NFTs, the function returns:
ok <list of NFTs>: A list of NFTs associated with the caller's address. Each NFT is represented as a tuple containing its attributes (e.g., name, description, image, price, etc.).
- Error: If the user does not have any NFTs, the function returns:
err "No NFTs found for this address": An error indicating that no NFTs are associated with the specified address.


Example Usage
Here’s an example of how to call the get-nfts-by-owner function:
```
(get-nfts-by-owner)
```


# Sources
- https://docs.stacks.co/reference/types#clarity-type-system
- https://book.clarity-lang.org/ch04-01-constants.html
- https://www.clearness.dev/02-clarity-language/01-iterate-on-lists
- https://www.clearness.dev/
- https://www.easya.io/

