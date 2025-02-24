
;; title: collection contract
;; version: 5
;; summary: contract to save collections and NFTs created by user
;; description:

;; token definitions
;;
(define-map users uint {name: (string-utf8 50), age: uint})
(define-data-var user-count uint u0)

;; constants
;;
(define-constant SUCCESS_CREATED_COLLECTION "Collection creation successful")
(define-constant SUCCESS_CREATED_NFT "NFT creation successful")
(define-constant ERROR_EMPTY_VALUE "Empty value is invalid")
(define-constant ERROR_EMPTY_FIELDS "Fields cannot be empty")

;; data vars
;;
(define-data-var global-collection-id uint u0)
(define-data-var global-nft-id uint u0)
(define-data-var collection-id-list (list 100 uint) (list))
(define-data-var nft-id-list (list 100 uint) (list))

;; maps
;;
(define-map collections-map
  { collection-id: uint }
  {
    id: uint,
    name: (string-utf8 100),
    description: (string-utf8 256),
    logo: (string-utf8 256),
    owner: principal,
    quantity: uint
  }
)

(define-map nfts-map
  { nft-id: uint }
  {
    id: uint,
    name: (string-utf8 100),
    image: (string-utf8 256),
    attributes: (string-utf8 256),
    price: uint,
    owner: principal,
    collection-id: uint
  }
)

;; private functions
;;
(define-private (collection-owner-validation (collection {
    id: uint,
    name: (string-utf8 100),
    description: (string-utf8 256),
    logo: (string-utf8 256),
    owner: principal,
    quantity: uint
  }))
    (is-eq (get owner collection) tx-sender)
)

(define-private (nft-owner-validation (nft {
    id: uint,
    name: (string-utf8 100),
    image: (string-utf8 256),
    attributes: (string-utf8 256),
    price: uint,
    owner: principal,
    collection-id: uint
  }))
    (is-eq (get owner nft) tx-sender)
)

(define-private (iterate-collections (ids (list 100 uint)))
  (map get-collection-by-id ids)
)

(define-private (iterate-nfts (ids (list 100 uint)))
  (map get-nft-by-id ids)
)

(define-private (get-collection-by-id (id uint))
    (unwrap-panic (map-get? collections-map { collection-id: id}))
)

(define-private (get-nft-by-id (id uint))
    (unwrap-panic (map-get? nfts-map { nft-id: id}))
)

;; PUBLIC FUNCTIONS

;; create a new collection
(define-public (create-collection (name (string-utf8 100)) (description (string-utf8 256)) (logo (string-utf8 256)))
    (begin
        ;; validate name, description and logo are not empty
        (if (or (is-eq name u"") (is-eq description u"") (is-eq logo u""))
            (err ERROR_EMPTY_FIELDS)
            (let ((collection-id (+ (var-get global-collection-id) u1))) 
                ;; insert new collection
                (map-insert collections-map
                    { collection-id: collection-id }
                    {
                        id: collection-id,
                        name: name,
                        description: description,
                        logo: logo,
                        owner: tx-sender,
                        quantity: u0
                    }
                )
                ;; update collection id list
                (unwrap! (push-item collection-id) (err ERROR_EMPTY_VALUE))
                ;; update global id for collections
                (var-set global-collection-id collection-id)
                (ok SUCCESS_CREATED_COLLECTION)
            )
        )
    )
)

;; retrieve all collection about all user
(define-read-only (get-all-collections)
    (iterate-collections (var-get collection-id-list))
)

;; get contract caller and retrieve theirs collections
(define-read-only (get-collections-by-owner)
    (print (filter collection-owner-validation (get-all-collections)))
)

(define-public (create-nft (name (string-utf8 100)) (attributes (string-utf8 256)) (image (string-utf8 256)) (collection-id uint))
    (begin
        (if (or (is-eq name u"") (is-eq attributes u"") (is-eq image u"") (is-eq collection-id u0))
            (err ERROR_EMPTY_FIELDS)
            (let ((nft-id (+ (var-get global-nft-id) u1))) 
                ;; insert new nft
                (map-insert nfts-map
                    { nft-id: nft-id }
                    {
                        id: nft-id,
                        name: name,
                        image: image,
                        attributes: attributes,
                        price: u0,
                        owner: tx-sender,
                        collection-id: collection-id
                    }
                )
                ;; update nft id list
                (unwrap! (push-nft-item nft-id) (err ERROR_EMPTY_VALUE))
                ;; update global id for collections
                (var-set global-nft-id nft-id)
                (ok SUCCESS_CREATED_NFT)
            )
        )
    )
)

(define-read-only (get-all-nfts)
    (iterate-nfts (var-get nft-id-list))
)

(define-read-only (get-nfts-by-owner)
    (print (filter nft-owner-validation (get-all-nfts)))
)

;; LIST FUNCTIONS

;; Function to push an item to the list
(define-private (push-item (item uint))
    (begin
        (var-set collection-id-list (unwrap! (as-max-len? (append (var-get collection-id-list) item) u100) (err u1)))
        (ok true)))

;; Function to get the current list
(define-private (get-list)
    (var-get collection-id-list))

;; Function to get length of the list
(define-private (get-length)
    (len (var-get collection-id-list)))

;; Function to clear the list
(define-private (clear-list)
    (begin
        (var-set collection-id-list (list))
        (ok true)))

;; Function to push an item to the list
(define-private (push-nft-item (item uint))
    (begin
        (var-set nft-id-list (unwrap! (as-max-len? (append (var-get nft-id-list) item) u100) (err u1)))
        (ok true)))