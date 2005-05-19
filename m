From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: problems in one or more man pages you maintain
Message-Id: <20040712185807.5ae81670.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407121514.i6CFEqXm017215@snark.thyrsus.com>
In-Reply-To: <200407121514.i6CFEqXm017215@snark.thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Eric,

> See http://catb.org/~esr/doclifter/problems.html for details on how
> and why these patches were generated.  Feel free to email me with any
> questions.

FYI: Link to http://catb.org/~esr/doclifter/prepatch/isadump.8.patch is broken.

> Problems with isadump.8:
> 
> 1. Parenthesized comments in command synopsis.  This is impossible
> to translate to DocBook.
> 
> --- isadump.8-orig	2004-07-10 06:49:29.502190656 -0400
> +++ isadump.8	2004-07-10 06:50:39.737513264 -0400
> @@ -7,11 +7,9 @@
>  .I addrreg
>  .I datareg
>  .RI [ "bank " [ bankreg ]]
> -(for I\u2\dC-like access)
>  .br
>  .B isadump
>  .BI "-f " address
> -(for flat address space)
>  
>  .SH DESCRIPTION
>  isadump is a small helper program to examine registers visible
>  through the ISA

This change, as is, is certainly not acceptable as it discards an
information I consider important for the reader.

BTW, why doesn't DocBook accept parenthesized comments in synopsis?
DocBook is mostly XML if I'm not mistaking, I don't see how parentheses
cause any problem. What are you going to do for C manual pages, which
all have parentheses in their synopsis?

Anyway, if there is a solid reason why DocBook cannot cope with that,
and if it is not going to be improved, I cannot see why manual pages
would need to be changed for that. The syntax used in this manual page
doesn't break any standard as far as I know. If DocBook cannot accept
it, then your "doclifter" converter simply has to learn how to handle
that case. Either drop the parenthesized comment, or (better) find an
alternate syntax to replace the parentheses. Doesn't sound that complex,
does it?

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
