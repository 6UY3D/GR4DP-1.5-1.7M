(defun preprocess-puzzle (file output-dir id)
  (with-open-file (in file :direction :input)
    (let* ((data (read in))
           (binary (with-output-to-string (s)
                     (write data :stream s)))
           (hash (sha256 binary)))
      (with-open-file (out (format nil "~a/~a.bin" output-dir id)
                          :direction :output
                          :element-type '(unsigned-byte 8)
                          :if-exists :supersede)
        (write-sequence (string-to-octets binary) out))
      hash)))

(defun sha256 (string)
  ;; Placeholder: Use external SHA-256 library
  (format nil "hash-of-~a" string))

(defun string-to-octets (string)
  (map 'vector #'char-code string))

;; Example usage: (preprocess-puzzle "puzzle.json" "output" 1)
