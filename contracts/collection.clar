
;; title: collection
;; version: 1
;; summary:
;; description:

;; traits
;;

;; token definitions
;;

;; constants
;;
(define-constant SUCCESS_CREATED_COLLECTION "Collection creation successful")

;; data vars
;;
(define-data-var global-collection-id uint u0)

;; data maps
;;
;; (define-map collections-map
;;     principal
;;     {
;;         name: (string-ascii 256),
;;         description: (string-ascii 256),
;;         logo: (string-ascii 256)
;;     }
;; )

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

(define-map collections-map
  { collection-id: uint }
  {
    name: (string-ascii 100),
    description: (string-ascii 256),
    logo: (string-ascii 256)
  }
)


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

(define-public (create-collection (name (string-ascii 100)) (description (string-ascii 256)) (logo (string-ascii 256)))
    (begin
        (let ((collection-id (+ (var-get global-collection-id) u1))) 
            ;; insert new collection
            (map-insert collections-map
                { collection-id: collection-id }
                {
                    name: name,
                    description: description,
                    logo: logo
                }
            )
            (var-set global-collection-id collection-id)
            (ok SUCCESS_CREATED_COLLECTION)
        )
    )
)

;; (define-public (get-collection-history) body)

;; (define-public (get-nft-history) body)



;; read only functions
;;
(define-read-only (get-collection-id)
    (ok (var-get global-collection-id))
)

(define-read-only (get-collection-by-id (id uint))
    (ok (map-get? collections-map { collection-id: id}))
)

;; private functions
;;

