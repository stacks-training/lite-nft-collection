;; title: auth
;; version:
;; summary:
;; description:

;; constants
(define-constant contract-owner tx-sender)
(define-constant ERR_USER_NOT_EXIST "User does not exit")
(define-constant ERR_USER_ALREADY_EXISTS "User already exists")
(define-constant SUCCESS_LOGIN "Login successful")
(define-constant SUCCESS_REGISTER "Register successful")

;; listing errors
(define-constant ERR_EXPIRY_IN_PAST (err u1000))

;; data vars
;;

;; data maps
(define-map users-map
    principal
    {
        picture: (string-ascii 256),
        address: principal
    }
)

;; public functions
;;

;; login function
(define-public (login (user-address principal)) 
    (if (is-none (map-get? users-map user-address))
        (err ERR_USER_NOT_EXIST)
        (ok SUCCESS_LOGIN)
    )
)

;; register function
(define-public (register (user-address principal) (user-picture (string-ascii 256)))
    (if (is-some (map-get? users-map user-address))
        (err ERR_USER_ALREADY_EXISTS)
        (begin
            (map-set users-map user-address {picture: user-picture, address: user-address})
            (ok SUCCESS_REGISTER)
        )
    )
)

;; read only functions
;;

;; private functions
;;

