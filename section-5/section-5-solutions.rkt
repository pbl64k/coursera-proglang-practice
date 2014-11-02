#lang racket

(provide (all-defined-out))

;;; Warm Up ;;;

;; Knights Who Say 'Ni' ;;
(define (factorial n)
  (if (zero? n)
      1
      (* n (factorial (sub1 n)))))

;; Another Shrubbery! ;;
(define (tr-factorial n)
  (define (helper acc x)
    (if (> x n)
        acc
        (helper (* x acc) (add1 x))))
  (helper 1 2))

;; Palindromic Addition ;;
(define (palindromic numbers)
  (map + numbers (reverse numbers)))

;;; Streams ;;;

;; Useful stream HOF we've seen in lectures and reading notes
(define (stream-maker fn arg)
  (letrec ([f (lambda (x)
                (cons x (lambda () (f (fn x arg)))))])
    (lambda () (f arg))))

;; Undecided ;;
(define undecided (stream-maker xor #t))

;; Fibonacci ;;
(define (fibonacci)
  (define (unfold-fib state)
    (define fa (car state))
    (define fb (cdr state))
    (lambda () (cons (+ fa fb) (unfold-fib (cons fb (+ fa fb))))))
  ((unfold-fib (cons -1 1))))

;; Interleave ;;
(define (interleave xs ys)
  (define (helper xs ys)
    (lambda ()
      (define pair (xs))
      (cons (car pair) (helper ys (cdr pair)))))
  (helper xs ys))

;; Not These Guys Again ;;

;; Stream of natural numbers starting with 1, as defined using string-maker in the reading notes
(define nats (stream-maker + 1))

(define (stream-factorial n)
  (define (helper acc stream)
    (define pair (stream))
    (if (< n (car pair))
        acc
        (helper (* acc (car pair)) (cdr pair))))
  (helper 1 nats))

;; More Bananas ;;
(define (repeats string)
  (stream-maker string-append string))

;; Newton's Back For More ;;
(define (sqrt-stream n)
  (stream-maker (lambda (x n) (* 0.5 (+ x (/ n x)))) n))

;;; Macros ;;;

;; Perl Style ;;
(define-syntax perform
  (syntax-rules (if unless)
    ((perform e1 if e2) (and e2 e1))
    ((perform e1 unless e2) (or e2 e1))))
