From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 04 Aug 2006 07:39:14 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <20060804093914.e531330d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark, Anthony,

> Version 2.5.4 of flex is current[1] (same as mine), version 1.875c of bison
> is ancient (I have 2.0).  OTOH, I'm pretty sure that's irrelevant to this
> problem because the "flex scanner jammed" message happens prior to the
> parser (from bison) receiving the token from flex.
> 
> I.e. we both have the same version of flex; AFAICT that's all that matters.
> 
> As for the %option nodefault... I think there is some bad interaction 
> between that one and %option yylineno.  Some time ago I played with
> getting rid of %option yylineno (and keeping track of line numbers with
> explicit rules) as a performance optimization.  As soon as I turned off
> the yylineno option, flex started complaining about the nodefault option
> being specified even though the default rule was still in use.  But
> those two options should be unrelated... I haven't figured it out yet.
> 
> I'm not sure how helpful any of this is for the problem at hand... sorry.

Well, thanks for the information anyway. Good thing to know that bison
isn't involved. I am really not familiar with the configuration file
parsing part of libsensors, I've been avoiding messing up with it as
much as possible so far.

I'm out of (non-stupid) ideas on this one. It's rather hard to debug a
problem I am not able to reproduce.

Anthony, are you running a non-standard locale, maybe?

You may also try intermediate versions of lm_sensors, if you had 2.8.7
working before and 2.10.0 doesn't work anymore, it suggests that
something changed in-between (although you could try rebuilding 2.8.7
rebuilding 2.8.7 to start with, and check if it really still works -
maybe your build environment changed, rather than the code?)

-- 
Jean Delvare

