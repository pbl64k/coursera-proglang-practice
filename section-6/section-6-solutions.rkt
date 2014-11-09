#lang racket

(provide (all-defined-out))

;;; The Usual Suspects ;;;

;; provided definitions
(struct btree-leaf () #:transparent)
(struct btree-node (value left right) #:transparent)

(define (btree-fold f init t)
  (if (btree-leaf? t)
      init
      (f (btree-fold f init (btree-node-left t)) (btree-node-value t)
         (btree-fold f init (btree-node-right t)))))

(define (btree-unfold f state)
  (define res (f state))
  (if res
      (btree-node (car res)
                  (btree-unfold f (cadr res))
                  (btree-unfold f (cddr res)))
      (btree-leaf)))

(define (gardener t)
  (btree-unfold
   (lambda (t)
     (and (not (btree-leaf? t))
          (btree-node-value t)
          (cons (btree-node-value t)
                (cons (btree-node-left t)
                      (btree-node-right t)))))
   t))

;;; So Dynamic ;;;

;; Crazy Sum ;;
(define (crazy-sum xs)
  (cdr
   (foldl
    (lambda (x st)
      (if (procedure? x)
          (cons x (cdr st))
          (cons (car st) ((car st) (cdr st) x))))
    (cons + 0)
    xs)))

;; Universal Fold ;;

(define (universal-fold f init data)
  (if (list? data)
      (foldr f init data)
      (btree-fold f init data)))

(define (universal-sum data)
  (universal-fold + 0 data))

;; Stomp! ;;
(define (flatten xs)
  (if (empty? xs)
      null
      (if (list? (car xs))
          (if (empty? (car xs))
              (flatten (cdr xs))
              (flatten (cons (caar xs) (cons (cdar xs) (cdr xs)))))
          (cons (car xs) (flatten (cdr xs))))))

;;; Lambda Madness ;;;

;; provided definitions
;; MUPL structs from Section 6 homework assignment in Programming Languages class
(struct var  (string) #:transparent)  ;; a variable, e.g., (var "foo")
(struct int  (num)    #:transparent)  ;; a constant number, e.g., (int 17)
(struct add  (e1 e2)  #:transparent)  ;; add two expressions
(struct ifgreater (e1 e2 e3 e4)    #:transparent) ;; if e1 > e2 then e3 else e4
(struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
(struct call (funexp actual)       #:transparent) ;; function call
(struct mlet (var e body) #:transparent) ;; a local binding (let var = e in body) 
(struct apair (e1 e2)     #:transparent) ;; make a new pair
(struct fst  (e)    #:transparent) ;; get first part of a pair
(struct snd  (e)    #:transparent) ;; get second part of a pair
(struct aunit ()    #:transparent) ;; unit value -- good for ending a list
(struct isaunit (e) #:transparent) ;; evaluate to 1 if e is unit else 0

(define (simplify e)
  (cond [(mlet? e)
         (call (fun #f (mlet-var e) (simplify (mlet-body e))) (simplify (mlet-e e)))]
        [(apair? e)
         (fun #f "_f" (call (call (var "_f") (simplify (apair-e1 e))) (simplify (apair-e2 e))))]
        [(fst? e)
         (call (simplify (fst-e e)) (fun #f "_x" (fun #f "_y" (var "_x"))))]
        [(snd? e)
         (call (simplify (snd-e e)) (fun #f "_x" (fun #f "_y" (var "_y"))))]
        [(add? e)
         (add (simplify (add-e1 e)) (simplify (add-e2 e)))]
        [(ifgreater? e)
         (ifgreater (simplify (ifgreater-e1 e))
                    (simplify (ifgreater-e2 e))
                    (simplify (ifgreater-e3 e))
                    (simplify (ifgreater-e4 e)))]
        [(fun? e)
         (fun (fun-nameopt e) (fun-formal e)
              (simplify (fun-body e)))]
        [(call? e)
         (call (simplify (call-funexp e))
               (simplify (call-actual e)))]
        [(isaunit? e)
         (isaunit (simplify (isaunit-e e)))]
        [else e]))
