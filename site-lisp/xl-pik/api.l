; -*- mode: lisp; package: xl-pik; encoding: shift_jis -*-

;; Copyright (c) 2012 MIYAMUKO Katsuyuki.
;;
;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:
;;
;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
;; LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
;; OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

;;; Code:

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require "xl-pik/package")
  )

(in-package :xl-pik)

(export '(*pik-command*
          ))

(defvar *pik-command* "pik.bat"
  "pik のコマンドを指定します。デフォルトは pik.bat です。")

(defun pik-use (ruby)
  (setf ruby (format-pik-list (parse-pik-list ruby) :no-mark t))
  (let ((env (safe-car (pik-run (format nil "switch \"~A\" && path" ruby)))))
    (when (and env (string-matchp "^PATH=" env))
      (let* ((path (substring env (match-end 0)))
             (new-ruby (car (split-string path #\;))))
        (when (and path new-ruby)
          (si:putenv "PATH" path)
          new-ruby)))))

(defun pik-list (&key raw)
  (let ((lines (pik-run "list")))
    (if raw
        lines
      (remove-if #'null (mapcar #'parse-pik-list lines)))))

(defun format-pik-list (pik-list-item &key no-mark)
  (when pik-list-item
    (multiple-value-bind (mark short-ver long-ver)
        (values-list pik-list-item)
      (let ((ruby (if (and short-ver long-ver)
                      (format nil "~A: ~A" short-ver long-ver)
                    (or long-ver short-ver))))
        (if no-mark
            ruby
          (format nil "~A ~A" (if mark "*" " ") ruby))))))

(defun parse-pik-list (line)
  (when (string-match "^\\([ *]*\\)\\(?:\\([0-9p]+?\\): *\\)?\\(.+\\)$" line)
    (flet ((strip (s)
             (when s
               (string-trim " " s))))
      (list (find #\* (match-string 1))
            (strip (match-string 2))
            (strip (match-string 3))))))

(defun pik-run (args &key no-error)
  (let* ((command (format nil "~A ~A" *pik-command* args))
         (proc (make-process command))
         result)
    (labels ((filter (proc output)
               (setf result (concat result output))))
      (set-process-filter proc #'filter)
      (while (eq (process-status proc) :run)
        (sit-for 0.2))
      (let ((exit-code (process-exit-code proc)))
        (when (and (not (zerop exit-code))
                   (not no-error))
          (message-box (format nil "~A~%---~%~A~%Exit with ~A"
                               (or result "pik の実行に失敗しました。")
                               command
                               exit-code)
                       nil '(:exclamation)))
        (values (when result
                  (split-string result #\LFD))
                exit-code)))))


(provide "xl-pik/api")

;;; End
