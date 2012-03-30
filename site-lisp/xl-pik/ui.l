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
  (require "xl-pik/api")
  )

(in-package :xl-pik)

(export '(pik-switch
          pik-switch-dialog
          pik-switch-popup
          pik-switch-default
          ))

(defun pik-switch-dialog ()
  "Ruby を選択するダイアログを表示します。"
  (interactive)
  (multiple-value-bind (result data)
      (dialog-box '(dialog 0 0 300 120
                    (:caption "pik switch")
                    (:font 9 "MS UI Gothic")
                    (:control
                     (:listbox list nil #x50a10101 4 5 238 110)
                     (:button IDOK "OK" #x50030001 245 5 52 14)
                     (:button IDCANCEL "キャンセル" #x50030000 245 22 52 14)))
                  (let ((pik-list (pik-list*)))
                    `((list . ,(mapcar #'format-pik-list pik-list))
                      (list . ,(position-if-not #'car pik-list))))
                  '((list :column (1 10 225) :must-match t :enable (IDOK))))
    (when result
      (pik-switch (cdr (assoc 'list data))))))

(defun pik-switch-popup ()
  "Ruby を選択するポップアップリストを表示します。"
  (interactive)
  (popup-list (mapcar #'format-pik-list (pik-list*))
              #'pik-switch
              (point)))

(defun pik-switch (&optional new-ruby)
  "ミニバッファから Ruby を選択します。"
  (interactive)
  (when (and (interactive-p)
             (not new-ruby))
    (let ((pik-list (pik-list*)))
      (labels ((completions ()
                 (mapcar #'(lambda (item) (format-pik-list item :no-mark t)) pik-list))
               (default ()
                 (format-pik-list (find-if-not #'car (pik-list)) :no-mark t)))
        (setf new-ruby (completing-read "Ruby: " (completions) :default (default))))))
  (multiple-value-bind (ruby-ver new-path)
      (pik-use new-ruby)
    (message "Picked ~A (~A)" ruby-ver new-path)))

(defun pik-switch-default ()
  "デフォルトの Ruby に切り替えます。"
  (interactive)
  (message "Picked default (~A)" (pik-default)))

(defun pik-list* ()
  (message "Picking ruby...")
  (prog1
      (pik-list)
    (message " ")))


(provide "xl-pik/ui")

;;; End
