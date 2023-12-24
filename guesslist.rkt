(#%require (lib "27.ss" "srfi"))
(random-source-randomize! default-random-source)

(define (play_guess)
  (+ (random-integer 9) 1))

(define (game target)
  (let loop ((guesses 0))
    (let ((num (read)))
      (cond
        ((= num target)
         (display "You win!\n")
         guesses)
        ((> num target)
         (begin
           (display "Lower... Enter guess: ")
           (loop (+ guesses 1))))
        ((< num target)
         (begin
           (display "Higher... Enter guess: ")
           (loop (+ guesses 1))))))))


(define (main)
  (let loop ((scores '()))
    (display "Enter q to quit or any other key to continue: ")
    (let ((input (read-char)))
      (read-char) ; Consume the newline character
      (cond
        ((char=? input #\q)
         (display "Game over.")
         (newline)
         (if (not (null? scores))
             (display-scores scores)
             (display "No scores available.")))
        (else
         (display "Guess a number from 1 to 10: ")
         (let* ((target (play_guess))
                (guesses (game target))
                (name (begin
                          (display "What is your name? ")
                          (flush-output)
                          (let ((name (read)))
                            (newline)
                            name))))
           (display "Good game, ")
           (display name)
           (newline)
           (read-char)
           (loop (cons (cons name guesses) scores))))))))

(define (display-scores scores)
  (display "------------------\n")
  (for-each (lambda (score)
              (let ((name (car score))
                    (guesses (cdr score)))
                (display name)
                (display " ")
                (display guesses)
                (newline)
                (display "------------------\n")))
            scores))

(main)
