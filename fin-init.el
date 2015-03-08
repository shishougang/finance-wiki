
(show-paren-mode 1)
(menu-bar-mode 0)

(setq make-backup-files nil
      vc-handled-backends nil)

(setq org-export-default-language "en"
      org-export-html-extension "html"
      org-export-with-timestamps nil
      org-export-with-section-numbers nil
      org-export-with-tags 'not-in-toc
      org-export-skip-text-before-1st-heading nil
      org-export-with-sub-superscripts '{}
      org-export-with-LaTeX-fragments t
      org-export-with-archived-trees nil
      org-export-highlight-first-table-line t
      org-export-latex-listings-w-names nil
      org-html-head-include-default-style nil
      org-html-head ""
      org-export-htmlize-output-type 'css
      org-startup-folded nil
      org-export-allow-BIND t
      org-publish-list-skipped-files t
      org-publish-use-timestamps-flag t
      org-export-babel-evaluate nil
      org-confirm-babel-evaluate nil)

(eval-after-load "org-html"
'(setq org-html-scripts
       (concat org-html-scripts "\n"
           "<script type=\"text/javascript\">
    function rpl(expr,a,b) {
      var i=0
      while (i!=-1) {
         i=expr.indexOf(a,i);
         if (i>=0) {
            expr=expr.substring(0,i)+b+expr.substring(i+a.length);
            i+=b.length;
         }
      }
      return expr
    }

    function show_org_source(){
       document.location.href = rpl(document.location.href,\"html\",\"org.html\");
    }
</script>
")))

;; re-export everything regardless of whether or not it's been modified
;; (setq org-publish-use-timestamps-flag nil)

(setq fin-wiki-root-dir
      (file-name-directory (or load-file-name (buffer-file-name))))
(setq fin-wiki-publish-dir
      (directory-file-name
       (file-name-directory
        (directory-file-name fin-wiki-root-dir))))
(setq preamble-path (concat fin-wiki-root-dir "/preamble.html"))
(setq disqus-path (concat fin-wiki-root-dir "/disqus.html"))


(add-to-list 'org-publish-project-alist
        `("fin-notes"
           :base-directory ,fin-wiki-root-dir
           :base-extension "org"
           :exclude "FIXME"
           :html-extension "html"
           :publishing-directory ,fin-wiki-publish-dir
           :publishing-function org-html-publish-to-html
           :html-head "<link rel=\"stylesheet\" href=\"/stylesheets/bootstrap.min.css\" media=\"screen\" />
<link rel=\"stylesheet\" href=\"/stylesheets/bootstrap-responsive.min.css\" media=\"screen\" />
<link rel=\"stylesheet\" href=\"/stylesheets/org.css\" type=\"text/css\" />
<link rel=\"SHORTCUT ICON\" href=\"/favicon.png\" type=\"image/x-icon\" />
<link rel=\"icon\" href=\"/favicon.png\" type=\"image/ico\" />
<script src=\"/javascripts/bootstrap.min.js\"></script>"
           :recursive t
           :html-preamble ,(with-temp-buffer (insert-file-contents preamble-path) (buffer-string))  
           :html-postamble ,(with-temp-buffer (insert-file-contents disqus-path) (buffer-string))
           :auto-index t
  ;         :index-filename "index.org"
  ;         :index-title "index"
           ;:auto-preamble t
           :style-include-default nil  ;Disable the default css style
           :export-creator-info nil    ; Disable the inclusion of "Created by Org" in the postamble.
           :export-author-info nil     ; Disable the inclusion of "Author: Your Name" in the postamble.
           :auto-postamble nil         ; Disable auto postamble
           :table-of-contents t        ; Set this to "t" if you want a table of contents, set to "nil" disables TOC.
           :section-numbers nil        ; Set this to "t" if you want headings to have numbers.
           :auto-sitemap t                ; Generate sitemap.org automagically..
           :sitemap-filename "index.org"  ; ... call it sitemap.org (it's the default)...
           :sitemap-title "index"         ; ... with title 'sitemap'.
           :link-home "index.html"))

(add-to-list 'org-publish-project-alist
      `("fin-static"
           :base-directory ,fin-wiki-root-dir
           :publishing-directory ,fin-wiki-publish-dir
           :recursive t
           :base-extension "css\\|js\\|png\\|jpg\\|jpeg\\|svg\\|gif\\|pdf\\|mp3\\|swf\\|zip\\|gz\\|txt\\|el\\|tar.gz\\|c\\|cpp\\|sh"
           :publishing-function org-publish-attachment))

(add-to-list 'org-publish-project-alist
        `("fin"
           :components ("fin-notes" "fin-static")
           :author "shougangshi@gmail.com"))
