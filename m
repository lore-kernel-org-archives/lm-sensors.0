From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: Ticket 1700: lm99 on nvidia board doesn't work
Message-Id: <20040621215516.4e48c270.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1087846585.2369.85.camel@moeff>
In-Reply-To: <1087846585.2369.85.camel@moeff>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > First of all, know that neither rivatv 0.8.5 nor CVS will work
> > properly with Linux 2.6.7 as far as hardware monitoring is
> > concerned. The author missed a define names change, and as a
> > consequence, hardware monitoring chips will not recognize the nVidia
> > busses as usable. I will send a patch to the author.
> 
> I applied your patch to rivatv and recompiled it, but it still doesn't
> work.

No surprise here, since your main problem happens even before this one
would.

> > Second, not only no LM99 chip is detected by sensors-detect, but the
> > script doesn?t even see a chip at a possible address (0x4C or 0x4D).
> > This can mean either of two things:
> > 1* You simply don?t have a LM99 on that board. I guess that there
> > are several different brands and models of GeForce FX cards out
> > there, not all may have hardware monitoring features. Are you sure
> > yours do?
> 
> http://www.hothardware.com/viewarticle.cfm?articleidB1&catid=2
> This page says "Advanced thermal management and thermal monitoring" so
> I suppose it has one.

This doesn't mean that this is an LM99. You have a chip at address 0x38
on bus 2 and two at addresses 0x20 and 0x21 on bus 0. These are not
typical addresses for hardware monitoring chips (especially not 0x38)
but who knows?

You may want to dump the chips contents for us to have a look, using
i2cdump.

-- 
Jean Delvare
http://khali.linux-fr.org/
