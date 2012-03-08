;; 
;; maximize.el - maximize emacs frames in vertically or horizontally.
;;
;; 
;; Copyright (c) 2012 Yukimitsu Izawa <izawa@izawa.org>
;; All rights reserved.
;;
;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions
;; are met:
;; 1. Redistributions of source code must retain the above copyright
;;    notice, this list of conditions and the following disclaimer.
;; 2. Redistributions in binary form must reproduce the above copyright
;;    notice, this list of conditions and the following disclaimer in the
;;    documentation and/or other materials provided with the distribution.
;; 3. All advertising materials mentioning features or use of this software
;;    must display the following acknowledgement:
;;      This product includes software developed by Yukimitsu Izawa.
;; 4. The name of Yukimitsu Izawa may not be used to endorse or promote products
;;    derived from this software without specific prior written permission.
;;
;; THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
;; IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
;; OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
;; IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
;; INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
;; NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
;; DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
;; THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
;; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
;; THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

; How to install:
; Place this file into your load-path directory. like this,
; % cp maximize.el ~/elisp
; and add this line into your .emacs.
; (setq load-path (append (list (expand-file-name "~/elisp/")) load-path))
;
; (require 'maximize)
; (global-set-key [f9] 'maximize-toggle-frame-vmax)
; (global-set-key [f11] 'maximize-toggle-frame-hmax)
;

(provide 'maximize)
(defvar maximize-window-alist nil)
(defvar x-pixel-ratio 0.96)
(defvar y-pixel-ratio 0.9)


(defun maximize-toggle-frame-vmax ()
  (interactive)
  (let* ((current-my-window 
	  (progn
	    (unless (assoc (intern (cdr (assoc 'window-id (frame-parameters (selected-frame))))) maximize-window-alist)
	      (add-to-list 'maximize-window-alist
			   (cons (intern (cdr (assoc 'window-id (frame-parameters (selected-frame)))))
				 (mapcar '(lambda (x) (cons x (cons (cdr (assoc x (frame-parameters (selected-frame)))) nil)))
					 '(left top height width vmax-flag hmax-flag)))))
	    (assoc (intern (cdr (assoc 'window-id (frame-parameters (selected-frame))))) maximize-window-alist)))
	 (current-vmax-flag (car (cdr (assoc 'vmax-flag current-my-window))))
	 (current-hmax-flag (car (cdr (assoc 'hmax-flag current-my-window))))
	 (current-top (car (cdr (assoc 'top current-my-window))))
	 (current-left (car (cdr (assoc 'left current-my-window))))
	 (current-height (car (cdr (assoc 'height current-my-window))))
	 (current-width (car (cdr (assoc 'width current-my-window)))))
    (if (not current-vmax-flag)
	(progn
	  (unless current-hmax-flag
	    (setcdr (assoc  (intern (cdr (assoc 'window-id (frame-parameters (selected-frame))))) 
			    maximize-window-alist) (mapcar '(lambda (x) (cons x (cons (cdr (assoc x (frame-parameters (selected-frame)))) nil))) 
						     '(left top height width vmax-flag hmax-flag))))
	  (if current-hmax-flag
	      (set-frame-position (selected-frame) 0 0)
	    (set-frame-position (selected-frame) 
				(car (cdr (assoc 'left (assoc (intern (cdr (assoc 'window-id (frame-parameters (selected-frame)))))
							      maximize-window-alist)))) 0)) 
	  (set-frame-height (selected-frame) (round (* y-pixel-ratio (/ (x-display-pixel-height) (frame-char-height)))))
	  (setcdr (assoc 'vmax-flag
			 (assoc (intern (cdr (assoc 'window-id (frame-parameters (selected-frame))))) maximize-window-alist)) (cons t nil)))
      (if current-hmax-flag
	  (set-frame-position (selected-frame) 0 current-top)
	(set-frame-position (selected-frame) current-left current-top))
      (set-frame-height (selected-frame) current-height)
      (setcdr (assoc 'vmax-flag
		     (assoc (intern (cdr (assoc 'window-id (frame-parameters (selected-frame))))) maximize-window-alist)) (cons nil nil)))))

(defun maximize-toggle-frame-hmax ()
  (interactive)
  (let* ((current-my-window 
	  (progn
	    (unless (assoc (intern (cdr (assoc 'window-id (frame-parameters (selected-frame))))) maximize-window-alist)
	      (add-to-list 'maximize-window-alist
			   (cons (intern (cdr (assoc 'window-id (frame-parameters (selected-frame))))) 
				 (mapcar '(lambda (x) (cons x (cons (cdr (assoc x (frame-parameters (selected-frame)))) nil)))
					 '(left top height width vmax-flag hmax-flag)))))
	    (assoc (intern (cdr (assoc 'window-id (frame-parameters (selected-frame))))) maximize-window-alist)))
	 (current-vmax-flag (car (cdr (assoc 'vmax-flag current-my-window))))
	 (current-hmax-flag (car (cdr (assoc 'hmax-flag current-my-window))))
	 (current-top (car (cdr (assoc 'top current-my-window))))
	 (current-left (car (cdr (assoc 'left current-my-window))))
	 (current-height (car (cdr (assoc 'height current-my-window))))
	 (current-width (car (cdr (assoc 'width current-my-window)))))
    (if (not current-hmax-flag)
	(progn
	  (unless current-vmax-flag
	    (setcdr (assoc  (intern (cdr (assoc 'window-id (frame-parameters (selected-frame)))))
			    maximize-window-alist) (mapcar '(lambda (x) (cons x (cons (cdr (assoc x (frame-parameters (selected-frame)))) nil))) 
						     '(left top height width vmax-flag hmax-flag))))
	  (if current-vmax-flag
	      (set-frame-position (selected-frame) 0 0)
	    (set-frame-position (selected-frame) 
				0 (car (cdr (assoc 'top (assoc (intern (cdr (assoc 'window-id (frame-parameters (selected-frame)))))
							       maximize-window-alist)))))) 
	  (set-frame-width (selected-frame) (round (* x-pixel-ratio (/ (x-display-pixel-width) (frame-char-width)))))
	  (setcdr (assoc 'hmax-flag
			 (assoc (intern (cdr (assoc 'window-id (frame-parameters (selected-frame))))) maximize-window-alist)) (cons t nil)))
      (if current-vmax-flag
	  (set-frame-position (selected-frame) current-left 0)
	(set-frame-position (selected-frame) current-left current-top))
      (set-frame-width (selected-frame) current-width)
      (setcdr (assoc 'hmax-flag
		     (assoc (intern (cdr (assoc 'window-id (frame-parameters (selected-frame))))) maximize-window-alist)) (cons nil nil)))))
