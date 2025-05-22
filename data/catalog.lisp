(defun catalog-images (image-dir output-dir)
  (loop for file in (directory (format nil "~a/*.jpg" image-dir))
        for id from 1
        collect (let ((hash (preprocess-image file output-dir id)))
                  (list id file hash))))

(defun catalog-text (text-dir output-dir)
  (loop for file in (directory (format nil "~a/*.txt" text-dir))
        for id from 1
        collect (let ((hash (preprocess-text file output-dir id)))
                  (list id file hash))))

(defun catalog-puzzles (puzzle-dir output-dir)
  (loop for file in (directory (format nil "~a/*.json" puzzle-dir))
        for id from 1
        collect (list id file (preprocess-puzzle file output-dir id))))

(defun build-master-catalog (image-dir text-dir puzzle-dir output-dir)
  (let ((images (catalog-images image-dir output-dir))
        (texts (catalog-text text-dir output-dir))
        (puzzles (catalog-puzzles puzzle-dir output-dir)))
    (with-open-file (out (format nil "~a/master-catalog.lisp" output-dir)
                        :direction :output
                        :if-exists :supersede)
      (write (list :images images :texts texts :puzzles puzzles) :stream out))))

;; Example usage: (build-master-catalog "images" "texts" "puzzles" "output")
