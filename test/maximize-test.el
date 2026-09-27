;;; maximize-test.el --- Tests for maximize -*- lexical-binding: t; -*-

(require 'ert)
(require 'cl-lib)
(require 'maximize)

(defmacro maximize-test--with-geometry (workarea outer text char &rest body)
  "Run BODY with mock frame geometry and a 1440 pixel display."
  (declare (indent 4))
  `(cl-letf (((symbol-function 'x-display-pixel-height) (lambda (&rest _) 1440))
             ((symbol-function 'frame-monitor-attributes)
              (lambda (&rest _) (list (cons 'workarea ,workarea))))
             ((symbol-function 'frame-outer-height) (lambda (&rest _) ,outer))
             ((symbol-function 'frame-text-height) (lambda (&rest _) ,text))
             ((symbol-function 'frame-char-height) (lambda (&rest _) ,char)))
     ,@body))

(ert-deftest maximize-height-macos-decorations ()
  ;; Emacs 31.1 / macOS 26: the old 81-line frame is 1328 pixels tall,
  ;; exceeding the 1320-pixel work area by 8 pixels.
  (let ((y-pixel-ratio 0.9))
    (maximize-test--with-geometry '(0 30 2560 1320) 1328 1296 16
      (let ((lines (maximize--frame-height (selected-frame))))
        (should (= lines 80))
        (should (<= (+ (* lines 16) 32) 1320))
        (should (> (+ (* (1+ lines) 16) 32) 1320))))))

(ert-deftest maximize-height-respects-smaller-ratio ()
  (let ((y-pixel-ratio 0.5))
    (maximize-test--with-geometry '(0 30 2560 1320) 1328 1296 16
      (should (= (maximize--frame-height (selected-frame)) 45)))))

(ert-deftest maximize-height-includes-toolbars-and-borders ()
  (let ((y-pixel-ratio 1.0))
    (maximize-test--with-geometry '(0 30 2560 1320) 900 810 18
      (should (= (maximize--frame-height (selected-frame)) 68)))))

(ert-deftest maximize-height-without-workarea-rounds-down ()
  (let ((y-pixel-ratio 0.9))
    (maximize-test--with-geometry nil 900 810 17
      (should (= (maximize--frame-height (selected-frame)) 76)))))

(ert-deftest maximize-height-without-monitor-api ()
  (let ((y-pixel-ratio 0.9))
    (maximize-test--with-geometry nil 900 810 17
      (cl-letf (((symbol-function 'frame-monitor-attributes) nil))
        (should (= (maximize--frame-height (selected-frame)) 76))))))

(ert-deftest maximize-height-at-least-one-line ()
  (let ((y-pixel-ratio 0.9))
    (maximize-test--with-geometry '(0 0 100 20) 100 60 16
      (should (= (maximize--frame-height (selected-frame)) 1)))))

(ert-deftest maximize-vmax-restores-position-and-height ()
  (let ((maximize-window-alist nil)
        (y-pixel-ratio 0.9)
        (parameters '((window-id . "maximize-test")
                      (left . 782) (top . 120) (height . 40) (width . 80)))
        positions heights)
    (maximize-test--with-geometry '(0 30 2560 1320) 672 640 16
      (cl-letf (((symbol-function 'frame-parameters) (lambda (&rest _) parameters))
                ((symbol-function 'set-frame-position)
                 (lambda (_frame left top) (push (list left top) positions)))
                ((symbol-function 'set-frame-height)
                 (lambda (_frame height) (push height heights))))
        (maximize-toggle-frame-vmax)
        (maximize-toggle-frame-vmax)
        (should (equal (reverse heights) '(80 40)))
        (should (equal (reverse positions) '((782 0) (782 120))))))))

;;; maximize-test.el ends here
