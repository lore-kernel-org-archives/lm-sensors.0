From: esr@thyrsus.com (esr@thyrsus.com)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: problems in one or more man pages you maintain
Message-Id: <200407121514.i6CFEqXm017215@snark.thyrsus.com>
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

Note: This patch does not change the mod date of the manual page.  You
may wish to do that by hand.

Problems with isadump.8:

1. Parenthesized comments in command synopsis.  This is impossible
to translate to DocBook.

--- isadump.8-orig	2004-07-10 06:49:29.502190656 -0400
+++ isadump.8	2004-07-10 06:50:39.737513264 -0400
@@ -7,11 +7,9 @@
 .I addrreg
 .I datareg
 .RI [ "bank " [ bankreg ]]
-(for I\u2\dC-like access)
 .br
 .B isadump
 .BI "-f " address
-(for flat address space)
 
 .SH DESCRIPTION
 isadump is a small helper program to examine registers visible through the ISA

--
                             Eric S. Raymond
