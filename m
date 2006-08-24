From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 24 Aug 2006 03:01:43 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <20060824030143.GA2653@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Anthony:

* Calabro, Anthony <anthony.calabro at lmco.com> [2006-08-23 13:46:24 -0400]:
> Attached is the ouput of sensors -s (2.10.0) with the ocmpile flag '-d'
> and also theline %nodefault  commented out of the file lib/conf-lex.l

Here is some of the output from your attachment...

> --(end of buffer or a NUL)
> --accepting rule at line 122 ("chip")
> --accepting default rule (" ")

It missed the rule at line 88, which refrences "[[:space:]]".  In flex, this
is called a character class expression.  It means any character for which the
standard C library function isspace(3) returns true.

> --accepting rule at line 189 (""")
> --accepting rule at line 257 ("w83782d-*")
> --accepting rule at line 205 (""")
> --accepting default rule (" ")

Missed rule 88 again.

> --accepting rule at line 189 (""")
> --accepting rule at line 257 ("w83627hf-*")
> --accepting rule at line 205 (""")
> --accepting rule at line 80 ("
> ")
> --accepting default rule ("
> ")
> --accepting rule at line 98 ("label")
> --accepting default rule (" ")

Missed rule 88 again.

> --accepting default rule ("i")
> --accepting default rule ("n")
> --accepting default rule ("0")

Here, it missed the rule at line 262 which references "[[:alnum:]]".  This
corresponds to the standard C library function isalnum(3).  Hmmm...

You said before that if you quote the identifiers, the scanner will accept
them.  That further points to the character class expressions being somehow
broken because the rules for *inside* the quotes do not use them.

I'm going to guess that you are having some bad interaction with the standard
C library.  I'm not sure how that's possible, especially if you can compile
and use lm-sensors 2.9.0 without problems.  Did you compile the two versions
on two different machines?  I think the character class expressions are
resolved during compile time / scanner generation, i.e. from *.l -> *.c.

I don't know what else to suggest.  This much is certain: given the output
you attached, something is getting miscompiled or corrupted when you build
2.10.0.  As unlikely as that may sound, nothing else makes sense.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


