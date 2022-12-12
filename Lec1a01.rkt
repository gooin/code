#lang sicp

(define A (* 5 5))
(* A A)
(define B (+ A (* 5 A)))

B


;  if have parenthesis after `define`, means you define a procedure.
(define (square x) (* x x))

; same as above
(define squarex (lambda(x)(* x x)))
squarex

(squarex (+ 3 3 (* A (square 5))))
(square (square (square (square A))))

(define (average a b) (/ (+ a b) 2))
; output: 4
(average 3 5)

; output: #<procedure:square>
square
; output: #<procedure:average>
average

; output: #<procedure:+>
+


;---------------------------

; if caluse, like switch-case in other language.
(define (abs x)
    (cond ((< x 0) (- x))
          ((= x 0) 0)  
          ((> x 0) x)
    )
)
(abs -1)
(abs 0)
(abs 1)

; if caluse. same as above.
(define (abs2 x)
    (if (< x 0)
        (- x)
        (x) ; here is else
    )
)

(abs2 -1)

;========================================================
; square root procedure example.  (Recursive Definition)
;========================================================

(define (improve guess x)
    (average guess (/ x guess))
)

(define (goodenough? guess x)
    (< 
        (abs 
            (- (square guess) x)
        )
        0.001
    )
)

(define (try guess x)
    (if (goodenough? guess x)
        guess
        (try (improve guess x) x) ; recursive here. 
    )
)
(define (sqrt x)(try 1 x))


; output: 577/408 ~= 1.4142156862
(sqrt 2)

; (sqrt 2)
; (try 1 2)
; (try (improve 1 2) 2)
; (try (average 1 (/ 2 1)) 2)
; (try 1.5 2)
; (try (improve 1.5 2) 2)
; (try (average 1.5 (/ 2 1.5)) 2)
; (try 1.41666 2)
;
; .... until [goodenouth?]
;
; output: 577/408 ~= 1.4142156862

(sqrt 10)


; make a sqrt box, all definitions in a "box". "Block Structure."

(define (sqrtbox x)
    (define (average a b) (/ (+ a b) 2))
    (define (square x) (* x x))
    (define (abs2 x)
        (if (< x 0)
            (- x)
            (x) ; here is else
        )
    )
    (define (improve guess)
        (average guess (/ x guess))
    )
    (define (goodenough? guess)
        (< (abs (- (square guess) x)) 0.001)
    )
    (define (try guess)
        (if (goodenough? guess)
            guess
            (try (improve guess))
        )
    )
    (try 1)
)

(sqrtbox 2)