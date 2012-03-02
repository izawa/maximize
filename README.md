# maximize.el

Maximize your emacs frames vertically or horizontally.

## How to install:
### Clone file into your emacs directory
    cd ~/.emacs.d
    git git clone git@github.com:izawa/maximize.git

### Add load path subdirectory recursively
    (let ((default-directory "~/.emacs.d/"))
      (normal-top-level-add-subdirs-to-load-path))

### Add require into your .emacs.

    (require 'maximize)

### Additional setting
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

