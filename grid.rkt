#lang racket

(require 2htdp/universe)
(require 2htdp/image)
(require 2htdp/planetcute)

(provide (all-defined-out))

(define-struct pac(x y rl form) #:mutable)

(define-values (gridw gridh cellw) (values 1000 1000 30))

(define pac1 (circle (/ cellw 2) 'solid 'yellow))

(define pac2 (overlay/align "right" "middle" 
                            (rotate -45 (right-triangle (* cellw (/ 14 20)) (* cellw (/ 14 20))
                                                        "solid" "black")) 
                            (circle (/ cellw 2) "solid" "yellow")))

(define back-ground (empty-scene gridw gridh 'black))

(define g wall-block)

(define start (cons 80 50))

(define gt-lst-1 (list (list 'red (cons 1 12) 'A 1)
                       (list 'green (cons 12 1) 'A 3)))

(define gt-lst-2 (list (list 'red (cons 9 1) 'A 3)
                       (list 'blue (cons 1 18) 'A 1)
                       (list 'green (cons 18 18) 'A 1)))

(define gt-lst-3 (list (list 'red (cons 1 1) 'A 2)
                       (list 'blue (cons 18 1) 'A 4)
                       (list 'green (cons 1 18) 'A 2)
                       (list 'orange (cons 18 18) 'A 4)))
(define lifes-1 3)

(define lifes-2 4)

(define lifes-3 5)

(define cher-lst-1 (list (cons 3 9) (cons 10 9) (cons 10 1) (cons 6 3)))

(define cher-lst-2 (list (cons 6 5) (cons 13 5) (cons 2 12) (cons 17 12)))

(define cher-lst-3 (list (cons 5 16) (cons 14 16) (cons 3 7) (cons 8 3)))


(define start-i-1 (cons (/ (- gridw (* cellw 13)) 2) 80))

(define start-i-2 (cons (/ (- gridw (* cellw 19)) 2) 80))

(define start-i-3 (cons (/ (- gridw (* cellw 19)) 2) 80))

(define pac-respawn-1 (cons 12 5))

(define gt-respawn-1 (cons 6 7))

(define pac-respawn-2 (cons 18 4))

(define gt-respawn-2 (cons 9 10))

(define pac-respawn-3 (cons 18 8))

(define gt-respawn-3 (cons 9 9))

(define init-gem-1 (list (cons 1 1)))

(define init-gem-2 (list (cons 7 16)))

(define init-gem-3 (list (cons 1 18)))

(define time-limit-1 +inf.0)

(define time-limit-2 +inf.0)

(define time-limit-3 175)

(define w (scale/xy (/ cellw 100) (/ cellw 83) (crop 0 50 100 83 g)));

(define e (rectangle cellw cellw 'solid 'black))

(define level-1 (list
   (list w w w e w w w w w w e w w w ) 
   (list w e w e e e e w e e e e e w ) 
   (list w e e e w e e w e w w w e w )
   (list w e w e w e e w e e w e e w )
   (list w e w e e e w w e e w e w w )
   (list e e e e e e e e e e w e e e )
   (list w e e e w w e w w e e e w w )
   (list w e w e w e e e w e w e e w )
   (list w e w e w w w w w e w e e w )
   (list w e w e e e w e e e e e e w )
   (list w e w w e e w e e w w w e w )
   (list w e e e e e e e e e e e e w )
   (list w e w e w e e e e w e e e w )
   (list w w w e w w w w w w e w w w )))

(define level-2
   (list
   (list w w w w w w w w w w e w w w w w w w w w)  
   (list w e e e e e e e e e e e e e e e e e e w) 
   (list w e w w e w w w e w w e w w w w e e e w)
   (list w e e e e e e e e e e e e e e e e w w w)
   (list e e w w e e e w w w w w w e e e e e e e)  
   (list w e w w e w e e e w w e e e w e e w w w)
   (list w e e e e w w w e w w e w w w e e e e w)
   (list w e w w e w e e e e e e e e w e w w e w)
   (list e e w w e w e w w e e w w e w e w w e e)
   (list w e w e e w e w e e e e w e w e e w e w)
   (list w e e e e e e w e e e e w e e e e e e w)
   (list w e e w e w e w w w w w w e w e w e e w)
   (list w e e w e w e e e e e e e e w e w e e w)
   (list w e w e e w e e w w w w e e w e e w e w)
   (list w e w e e e e e e w w e e e e e e w e w)
   (list w e w e w w w e e e e e e w w w e w e w)
   (list w e w e e e e e w e e w e e e e e w e w)
   (list w e e e w w w w w e e w w w w w e e e w)
   (list w e e e e e e e e e e e e e e e e e e w)
   (list w w w w w w w w w w e w w w w w w w w w)))

(define level-3
   (list
   (list w w w w w w w w w w e w w w w w w w w w)  
   (list w e e e e e e e e e e e e e e e e e e w) 
   (list w e w w e w w w w w w w w w w e w w e w)
   (list w e w e e w e e e w w e e e w e e w e w)
   (list e e w e e e e w w w w w w e e e e w e e)  
   (list w e e e w w e e e w w e e e w w e e e w)
   (list w e e e e w w w e e e e w w w e e e e w)
   (list w e w e e w e e e e e e e e w e e w w w)
   (list e e w w e w e w w w w w w e w e e e e e)
   (list w e w e e w e w e e e e w e w e e w w w)
   (list w e e e e e e w e e e e w e e e e e e w)
   (list w e e w w w e w w e e w w e w w w e e w)
   (list w e e w e w e e e e e e e e w e w e e w)
   (list w e w e e w e e w w w w e e w e e w e w)
   (list w e w e e e e e e w w e e e e e e w e w)
   (list w e w e w w w e w w w w e w w w e w e w)
   (list w e w e e e w e e e e e e w e e e w e w)
   (list w e e e w w w w w e e w w w w w e e e w)
   (list w e w e e e e e e e e e e e e e e w e w)
   (list w w w w w w w w w w e w w w w w w w w w)))

(define flib '())
(define (grid-gen lst i j)
    (let [(max-i (length lst))
          (max-j (length (list-ref lst 0)))]
      (cond  [(= i max-i) back-ground]
             [(= j max-j) (grid-gen lst (+ i 1) 0)]
             [#t (let [(elem (list-ref (list-ref lst i) j))
                       (elem-x (+ (car start) (* cellw j)))
                       (elem-y (+ (cdr start) (* cellw i)))]  
                   (begin0 (place-image elem elem-x elem-y (grid-gen lst  i (+ j 1)))
                           (if (equal? e elem)
                               (set! flib (append (list (cons (/ (- elem-x (car start)) cellw)
                                                              (/ (- elem-y (cdr start)) cellw)))
                                                  flib))
                               (void))))])))

