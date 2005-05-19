From: esr@thyrsus.com (esr@thyrsus.com)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: problems in isadump.8, isaset.8
Message-Id: <200411210403.iAL43Ouv014612@snark.thyrsus.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is automatically generated email about problems in a man page for which
you appear to be responsible.  If you are not the right person or list, tell
me and I will attempt to correct my database.

See http://catb.org/~esr/doclifter/problems.html for details on how and
why these patches were generated.  Feel free to email me with any questions.
Note: These patches do not change the mod date of any manual page.  You
may wish to do that by hand.

Problems with isadump.8:

1. Parenthesized comments in command synopsis.  This is impossible
to translate to DocBook.

--- isadump.8-orig	2004-11-18 09:48:12.813213400 -0500
+++ isadump.8	2004-11-18 09:48:56.184619944 -0500
@@ -7,12 +7,10 @@
 .I addrreg
 .I datareg
 .RI [ "bank " [ bankreg ]]
-(for I\u2\dC-like access)
 .br
 .B isadump
 .BI "-f " address
 .RI [ "range " [ "bank " [ bankreg ]]]
-(for flat address space)
 
 .SH DESCRIPTION
 isadump is a small helper program to examine registers visible through the ISA
-----------------------------
Problems with isaset.8:

1. Parenthesized comments in command synopsis.  This is impossible
to translate to DocBook.

--- isaset.8-orig	2004-11-18 09:50:07.455785080 -0500
+++ isaset.8	2004-11-18 09:50:16.975337888 -0500
@@ -8,12 +8,10 @@
 .I datareg
 .I address
 .I value
-(for I\u2\dC-like access)
 .br
 .B isaset
 .BI "-f " address
 .I value
-(for flat address space)
 
 .SH DESCRIPTION
 isaset is a small helper program to set registers visible through the ISA
-----------------------------

--
                             Eric S. Raymond
