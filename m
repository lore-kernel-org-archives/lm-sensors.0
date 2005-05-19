From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: failed again; vetctor 300
Message-Id: <20030806133127.1ba70714.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030805222340.3799d819.zdavatz@ywesee.com>
In-Reply-To: <20030805222340.3799d819.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> depmod: *** Unresolved symbols in
> /lib/modules/2.4.21-ben2/kernel/drivers/sound/dmasound/dmasound_pmac.o
> 
> My feeling tells me you must be right.

Yes, I am. I should really have though of all that before, since I am
the one who wrote the kernel i2c patch that fixes that. Stupid me.

> > Am I wrong on any point? If I'm not, I fully understand what
> > happened. I have been wrong pretending this wasn't our fault,
> > because it actually is(well, sort of).
> > 
> > (It does *not* explain why sensors-detect locks on the ISA bus
> > scanning,
> I was not the ISA Bus it was the check afterwards, I think it did not
> check for that in the last lm-sensors version I thouhgt it started an
> I... (bad memory chip in my brain - sorry).

Must be Super I/O chips? This is something new in 2.8.0 actually, and
not well tested. Maybe this will require some tweeking, thanks for
reporting.

> > but it explains the trouble you have been encountering after
> > installing lm_sensors, or, more precisely, i2c-2.8.0).
> 
> Ok, how do I get my sound back? I could just install my latest
> kernel-image I think that would help.

Yes it should. Basically, your sound module depends on i2c-core and
maybe some other i2c modules, which I told you to delete in order to
prevent the system crash. In a way, it worked, your system doesn't crash
anymode, but still the sound module cannot load. Restoring your kernel
package should work. Note however that it is not the kernel itself, but
the kernel modules, that have to be reinstalled. I don't know how this
is organized in Debian.

As for installing lm_sensors on your system, here are my conclusion.

Solution #1:
You stick to 2.7.0 until kernel 2.4.23 is released. This kernel version
should include the i2c update and solve the problem you had.

Solution #2:
You disable your sound module ("alias dmasound_pmac off" in
/etc/modules.conf) and install 2.8.0. This should work, but you won't
have sound anymore, of course.

Solution #3:
You use the i2c kernel patch for 2.8.0. This require recompiling your
own kernel. I don't know it this is something you are used to do, nor if
you simply want to. I guess this may prevent you from using the debian
packages (unless these are sources packages tou have to compile anyway).

So I think solution #1 is the safe and easy way.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
