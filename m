From: arpi@thot.banki.hu (Arpi)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: Fwd: ls_sensors, fscscy.o & watchdog
Message-Id: <200306032116.h53LGjdh012847@mail.mplayerhq.hu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030603170000.78ca4d75.khali@linux-fr.org>
In-Reply-To: <20030603170000.78ca4d75.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> > > Do you mean that the 6th bit has no effect, or that setting it to 1
> > > disables the watchdog?
> > 5th, not 6th
> 
> 6th, I insist. Bit number 5 is the 6th bit. You usually start numbering
> with 0, but the "zeroth bit" makes no sense to me (although the word do
> exist). Or maybe is it just me? Let's call it the bit accounting for 32
> :)

lol

> > Seems it disables the watchdog, at least when i set it, bit 4 has no
> > effect. So only 'working' values for me were 16 and 144 (8+16), for
> > other values it does nothing when the counter reach 0.
> > (at least i see nothing happening)
> 
> Any idea what the 5 other bits are meant for?

nope
actually the question is what are the other 7 bits for...
the only we know is the one with value 16 (0x10), the rest is mistic...

> > i hope it helps somebody... before i started to experiment on a live
> > production server i searched through the net for this info
> > but found nothing :(
> 
> How does it feel to be a pioneer? ;)

Ask that ~700 users asking me 'what the hell is with our server now?
i can't read my emails!' while i'm keep resetting the system :)
(probably i should have answer them: i'm reverse engineering a watch-dog,
please be patient :))


A'rpi / Astral & ESP-team

--
Developer of MPlayer G2, the Movie Framework for all - http://www.MPlayerHQ.hu
