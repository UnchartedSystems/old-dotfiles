;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Dan Whitaker"
      user-mail-address "dan@uncharted.systems")

;; Banner Image
(setq +doom-dashboard-banner-file "zcacodemon.png"
      ;; +doom-dashboard-banner-file "emacs-e.svg"
      +doom-dashboard-banner-dir "~/.config/doom/")

;; Theme
(setq doom-theme 'doom-moonlight)

;; Font

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

(setq doom-font (font-spec  :size 20)   ;:weight 'semi-light
                                        ;doom-variable-pitch-font (font-spec) ; inherits `doom-font''s :size
      doom-symbol-font (font-spec :size 20)
      doom-big-font (font-spec :size 24))

;; Hotkeys!
(global-set-key (kbd "<f1>") 'helm-ag)
(global-set-key (kbd "<f2>") 'helm-show-kill-ring)
(global-set-key (kbd "<f3>") 'vundo)
(global-set-key (kbd "<f4>") 'elpher)

;; Org Mode Config
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-log-location (concat org-directory "work-log.org"))
(after! org
  (add-to-list 'org-capture-templates
               '("l" "Log Work Entry" entry
                 (file+datetree org-log-location)
                 "* %?" :prepend f :empty-lines 0)))

;; General Settings (alphabetical)
(setq-default
 confirm-kill-emacs nil
 ;; delete-by-moving-to-trash t          ; Delete files to trash
 ;; inhibit-compacting-font-caches t     ; When there are lots of glyphs, keep them in memory                                        ;
 ;; pixel-scroll-precision-mode nil      ; smooth scrolling
 ;; undo-in-region t                     ; Select a region to prioritize regional undos
 ;; uniquify-buffer-name-style 'forward  ; Uniquify buffer names
 window-combination-resize t             ; take new window space from all relevant windows (not just current)
 x-stretch-cursor t)

;; More General Settings
(setq auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      display-line-numbers-type t                 ; Set to 'nil', 't', or 'relative'
      doom-modeline-height 30
      evil-move-beyond-eol t                      ; Helps evil play nice with cleverparens
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      password-cache-expiry nil                   ; I can trust my computers ... can't I?
      scroll-margin 2                             ; It's nice to maintain a little margin
      ;; scroll-preserve-screen-position 'always  ; Don't have `point' jump around
      truncate-string-ellipsis "…"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
      which-key-idle-delay 0.3                    ; Makes the which-key spc popup vrooom
      undo-limit 80000000)                        ; Raise undo-limit to 80Mb

(setq which-key-allow-multiple-replacements t)
(after! which-key ; Removes verbose which-key prefixes
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "◂\\1")) ; I find these regex terrifying
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "◃\\1"))
   ))

(display-time-mode 0)   ; Enable time in the mode-line
(global-subword-mode 1) ; Iterate through CamelCase words

;; Tailwind Setup: TODO Finish working setup
;; https://clojurians-log.clojureverse.org/lsp/2024-03-01
(setq lsp-tailwindcss-add-on-mode t
      lsp-tailwindcss-experimental-class-regex ["\"([^\"]*)\""]
      lsp-tailwindcss-major-modes '(rjsx-mode web-mode html-mode css-mode typescript-mode typescript-tsx-mode clojure-mode clojurec-mode clojurescript-mode))

;; Evil-cleverparens config
(use-package! evil-cleverparens ; copied & pasted
  :after evil
  :custom (evil-cleverparens-use-additional-bindings t) ; barfing and slurping
  :hook (paredit-mode . evil-cleverparens-mode))

(use-package! paredit
  :hook (emacs-lisp-mode . paredit-mode)
  :hook (clojure-mode . paredit-mode)
  :hook (lisp-mode . paredit-mode)
  :hook (common-lisp-mode . paredit-mode))

;; Evil Goggles Config with cleverparens compatibility
;; (use-package! evil-goggles
;;   :after evil-cleverparens
;;   :config
;;   (add-to-list 'evil-goggles--commands '(evil-cp-yank :face evil-goggles-yank-face :switch evil-goggles-enable-yank :advice evil-goggles--generic-async-advice))
;;   (add-to-list 'evil-goggles--commands '(evil-cp-yank-line :face evil-goggles-yank-face :switch evil-goggles-enable-yank :advice evil-goggles--generic-async-advice))
;;   (add-to-list 'evil-goggles--commands '(evil-cp-yank-sexp :face evil-goggles-yank-face :switch evil-goggles-enable-yank :advice evil-goggles--generic-async-advice))
;;   (add-to-list 'evil-goggles--commands '(evil-cp-yank :face evil-goggles-yank-face :switch evil-goggles-enable-yank :advice evil-goggles--generic-async-advice))
;;   (add-to-list 'evil-goggles--commands '(evil-cp-yank :face evil-goggles-yank-face :switch evil-goggles-enable-yank :advice evil-goggles--generic-async-advice))
;;   (add-to-list 'evil-goggles--commands '(evil-cp-delete :face evil-goggles-delete-face :switch evil-goggles-enable-delete :advice evil-goggles--delete-line-advice))
;;   (add-to-list 'evil-goggles--commands '(evil-cp-delete-line :face evil-goggles-delete-face :switch evil-goggles-enable-delete :advice evil-goggles--delete-line-advice))
;;   (add-to-list 'evil-goggles--commands '(evil-cp-change :face evil-goggles-change-face :switch evil-goggles-enable-change :advice evil-goggles--generic-blocking-advice))
;;   (add-to-list 'evil-goggles--commands '(evil-cp-change-line :face evil-goggles-change-face :switch evil-goggles-enable-change :advice evil-goggles--generic-blocking-advice))
;;   (add-to-list 'evil-goggles--commands '(evil-cp-change-sexp :face evil-goggles-change-face :switch evil-goggles-enable-change :advice evil-goggles--generic-blocking-advice))
;;   (add-to-list 'evil-goggles--commands '(evil-cp-change-enclosing :face evil-goggles-change-face :switch evil-goggles-enable-change :advice evil-goggles--generic-blocking-advice))
;;   (add-to-list 'evil-goggles--commands '(evil-cp-change-whole-line :face evil-goggles-change-face :switch evil-goggles-enable-change :advice evil-goggles--generic-blocking-advice))
;;   (evil-goggles-mode))

;; Adds variable pitch fonts & coloring to manual pages
(use-package! info-colors
  :commands (info-colors-fontify-node))

(add-hook 'Info-selection-hook 'info-colors-fontify-node)

;; Elpher config
(setq elpher-gemini-max-fill-width  100
      elpher-gemini-TLS-cert-checks nil
      elpher-ipv4-always            t
      elpher-open-urls-with-eww     t
      elpher-default-url-type       "gemini")

;; POSIX shell (Fish workaround)
(setq shell-file-name (executable-find "bash"))

;; Clojure: Debugging empty stack traces!
;; (setq cider-clojure-cli-global-options "-J-XX:-OmitStackTraceInFastThrow")

;; Nov.el configuration for making epubs cozy (straight from tecosaur
(use-package! nov
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (map! :map nov-mode-map
        :n "RET" #'nov-scroll-up)

  (advice-add 'nov-render-title :override #'ignore)

  (defun +nov-mode-setup ()
    "Tweak nov-mode to our liking."
    ;; (face-remap-add-relative 'variable-pitch
    ;;                          :family "Merriweather"
    ;;                          :height 1.4
    ;;                          :width 'semi-expanded)
    (face-remap-add-relative 'default :height 1.3)
    (variable-pitch-mode 1)
    (setq-local line-spacing 0.2
                next-screen-context-lines 4
                shr-use-colors nil)
    (when (require 'visual-fill-column nil t)
      (setq-local visual-fill-column-center-text t
                  visual-fill-column-width 64
                  nov-text-width 106)
      (visual-fill-column-mode 1))
    (when (featurep 'hl-line-mode)
      (hl-line-mode -1))
    ;; Re-render with new display settings
    (nov-render-document)
    ;; Look up words with the dictionary.
    (add-to-list '+lookup-definition-functions #'+lookup/dictionary-definition))

  (add-hook 'nov-mode-hook #'+nov-mode-setup))

;; Modeline Customization
(after! doom-modeline
  (defvar doom-modeline-nov-title-max-length 40)
  (doom-modeline-def-segment nov-author
    (propertize
     (cdr (assoc 'creator nov-metadata))
     'face (doom-modeline-face 'doom-modeline-project-parent-dir)))
  (doom-modeline-def-segment nov-title
    (let ((title (or (cdr (assoc 'title nov-metadata)) "")))
      (if (<= (length title) doom-modeline-nov-title-max-length)
          (concat " " title)
        (propertize
         (concat " " (truncate-string-to-width title doom-modeline-nov-title-max-length nil nil t))
         'help-echo title))))
  (doom-modeline-def-segment nov-current-page
    (let ((words (count-words (point-min) (point-max))))
      (propertize
       (format " %d/%d"
               (1+ nov-documents-index)
               (length nov-documents))
       'face (doom-modeline-face 'doom-modeline-info)
       'help-echo (if (= words 1) "1 word in this chapter"
                    (format "%s words in this chapter" words)))))
  (doom-modeline-def-segment scroll-percentage-subtle
    (concat
     (doom-modeline-spc)
     (propertize (format-mode-line '("" doom-modeline-percent-position "%%"))
                 'face (doom-modeline-face 'shadow)
                 'help-echo "Buffer percentage")))

  (doom-modeline-def-modeline 'nov
    '(workspace-name window-number nov-author nov-title nov-current-page scroll-percentage-subtle))

  (add-to-list 'doom-modeline-mode-alist '(nov-mode . nov)))

;; Org Mode Super Agenda Package
(use-package! org-super-agenda
  :commands org-super-agenda-mode)

(setq org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-block-separator nil
      org-agenda-tags-column 100 ;; from testing this seems to be a good value
      org-agenda-compact-blocks t)

;; NOTE: configure for yourself
;; (setq org-agenda-custom-commands
;;       '(("o" "Overview"
;;          ((agenda "" ((org-agenda-span 'day)
;;                       (org-super-agenda-groups
;;                        '((:name "Today"
;;                           :time-grid t
;;                           :date today
;;                           :todo "TODAY"
;;                           :scheduled today
;;                           :order 1)))))
;;           (alltodo "" ((org-agenda-overriding-header "")
;;                        (org-super-agenda-groups
;;                         '((:name "Next to do"
;;                            :todo "NEXT"
;;                            :order 1)
;;                           (:name "Important"
;;                            :tag "Important"
;;                            :priority "A"
;;                            :order 6)
;;                           (:name "Due Today"
;;                            :deadline today
;;                            :order 2)
;;                           (:name "Due Soon"
;;                            :deadline future
;;                            :order 8)
;;                           (:name "Overdue"
;;                            :deadline past
;;                            :face error
;;                            :order 7)
;;                           (:name "Assignments"
;;                            :tag "Assignment"
;;                            :order 10)
;;                           (:name "Issues"
;;                            :tag "Issue"
;;                            :order 12)
;;                           (:name "Emacs"
;;                            :tag "Emacs"
;;                            :order 13)
;;                           (:name "Projects"
;;                            :tag "Project"
;;                            :order 14)
;;                           (:name "Research"
;;                            :tag "Research"
;;                            :order 15)
;;                           (:name "To read"
;;                            :tag "Read"
;;                            :order 30)
;;                           (:name "Waiting"
;;                            :todo "WAITING"
;;                            :order 20)
;;                           (:name "University"
;;                            :tag "uni"
;;                            :order 32)
;;                           (:name "Trivial"
;;                            :priority<= "E"
;;                            :tag ("Trivial" "Unimportant")
;;                            :todo ("SOMEDAY" )
;;                            :order 90)
;;                           (:discard (:tag ("Chore" "Routine" "Daily")))))))))))


;; doct (Declarative Org Capture Templates) seems to be a nicer way to set up org-capture.
(use-package! doct
  :commands doct)

(after! org-capture
                                        ; <<prettify-capture>>

  (defun +doct-icon-declaration-to-icon (declaration)
    "Convert :icon declaration to icon"
    (let ((name (pop declaration))
          (set  (intern (concat "nerd-icons-" (plist-get declaration :set))))
          (face (intern (concat "nerd-icons-" (plist-get declaration :color))))
          (v-adjust (or (plist-get declaration :v-adjust) 0.01)))
      (apply set `(,name :face ,face :v-adjust ,v-adjust))))

  (defun +doct-iconify-capture-templates (groups)
    "Add declaration's :icon to each template group in GROUPS."
    (let ((templates (doct-flatten-lists-in groups)))
      (setq doct-templates (mapcar (lambda (template)
                                     (when-let* ((props (nthcdr (if (= (length template) 4) 2 5) template))
                                                 (spec (plist-get (plist-get props :doct) :icon)))
                                       (setf (nth 1 template) (concat (+doct-icon-declaration-to-icon spec)
                                                                      "\t"
                                                                      (nth 1 template))))
                                     template)
                                   templates))))

  (setq doct-after-conversion-functions '(+doct-iconify-capture-templates))

  (defvar +org-capture-recipes  "~/org/recipes.org")

  (defun set-org-capture-templates ()
    (setq org-capture-templates
          (doct `(("Personal todo" :keys "t"
                   :icon ("nf-oct-checklist" :set "octicon" :color "green")
                   :file +org-capture-todo-file
                   :prepend t
                   :headline "Inbox"
                   :type entry
                   :template ("* TODO %?"
                              "%i %a"))
                  ("Personal note" :keys "n"
                   :icon ("nf-fa-sticky_note_o" :set "faicon" :color "green")
                   :file +org-capture-todo-file
                   :prepend t
                   :headline "Inbox"
                   :type entry
                   :template ("* %?"
                              "%i %a"))
                  ("Interesting" :keys "i"
                   :icon ("nf-fa-eye" :set "faicon" :color "lcyan")
                   :file +org-capture-todo-file
                   :prepend t
                   :headline "Interesting"
                   :type entry
                   :template ("* [ ] %{desc}%? :%{i-type}:"
                              "%i %a")
                   :children (("Webpage" :keys "w"
                               :icon ("nf-fa-globe" :set "faicon" :color "green")
                               :desc "%(org-cliplink-capture) "
                               :i-type "read:web")
                              ("Article" :keys "a"
                               :icon ("nf-fa-file_text_o" :set "faicon" :color "yellow")
                               :desc ""
                               :i-type "read:reaserch")
                              ("Recipe" :keys "r"
                               :icon ("nf-fa-spoon" :set "faicon" :color "dorange")
                               :file +org-capture-recipes
                               :headline "Unsorted"
                               :template "%(org-chef-get-recipe-from-url)")
                              ("Information" :keys "i"
                               :icon ("nf-fa-info_circle" :set "faicon" :color "blue")
                               :desc ""
                               :i-type "read:info")
                              ("Idea" :keys "I"
                               :icon ("nf-md-chart_bubble" :set "mdicon" :color "silver")
                               :desc ""
                               :i-type "idea")))
                  ("Tasks" :keys "k"
                   :icon ("nf-oct-inbox" :set "octicon" :color "yellow")
                   :file +org-capture-todo-file
                   :prepend t
                   :headline "Tasks"
                   :type entry
                   :template ("* TODO %? %^G%{extra}"
                              "%i %a")
                   :children (("General Task" :keys "k"
                               :icon ("nf-oct-inbox" :set "octicon" :color "yellow")
                               :extra "")
                              ("Task with deadline" :keys "d"
                               :icon ("nf-md-timer" :set "mdicon" :color "orange" :v-adjust -0.1)
                               :extra "\nDEADLINE: %^{Deadline:}t")
                              ("Scheduled Task" :keys "s"
                               :icon ("nf-oct-calendar" :set "octicon" :color "orange")
                               :extra "\nSCHEDULED: %^{Start time:}t")))
                  ("Project" :keys "p"
                   :icon ("nf-oct-repo" :set "octicon" :color "silver")
                   :prepend t
                   :type entry
                   :headline "Inbox"
                   :template ("* %{time-or-todo} %?"
                              "%i"
                              "%a")
                   :file ""
                   :custom (:time-or-todo "")
                   :children (("Project-local todo" :keys "t"
                               :icon ("nf-oct-checklist" :set "octicon" :color "green")
                               :time-or-todo "TODO"
                               :file +org-capture-project-todo-file)
                              ("Project-local note" :keys "n"
                               :icon ("nf-fa-sticky_note" :set "faicon" :color "yellow")
                               :time-or-todo "%U"
                               :file +org-capture-project-notes-file)
                              ("Project-local changelog" :keys "c"
                               :icon ("nf-fa-list" :set "faicon" :color "blue")
                               :time-or-todo "%U"
                               :heading "Unreleased"
                               :file +org-capture-project-changelog-file)))
                  ("\tCentralised project templates"
                   :keys "o"
                   :type entry
                   :prepend t
                   :template ("* %{time-or-todo} %?"
                              "%i"
                              "%a")
                   :children (("Project todo"
                               :keys "t"
                               :prepend nil
                               :time-or-todo "TODO"
                               :heading "Tasks"
                               :file +org-capture-central-project-todo-file)
                              ("Project note"
                               :keys "n"
                               :time-or-todo "%U"
                               :heading "Notes"
                               :file +org-capture-central-project-notes-file)
                              ("Project changelog"
                               :keys "c"
                               :time-or-todo "%U"
                               :heading "Unreleased"
                               :file +org-capture-central-project-changelog-file)))))))

  (set-org-capture-templates)
  (unless (display-graphic-p)
    (add-hook 'server-after-make-frame-hook
              (defun org-capture-reinitialise-hook ()
                (when (display-graphic-p)
                  (set-org-capture-templates)
                  (remove-hook 'server-after-make-frame-hook
                               #'org-capture-reinitialise-hook))))))

;; That was very long...

;; Let's make org-capture look better now:
(defun org-capture-select-template-prettier (&optional keys)
  "Select a capture template, in a prettier way than default
Lisp programs can force the template by setting KEYS to a string."
  (let ((org-capture-templates
         (or (org-contextualize-keys
              (org-capture-upgrade-templates org-capture-templates)
              org-capture-templates-contexts)
             '(("t" "Task" entry (file+headline "" "Tasks")
                "* TODO %?\n  %u\n  %a")))))
    (if keys
        (or (assoc keys org-capture-templates)
            (error "No capture template referred to by \"%s\" keys" keys))
      (org-mks org-capture-templates
               "Select a capture template\n━━━━━━━━━━━━━━━━━━━━━━━━━"
               "Template key: "
               `(("q" ,(concat (nerd-icons-octicon "nf-oct-stop" :face 'nerd-icons-red :v-adjust 0.01) "\tAbort")))))))
(advice-add 'org-capture-select-template :override #'org-capture-select-template-prettier)

(defun org-mks-pretty (table title &optional prompt specials)
  "Select a member of an alist with multiple keys. Prettified.

TABLE is the alist which should contain entries where the car is a string.
There should be two types of entries.

1. prefix descriptions like (\"a\" \"Description\")
   This indicates that `a' is a prefix key for multi-letter selection, and
   that there are entries following with keys like \"ab\", \"ax\"…

2. Select-able members must have more than two elements, with the first
   being the string of keys that lead to selecting it, and the second a
   short description string of the item.

The command will then make a temporary buffer listing all entries
that can be selected with a single key, and all the single key
prefixes.  When you press the key for a single-letter entry, it is selected.
When you press a prefix key, the commands (and maybe further prefixes)
under this key will be shown and offered for selection.

TITLE will be placed over the selection in the temporary buffer,
PROMPT will be used when prompting for a key.  SPECIALS is an
alist with (\"key\" \"description\") entries.  When one of these
is selected, only the bare key is returned."
  (save-window-excursion
    (let ((inhibit-quit t)
          (buffer (org-switch-to-buffer-other-window "*Org Select*"))
          (prompt (or prompt "Select: "))
          case-fold-search
          current)
      (unwind-protect
          (catch 'exit
            (while t
              (setq-local evil-normal-state-cursor (list nil))
              (erase-buffer)
              (insert title "\n\n")
              (let ((des-keys nil)
                    (allowed-keys '("\C-g"))
                    (tab-alternatives '("\s" "\t" "\r"))
                    (cursor-type nil))
                ;; Populate allowed keys and descriptions keys
                ;; available with CURRENT selector.
                (let ((re (format "\\`%s\\(.\\)\\'"
                                  (if current (regexp-quote current) "")))
                      (prefix (if current (concat current " ") "")))
                  (dolist (entry table)
                    (pcase entry
                      ;; Description.
                      (`(,(and key (pred (string-match re))) ,desc)
                       (let ((k (match-string 1 key)))
                         (push k des-keys)
                         ;; Keys ending in tab, space or RET are equivalent.
                         (if (member k tab-alternatives)
                             (push "\t" allowed-keys)
                           (push k allowed-keys))
                         (insert (propertize prefix 'face 'font-lock-comment-face) (propertize k 'face 'bold) (propertize "›" 'face 'font-lock-comment-face) "  " desc "…" "\n")))
                      ;; Usable entry.
                      (`(,(and key (pred (string-match re))) ,desc . ,_)
                       (let ((k (match-string 1 key)))
                         (insert (propertize prefix 'face 'font-lock-comment-face) (propertize k 'face 'bold) "   " desc "\n")
                         (push k allowed-keys)))
                      (_ nil))))
                ;; Insert special entries, if any.
                (when specials
                  (insert "─────────────────────────\n")
                  (pcase-dolist (`(,key ,description) specials)
                    (insert (format "%s   %s\n" (propertize key 'face '(bold nerd-icons-red)) description))
                    (push key allowed-keys)))
                ;; Display UI and let user select an entry or
                ;; a sub-level prefix.
                (goto-char (point-min))
                (unless (pos-visible-in-window-p (point-max))
                  (org-fit-window-to-buffer))
                (let ((pressed (org--mks-read-key allowed-keys
                                                  prompt
                                                  (not (pos-visible-in-window-p (1- (point-max)))))))
                  (setq current (concat current pressed))
                  (cond
                   ((equal pressed "\C-g") (user-error "Abort"))
                   ;; Selection is a prefix: open a new menu.
                   ((member pressed des-keys))
                   ;; Selection matches an association: return it.
                   ((let ((entry (assoc current table)))
                      (and entry (throw 'exit entry))))
                   ;; Selection matches a special entry: return the
                   ;; selection prefix.
                   ((assoc current specials) (throw 'exit current))
                   (t (error "No entry available")))))))
        (when buffer (kill-buffer buffer))))))
(advice-add 'org-mks :override #'org-mks-pretty)


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

