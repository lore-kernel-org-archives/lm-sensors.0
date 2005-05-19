From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: A7V8X-X and lm sensors
Message-Id: <1063980027.3f6b0bfb5b4f9@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030918153623.GA3679@pvv.org>
In-Reply-To: <20030918153623.GA3679@pvv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Ah good, because I can fit my data with an exp function (have some
> more
> measurments now).
> 
>   13.71*(^(0.029116*@))
> 
> and back should be
> 
>   ((`@)-(`(13.71)))/0.029116

I suspect that (`(@/13.71))/0.029116 will be faster (untested).

> Oh? Something is written on the chip? Not dangerous I hope?

Same as when you write bytes to your hard disk drive. Not dangerous as
long as what you do is really what you think you do. Monitoring chipsets
are meant to be configured that way, and most of the time it works OK.
Problems arise if you misdetected a chipset and then try writing a
value, because the chipset will interpret the write in a different
manner. More important problems come with chipsets that get corrupted
when you write to them in a way they don't like, but this is not that
frequent (or we would have stopped the project times ago).

So, to make it short, writing the limits to the chipset is OK, that's
the way they are designed to work.

> The formula above should fit with what the other person reported
> about at 40C. However it doesn't fit with his 8C observation when
> the BIOS reported 30C. Perhaps you could supply me with his e-mail
> address and I could ask him how his setup is and what temperatures
> he is measuring if he runs the CPU to different temperatures and
> then go fast to BIOS to read what it says there. Would also be
> nice to know what BIOS version he is using as there was a
> temperature tuning in on of the later BIOSes that I have flashed.
> I guess the reason why I have higher temperatures is that I use a
> controlled fan which will run faster as the temperature get higher
> whereas he might have a fan that is doing a fixed speed.

The (very short) relevant threads are here:
http://archives.andrew.net.au/lm-sensors/msg02813.html
http://archives.andrew.net.au/lm-sensors/msg02850.html
You'll find Gary's address in the first post.

Please CC: the list if your discussion is of public interest (and I
believe it will be).

> Another quick question. The BIOS reports VCORE at 1.63 while
> lm-sensors report 1.69. Should I leave it or should I adjust this
> value too?

Strange, never seen that before. You may tweak in0 if you want to.
That's not very important though, as long as it's near enough of the
nominal value. Maybe you could ask Gary about that too.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
