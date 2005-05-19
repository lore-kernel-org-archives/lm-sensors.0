From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c address probing and AT24RF08 corruption
Message-Id: <20040416190455.282228d4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082123259.407fe3fb3d41c@imp.gcu.info>
In-Reply-To: <1082123259.407fe3fb3d41c@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > This is exactly a SMBus "quick command" with data bit 1, if I
> > understood it correctly. This isn't what we do (we do "quick
> > command" with data bit 0), but that's my second choice if it turns
> > out that "receive byte" isn't possible as a probing command.
> 
> I'd prefeare a reading "quick command" over a "receive byte" as we
> don't actually want read a byte on probing ...

There is no such thing as a "reading quick command", that's the problem.
In the SMBus spec, the "quick command" is described as sending a single
but to the chip (so the R/W but loses its R/W status on this one). So
you write either 0 or 1, but you write it.

I think it's absolutely silly from the SMBus folks to have done that,
since it's against the spirit of I2C (I would even say it makes SMBus
incompatible with I2C), and dangerous, and useless, but that's how it
is.

That said, after reading this:
http://archives.andrew.net.au/lm-sensors/msg01143.html
I understand that this is not the "quick command" itself corrupting the
24RF08 but the fact that its state machine is broken and it really sees
the "quick command 0" as the first byte of a write.

I wish I had read that before sending my proposal to everyone, but hey
that's how life goes.

Anyway, what you say here, and the facts on the 24RF08, confirm my
impression that a quick write 1 would be less dangerous than a quick
write 0. OTOH I am told that the former is likely to make some chips
lock the bus. So we're not only fighting against the 24RF08's broken
state machine, but also with some other chips (don't even have the
complete list). Damn, I hate it when broken hardware forces us to write
broken software to workaround :(

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
