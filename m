From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sat, 01 Jul 2006 19:04:56 +0000
Subject: [lm-sensors] [RFC PATCH] include statement in
Message-Id: <20060701190456.GA9642@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060701123027.GD3140@jupiter.solarsys.private>
In-Reply-To: <20060701123027.GD3140@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali at linux-fr.org> [2006-07-01 16:16:41 +0200]:
> This doesn't sound like a very useful feature and might even be
> considered a security problem. I would instead suggest that relative
> filenames are resolved based on the directory the including file is
> located in.

It's not a security problem unless someone runs a libsensors program
suid root (which we don't).  But your suggestion is good anyway...
not least because it matches the expectation of C programmers. ;)

Thanks and regards,

Index: sensors.conf.5
=================================--- sensors.conf.5	(revision 4062)
+++ sensors.conf.5	(working copy)
@@ -40,7 +40,8 @@
 not work within a comment,
 .B NAME
 or
-.BR NUMBER .
+.BR NUMBER ,
+nor can lines containing an include statement be continued.
 
 .RS
 bus 
@@ -60,6 +61,9 @@
 ignore
 .B NAME
 .sp 0
+include
+.B FILENAME
+.sp 0
 set 
 .B NAME EXPR
 .RE
@@ -71,6 +75,12 @@
 Within quotes, you can use the normal escape\-codes from C.
 
 A
+.B FILENAME
+is a string.  It may contain letters, digits, dots, dashes, underscores,
+slashes and/or spaces only.  A filename must always appear within double
+quotes.
+
+A
 .B NAME\-LIST
 is one or more
 .B NAME
@@ -300,6 +310,34 @@
 The only argument is the feature name, which may be a feature class;
 in that case the label class is used (see below).
 
+.SS INCLUDE STATEMENT
+.RS
+include "/etc/sensors/foo.conf"
+.RE
+.RS
+include "sensors/foo.conf"
+.RE
+.RS
+include "foo.conf"
+.RE
+
+The
+.I include
+statement causes the program to continue reading configuration from the
+named file.  Upon reaching the end of the named file, the program will
+continue reading configuration from the original file beginning with the
+line after the
+.I include
+statement.
+
+If the filename has no path or a relative path, then the program looks for
+the file starting from the same directory in which the original file is
+located.  (I.e. this matches the expectation of C programmers.)
+
+Nesting of
+.I include
+statements is limited to a maximum of five levels.
+
 .SS LABEL STATEMENT
 .RS
 label in3 "+5V"

-- 
Mark M. Hoffman
mhoffman at lightlink.com


