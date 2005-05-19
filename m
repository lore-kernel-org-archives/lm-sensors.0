From: tristan-777@t-online.de (Dimitri Puzin)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Intel D845GEBV2 with lm85: config is locked
Message-Id: <000501c38935$99f04c00$fe0aa8c0@freeman>
List-Id: <lm-sensors.vger.kernel.org>
References: <000501c38918$5f227520$fe0aa8c0@freeman>
In-Reply-To: <000501c38918$5f227520$fe0aa8c0@freeman>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello, thanks much for your reply.
I've read through the data sheet for the lm85, also found the settings about
locking at 0x40h. That's sad...I'll try to ask at Intel if they know of a
hack to
disable that feature in the BIOS and use custom settings. Maybe experiment
more with the BIOS settings. If I  get an answer I'd also
(try) to volunteer and extend the code to support that. About the addr 0x08:
there is nothing useful there. The output is consists of a large array of
"XX".

Regards,
-Dimitri

PS: I believe there is a typo in the doc for the lm85. In the original
datasheet
they suggest to use LM85-B for new designs, not the -C rev (on page 2
bottom I have the datasheet from
http://www.national.com/ds/LM/LM85.pdf)

----- Original Message ----- 
From: "Jean Delvare" <khali@linux-fr.org>
To: "Dimitri Puzin" <tristan-777@t-online.de>
Cc: <sensors@stimpy.netroedge.com>
Sent: Thursday, October 02, 2003 10:49 PM
Subject: Re: Intel D845GEBV2 with lm85: config is locked


>
> > I've got an Intel mainboard D845GEBV2 as replacement for my Asus
> > P4B-266SE(that ASB100 mess). I've mounted it, gone through the configs
> > and sensors-detect said I should use the lm85 driver. With lm85 it
> > seem to work well, except I cannot change anything in the proc
> > interface. The values reported seem correct but all changes (e.g.
> > echoing values to the pwm# registers) are ignored...
>
> This is a feature of the LM85. I remember I read that some times ago.
> (reading again) Yes, here it is. Bit 1 of register 0x40 is lock. Once
> set to 1, all limits are read only, and that bit itself becomes read
> only. And yes, that bit it set to 1 on your chip. Blame your motherboard
> manifacturer for that (I guess).
>
> > Intel claims there is an SMSC LPC47M172 on board.
>
> We don't have support for this one yet, but support some members of the
> family in the smsc47m1 driver. Maybe you could give it a try (using CVS
> version is recommended). They are ISA chips so they don't appear on the
> I2C bus.
>
> > Output of syslog
> > -----------------------
> > Oct  1 20:34:24 elexis kernel: lm85(0): Client (0,0x2e) config is
> > locked.
>
> See, that's what I said.
>
> > elexis:~# i2cdetect 0
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX
> > 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX 2e XX
> > 30: 30 XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
> > 50: 50 XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
> > 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>
> You did not dump address 0x08. Maybe there's something interesting
> there? (Although I admit we don't know any chip living there yet).
>
> > I had to do a cold reset after the use of i2cdetect/dump.
>
> Yes, that happends, especially after dumping address 0x69 which is a
> clock chip you should avoid playing with.
>
> > Do you have an idea how to solve that problem?
>
> I am afraid you can't do anything :(
>
> > PS: sorry if I sent it multiple - my posts didn't appear on the list.
>
> Got only one, so it's OK :)
>
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
>
>

