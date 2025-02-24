;; title: auth
;; version: 2
;; summary:
;; description:

;; constants
(define-constant contract-owner tx-sender)
(define-constant ERR_USER_NOT_EXIST "User does not exit")
(define-constant ERR_USER_ALREADY_EXISTS "User already exists")
(define-constant SUCCESS_LOGIN "Login successful")
(define-constant SUCCESS_REGISTER "Register successful")
(define-constant ERR_INTERNAL "Something was wrong")

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

;; PUBLIC & READ ONLY FUNCTIONS
;;

;; login function
(define-public (login (user-address principal) (user-picture (string-ascii 256)))
    (let ((user-data (map-get? users-map user-address)))
            (if (is-none user-data)
                (let ((register-result (register user-address user-picture)))  ;; Call register function and save the result
                    (if (is-ok register-result)
                        (ok SUCCESS_REGISTER)  ;; Return success message after registration
                        (err ERR_INTERNAL)  ;; Handle case where registration fails
                    )
                )
                (ok SUCCESS_LOGIN)
            )
    )
)

;; retrieve basic user data
(define-read-only (get-user-data (user-address principal))
    (let ((user-data (map-get? users-map user-address)))
        (if (is-none user-data)
            (err ERR_USER_NOT_EXIST)
            (ok user-data)
        )
    )
)

;; PRIVATE FUNCTIONS
;;

;; register function
(define-private (register (user-address principal) (user-picture (string-ascii 256)))
    (if (is-some (map-get? users-map user-address))
        (err ERR_USER_ALREADY_EXISTS)
        (begin
            (map-set users-map user-address {picture: user-picture, address: user-address})
            (ok SUCCESS_REGISTER)
        )
    )
)





