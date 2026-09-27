# maximize.el

Maximize your emacs frames vertically or horizontally.

## How to install:
### Clone file into your emacs directory
    cd ~/.emacs.d
    git clone git@github.com:izawa/maximize.git

### Add load path subdirectory recursively
    (let ((default-directory "~/.emacs.d/"))
      (normal-top-level-add-subdirs-to-load-path))

### Add require into your .emacs.

    (require 'maximize)

### Additional setting
 If you want to bind Hot-keys, add setting lines like below.

    (global-set-key [f9] 'maximize-toggle-frame-vmax)
    (global-set-key [f11] 'maximize-toggle-frame-hmax)

`y-pixel-ratio` (default `0.9`) controls the requested vertical text height
as a fraction of the display height.  When monitor geometry is available,
the height is capped to the monitor work area minus the title bar, tool bar,
and borders, and rounded down to whole lines.  This prevents the frame from
extending below the usable screen area on Emacs 31.1 / macOS 26.

## Tests

    emacs -Q --batch -L . -l test/maximize-test.el -f ert-run-tests-batch-and-exit

## Screen shots

* normal

![normal](https://github.com/izawa/maximize/raw/master/images/normal.jpg)

* maximized vertically

![vertical](https://github.com/izawa/maximize/raw/master/images/maximize-vertical.jpg)

* maximized horizontally

![horizontal](https://github.com/izawa/maximize/raw/master/images/maximize-horizontal.jpg)

* maximized both (like a full screen)

![both](https://github.com/izawa/maximize/raw/master/images/maximize-both.jpg)

