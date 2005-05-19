From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Donation.
Message-Id: <20031028222649.71446e13.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <F7CB408531C5264680C9E37DE4FE71A4088FDF@limkexm2.ad.analog.com>
In-Reply-To: <F7CB408531C5264680C9E37DE4FE71A4088FDF@limkexm2.ad.analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Apologies for the delay in sending you a board. I have just got the
> wheels in motion so an evalboard should be sent out to you sometime
> next week.

Hi Sean,

I just received the board. I'd never have imagined it would be that fast
to receive it. I guess that the "EXTREMELY URGENT" on the package helps
;) although it wasn't that urgent after all - I'm sure I'd have survived
one more day.

I could test the board under Windows XP - not as easily as it would
seem. I had to manually enable IRQ on the parallel port, or the
evaluation software wouldn't be able to detect the chip. For some
reason, Windows XP had interrupts disabled by default on the parallel
port so it wasn't working. After enabling the IRQ it's all OK. I played
around a bit with the evaluation software, it's so fun seeing
temperatures raising when I put my finger on the chip and transistor
respectively.

I'll now be moving back to Linux and try to get the board working there.
I don't know exactly how to do that. I know we have some modules for
talking to i2c devices other the parallel port, but I couldn't get them
to work. One of them (i2c-pport.o) doesn't present any device on the
bus, the other one (i2c-philips-par) show a chip at each address, full
of zeroes each time - so this must be wrong too. I'll be investigating
that now. However, I'm much more knowledged about i2c client chips than
about i2c bus masters, so I don't know exactly where to start from.

Has anyone on the list experience with ADM eval boards?

Thanks a lot Sean! I'll tell you as soon as I can get the board working
under Linux.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
