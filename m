From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: RFC PATCH remove DIV_TO_REG in gl518sm.c
Message-Id: <506t31hir10lhru31429i33pv1fo0qfmrn@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <st1s31h4ugdd8gq5d6p22mjhson8ahnf9t@4ax.com>
In-Reply-To: <st1s31h4ugdd8gq5d6p22mjhson8ahnf9t@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 21 Mar 2005 10:10:24 +0100 (CET), "Jean Delvare" <khali@linux-fr.org> wrote:

>
>Hi Grant,
>
>The macro *is* in fact used, although the (ab)use of macros all over the
>place make it hard to see it the first place (grep can't help here).

Oops.  Sorry.
>
>Look at these two lines:
>
>set_bits(DIV, fan_div1, fan_div[0], GL518_REG_MISC, 0xc0, 6);
>set_bits(DIV, fan_div2, fan_div[1], GL518_REG_MISC, 0x30, 4);
>
>Climb up the preprocessing chain, and you'll see that the DIV_TO_REG
>macro is actually needed. You could have noticed by simply
>compile-testing your patch. I invite you to always do.

Which I forgot to do 'cos no see match. :(  Are there tools for 
this, I started writing something to get at preprocessor output 
but it seems to want a perl script to parse output of gcc -E.

Hmm, so if I'm not sure of something, comment it out and ask 
the compiler, get a line number or string to look for?  

>You just hit one of the various reasons why I prefer inline functions to
>macros when both are possible. At least the compiler keeps track of
>function users and will let you know the unused ones.

Thanks for feedback.  Perhaps I'll just go shooting macros 
to make the code a bit more obvious?

Cheers,
Grant.
