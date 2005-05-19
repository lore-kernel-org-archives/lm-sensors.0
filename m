From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: I2C crash - ADM1021
Message-Id: <20031012175335.5eab460e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1063901946.2937.27.camel@localhost>
In-Reply-To: <1063901946.2937.27.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > I took a look, it used to detect an adm1021 clone for all three
> > addresses (0x18, 0x4c and 0x4e). After my first fix, 0x18 is left
> > apart(great), 0x4c is detected but the lm90 driver if prefered
> > (great too) and 0x4e is still detected (*not* great). I added one
> > extra check in sensors detect for the MAX1617 and the LM84 (and also
> > for the LM75), which should fix the problem. Could you check it out
> > and give it a try? Would be nice.
> 
> File is attached...

Great, no more MAX1617 claimed at 0x4e. Still sensors-detect claims to
have found a LM75 at this address, which should *not* happen after my
latest changes. Very strange... Could you provide the output of the
following command, it may help:
i2cdump 0 0x4e w
Notice the "w" for "word mode". This mode is used while detecting LM75,
maybe the unknown chip you have at 0x4e doesn't answer to this mode as
expected.

> > BTW, I'd be interested in a dump of devices 0x18 and 0x4e. You
> > already sent them once, but they obviously changed (the one at 0x4e
> > at least, or it couldn't be detected as a LM84 - and it is).
>
> File is attached.  I don't know why 4e changed either.

I suspect that this chip has only one readable register, so it doesn't
care about the address and always return the value of that register.
That said, I don't know why this value used to be 0x14 and is now 0x00,
but it's probably a bit vector and not a plain value (well, just
guessing.)

> and I got similar data from the MAX1617.  see file
> sensors-output-20031012.txt for the history.
> About the only difference I can see is that the lm90 driver returns a
> temp with a decimal number and the MAX1617 returns a whole number.

That's what was expected.

> ANYWAY, Jean.  Sorry to have taken up so much of your time --
> especially since it appears it was my error in the first place (not
> adding 0,0x4e in the original modules.conf file.
> 
> However, I learned alot from the experience and have become quite
> comfortable working with lmsensors.

Everyone took benefit I guess. You learned about lm_sensors, we improved
our detection routines, making our product slightly better. That's the
way we like it :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
