From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: Fwd: ls_sensors, fscscy.o & watchdog
Message-Id: <20030603202032.3538b1ba.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030603170000.78ca4d75.khali@linux-fr.org>
In-Reply-To: <20030603170000.78ca4d75.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > According to the docs, this is read and write. I'll check the code
> > and update if required.
> 
> Yes, in viewpoint of code (and you :)) it's R/W. But the value you can
> read back is the same as you wrote there, not the current value of the
> counter(as I expected).

Well, it's a hardware design issue. And it's not necessarily bad,
although I believe both values could be interesting.

> > According to the docs again, it is supposed to be a "state"
> > register, so it's probably meant to be read from, not written to
> > (also the same docs say it's read and write).
> 
> It's always 0. Even if i write there something, i got 0 back.
> Maybe it's non-zero at the monment of reset :)))

Possible. This makes it pretty useless for the user.

> > Do you mean that the 6th bit has no effect, or that setting it to 1
> > disables the watchdog?
> 5th, not 6th

6th, I insist. Bit number 5 is the 6th bit. You usually start numbering
with 0, but the "zeroth bit" makes no sense to me (although the word do
exist). Or maybe is it just me? Let's call it the bit accounting for 32
:)

> Seems it disables the watchdog, at least when i set it, bit 4 has no
> effect. So only 'working' values for me were 16 and 144 (8+16), for
> other values it does nothing when the counter reach 0.
> (at least i see nothing happening)

Any idea what the 5 other bits are meant for?

> ^^^ this is the main point, to get it working :)
> actually i'm not interested (and i have no time) to do more
> experimenting with wdog, with the above 4-liner it works as expected
> form a watchdog.

You're definitely right. Do not fear, I won't forget this part :)

> i hope it helps somebody... before i started to experiment on a live
> production server i searched through the net for this info
> but found nothing :(

How does it feel to be a pioneer? ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
