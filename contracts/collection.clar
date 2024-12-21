
;; title: collection
;; version: 5
;; summary:
;; description:

;; traits
;;

;; token definitions
;;
(define-map users uint {name: (string-ascii 50), age: uint})
(define-data-var user-count uint u0)

;; constants
;;
(define-constant SUCCESS_CREATED_COLLECTION "Collection creation successful")
(define-constant SUCCESS_CREATED_NFT "NFT creation successful")

;; data vars
;;
(define-data-var global-collection-id uint u0)
(define-data-var global-nft-id uint u0)



(define-map nfts-map-old
    principal
    {
        token-id: uint,
        name: (string-ascii 256),
        price: uint,
        image: (string-ascii 256),
        collection: principal
    }
)

(define-map collections-map
  { collection-id: uint }
  {
    id: uint,
    name: (string-ascii 100),
    description: (string-ascii 256),
    logo: (string-ascii 256),
    owner: principal,
    quantity: uint
  }
)

(define-map nfts-map
  { nft-id: uint }
  {
    id: uint,
    name: (string-ascii 100),
    image: (string-ascii 256),
    attributes: (string-ascii 256),
    price: uint,
    owner: principal,
    collection-id: uint
  }
)

;; public functions
;;
(define-public (create-collection (name (string-ascii 100)) (description (string-ascii 256)) (logo (string-ascii 256)))
    (begin
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
            ;; update global id for collections
            (var-set global-collection-id collection-id)
            (ok SUCCESS_CREATED_COLLECTION)
        )
    )
)

(define-public (create-nft (name (string-ascii 100)) (attributes (string-ascii 256)) (image (string-ascii 256)) (collection-id uint))
    (begin
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
            ;; update global id for collections
            (var-set global-nft-id nft-id)
            (ok SUCCESS_CREATED_NFT)
        )
    )
)

;; (define-public (get-collection-history) body)

;; (define-public (get-nft-history) body)

;; read only functions
;;
(define-read-only (get-collections-mock (user-address principal))
    (list 
        {
            id: u1,
            name: "Collection one",
            description: "This is a first collection",
            logo: "https://images.gamma.io/ipfs/QmNcUCdjFK39Pk5iRrKY7Ez6hmqBcdnuxDZDAjTmeoxUqZ/bird-88.png",
            quantity: u0
        }
        {
            id: u2,
            name: "Collection two",
            description: "This is a second collection",
            logo: "https://images.gamma.io/ipfs/QmNcUCdjFK39Pk5iRrKY7Ez6hmqBcdnuxDZDAjTmeoxUqZ/bird-88.png",
            quantity: u1
        }
        {
            id: u3,
            name: "Collection three",
            description: "This is a third collection",
            logo: "https://images.gamma.io/ipfs/QmNcUCdjFK39Pk5iRrKY7Ez6hmqBcdnuxDZDAjTmeoxUqZ/bird-88.png",
            quantity: u5
        }
    )
)

(define-read-only (get-nfts-by-collection-mock (collection-id uint))
    (list 
        {
            id: u1,
            name: "Bitcoin Birds 1",
            price: u1200,
            image: "https://images.gamma.io/cdn-cgi/image/quality=100,width=300,height=300/https://images.gamma.io/ipfs/QmNcUCdjFK39Pk5iRrKY7Ez6hmqBcdnuxDZDAjTmeoxUqZ/bird-0.png",
            attributes: "",
            owner: 'STNHKEPYEPJ8ET55ZZ0M5A34J0R3N5FM2CMMMAZ6,
            collection-id: u1
        }
        {
            id: u2,
            name: "Bitcoin Birds 2",
            price: u1400,
            image: "https://images.gamma.io/cdn-cgi/image/quality=100,width=300,height=300/https://images.gamma.io/ipfs/QmNcUCdjFK39Pk5iRrKY7Ez6hmqBcdnuxDZDAjTmeoxUqZ/bird-0.png",
            attributes: "",
            owner: 'STNHKEPYEPJ8ET55ZZ0M5A34J0R3N5FM2CMMMAZ6,
            collection-id: u1
        }
        {
            id: u3,
            name: "Bitcoin Birds 3",
            price: u100,
            image: "https://images.gamma.io/cdn-cgi/image/quality=100,width=300,height=300/https://images.gamma.io/ipfs/QmNcUCdjFK39Pk5iRrKY7Ez6hmqBcdnuxDZDAjTmeoxUqZ/bird-0.png",
            attributes: "",
            owner: 'STNHKEPYEPJ8ET55ZZ0M5A34J0R3N5FM2CMMMAZ6,
            collection-id: u1
        }
        {
            id: u4,
            name: "Bitcoin Birds 4",
            price: u100,
            image: "https://images.gamma.io/cdn-cgi/image/quality=100,width=300,height=300/https://images.gamma.io/ipfs/QmNcUCdjFK39Pk5iRrKY7Ez6hmqBcdnuxDZDAjTmeoxUqZ/bird-0.png",
            attributes: "",
            owner: 'STNHKEPYEPJ8ET55ZZ0M5A34J0R3N5FM2CMMMAZ6,
            collection-id: u1
        }
    )
)

;; get contract caller and retrieve theirs collections
(define-read-only (get-collections-by-owner)
    (print (filter collection-owner-validation (get-all-collections)))
)

;; get contract caller and retrieve theirs collections
(define-read-only (get-nfts-by-owner)
    (print (filter nft-owner-validation (get-all-nfts)))
)

(define-read-only (get-collection-id)
    (ok (var-get global-collection-id))
)

(define-read-only (get-collection-by-id (id uint))
    (unwrap-panic (map-get? collections-map { collection-id: id}))
)

(define-read-only (get-nft-by-id (id uint))
    (unwrap-panic (map-get? nfts-map { nft-id: id}))
)

(define-read-only (get-all-collections)
    (iterate-collections (list u1 u2 u3))
)

(define-read-only (get-all-nfts)
    (iterate-nfts (list u1 u2 u3))
)

;; private functions
;;
(define-private (collection-owner-validation (collection {
    id: uint,
    name: (string-ascii 100),
    description: (string-ascii 256),
    logo: (string-ascii 256),
    owner: principal,
    quantity: uint
  }))
    (is-eq (get owner collection) tx-sender)
)

(define-private (nft-owner-validation (nft {
    id: uint,
    name: (string-ascii 100),
    image: (string-ascii 256),
    attributes: (string-ascii 256),
    price: uint,
    owner: principal,
    collection-id: uint
  }))
    (is-eq (get owner nft) tx-sender)
)

(define-private (iterate-collections (ids (list 10 uint)))
  (map get-collection-by-id ids)
)

(define-private (iterate-nfts (ids (list 10 uint)))
  (map get-nft-by-id ids)
)