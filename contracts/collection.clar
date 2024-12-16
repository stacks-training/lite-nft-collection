
;; title: collection
;; version:
;; summary:
;; description:

;; traits
;;

;; token definitions
;;

;; constants
;;

;; data vars
;;

;; data maps
;;
(define-map collections-map
    principal
    {
        name: (string-ascii 256),
        description: (string-ascii 256),
        logo: (string-ascii 256)
    }
)

(define-map nfts-map
    principal
    {
        token-id: uint,
        name: (string-ascii 256),
        price: uint,
        image: (string-ascii 256),
        collection: principal
    }
)

;; (define-map principal-list-map
;;     principal
;;     (list (string-ascii 256))
;; )

;; public functions
;;
(define-public (get-collections (user-address principal))
    (ok (list 
        {
            id: u1,
            name: "Collection one",
            description: "This is a first collection",
            logo: "https://images.gamma.io/ipfs/QmNcUCdjFK39Pk5iRrKY7Ez6hmqBcdnuxDZDAjTmeoxUqZ/bird-88.png"
        }
        {
            id: u2,
            name: "Collection two",
            description: "This is a second collection",
            logo: "https://images.gamma.io/ipfs/QmNcUCdjFK39Pk5iRrKY7Ez6hmqBcdnuxDZDAjTmeoxUqZ/bird-88.png"
        }
        {
            id: u3,
            name: "Collection three",
            description: "This is a third collection",
            logo: "https://images.gamma.io/ipfs/QmNcUCdjFK39Pk5iRrKY7Ez6hmqBcdnuxDZDAjTmeoxUqZ/bird-88.png"
        }
    ))
)

(define-public (get-nfts-by-collection (collection-id uint))
    (ok (list 
        {
            token-id: u1,
            name: "Bitcoin Birds 1",
            price: u1200,
            image: "https://images.gamma.io/cdn-cgi/image/quality=100,width=300,height=300/https://images.gamma.io/ipfs/QmNcUCdjFK39Pk5iRrKY7Ez6hmqBcdnuxDZDAjTmeoxUqZ/bird-0.png",
            collection-id: u1
        }
        {
            token-id: u2,
            name: "Bitcoin Birds 2",
            price: u1400,
            image: "https://images.gamma.io/cdn-cgi/image/quality=100,width=300,height=300/https://images.gamma.io/ipfs/QmNcUCdjFK39Pk5iRrKY7Ez6hmqBcdnuxDZDAjTmeoxUqZ/bird-0.png",
            collection-id: u1
        }
        {
            token-id: u3,
            name: "Bitcoin Birds 3",
            price: u100,
            image: "https://images.gamma.io/cdn-cgi/image/quality=100,width=300,height=300/https://images.gamma.io/ipfs/QmNcUCdjFK39Pk5iRrKY7Ez6hmqBcdnuxDZDAjTmeoxUqZ/bird-0.png",
            collection-id: u1
        }
        {
            token-id: u4,
            name: "Bitcoin Birds 4",
            price: u100,
            image: "https://images.gamma.io/cdn-cgi/image/quality=100,width=300,height=300/https://images.gamma.io/ipfs/QmNcUCdjFK39Pk5iRrKY7Ez6hmqBcdnuxDZDAjTmeoxUqZ/bird-0.png",
            collection-id: u1
        }
    ))
)

;; (define-public (get-collection-history) body)

;; (define-public (get-nft-history) body)



;; read only functions
;;

;; private functions
;;

