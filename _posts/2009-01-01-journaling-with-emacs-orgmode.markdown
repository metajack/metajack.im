---
layout: post
title: Journaling with Emacs OrgMode
time: "21:17"
tags: [emacs, orgmode, code, lisp]
extended: ":EXTENDED:"
---

I like to keep a daily journal of what I'm working on so that I can
look back and see what I was up to yesterday or a week ago.  I
sometimes shift context so often during a day that I completely forget
what I was previously doing.  I used to do this manually in a plain
text file, but now I've automated it using [Emacs](todo)
[OrgMode](http://orgmode.org).

:EXTENDED:

From anywhere in Emacs, I just hit `C-c j` and it opens up my journal,
creates a new entry if today's entry doesn't already exist, and let's
me start typing.  It also narrows the buffer in Emacs so that I only
see today's entry when I'm journaling.

It might be nice to extend this similarly to my Emacs GTD capture
system.  I could bind a system wide hot key to open a new frame with
the current journal entry; then I could get to my journal easily from
anywhere.

Here's the code for those who are interested.

<code>
<pre name='code' class='lisp'>
(defvar org-journal-file "~/Documents/org/journal.org"
  "Path to OrgMode journal file.")
(defvar org-journal-date-format "%Y-%m-%d"
  "Date format string for journal headings.")

(defun org-journal-entry ()
  "Create a new diary entry for today or append to an existing one."
  (interactive)
  (switch-to-buffer (find-file org-journal-file))
  (widen)
  (let ((today (format-time-string org-journal-date-format)))
    (beginning-of-buffer)
    (unless (org-goto-local-search-forward-headings today nil t)
      ((lambda () 
         (org-insert-heading)
         (insert today)
         (insert "\n\n  \n"))))
    (beginning-of-buffer)
    (org-show-entry)
    (org-narrow-to-subtree)
    (end-of-buffer)
    (backward-char 2)
    (unless (= (current-column) 2)
      (insert "\n\n  "))))
</pre>
</code>
