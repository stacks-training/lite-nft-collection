https://docs.stacks.co/reference/types#clarity-type-system
https://book.clarity-lang.org/ch04-01-constants.html
https://www.clearness.dev/02-clarity-language/01-iterate-on-lists
https://www.clearness.dev/
how to unwrap maps


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


### 1. get-collections
Signature:
```
(define-public (get-collections (user-address principal))
``` 
Overview:
The get-collections function retrieves a list of collections associated with a specific user address. This function is useful for displaying all collections owned by a user.

Parameters:
- user-address (principal): The unique address of the user whose collections are being requested. This is a required parameter.

Returns:

- Success: If the user has collections, the function returns:
ok <list of collections>: A list of collections associated with the provided user address.
- Error: If the user does not have any collections, the function returns:
err "No collections found for this address": An error indicating that no collections are associated with the specified address.


### 2. get-nfts-by-collection
Signature:
```
(define-public (get-nfts-by-collection (collection-id uint))
```

Overview:
The get-nfts-by-collection function retrieves a list of NFTs that belong to a specific collection identified by its ID. This function is useful for displaying all NFTs within a particular collection.

Parameters:

- collection-id (uint): The unique identifier of the collection for which NFTs are being requested. This is a required parameter.

Returns:

- Success: If the collection exists and contains NFTs, the function returns:
ok <list of NFTs>: A list of NFTs associated with the specified collection ID.
- Error: If the collection does not exist or contains no NFTs, the function returns:
err "No NFTs found for this collection": An error indicating that no NFTs are associated with the specified collection ID.