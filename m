From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <20031027215409.193400e5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > I'm now waiting for your new patch, fixing my previous remarks, and
> > I'll will commit it to our repository.
> > 
> > Keep up the good work :)
> 
> I'm sorry for the delay, but I was very busy at the company due to 
> perparations for SYSTEMS fair.
> 
> Attached you'll find the updated patch.

Great. Looks really good. I've taken out the sensors-detect part, since
I had already added support for the Hermes some weeks ago (amazing how
we came to the very same function, almost to the byte). I've also fixed
a few typos in the docs, reformatted things a bit to conform to the
project standards (if there is such a thing). I obviously should have
told you that part of the docs is generated from the code (insmod
parameters, /proc files list).

I couldn't test your driver (don't have the hardware) but I read it
quickly and I believe it's ready for integration. I've committed your
work to our CVS repository, and updated our webpage to reflect that.
Good job!

Still there are two things that I would like to hear you about:

1* In the docs, you say that fans have a programmable divider of 1, 2 or
4. I can't see how one could change that divider. Am I missing
something?

2* In the driver itself, the hexadecimal mask 0x9b in fscher_in() would
probably need some comment. The choice of that value isn't obvious.
Others masks are simple enough to be guessed or at least trusted at
first sight, but this one isn't IMHO.

Thanks again.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
