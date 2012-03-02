# maximize.el

Maximize your emacs frames vertically or horizontally.

## How to install:
Place this file into your load-path directory. like this,
`(setq load-path (append (list (expand-file-name "~/elisp/")) load-path))`

    % cp maximize.el ~/elisp

 and add this line into your .emacs.

    (require 'maximize)

 If you want to bind Hot-keys, add setting lines like below.

    (global-set-key [f9] 'maximize-toggle-frame-vmax)
    (global-set-key [f11] 'maximize-toggle-frame-hmax)

## Screen shots

* normal
![normal](https://github.com/izawa/maximize/raw/master/images/normal.jpg)

* maximized vertically
![vertical](https://github.com/izawa/maximize/raw/master/images/maximize-vertical.jpg)

* maximized horizontally
![horizontal](https://github.com/izawa/maximize/raw/master/images/maximize-horizontal.jpg)

* maximized both (like a full screen)
![both](https://github.com/izawa/maximize/raw/master/images/maximize-both.jpg)

