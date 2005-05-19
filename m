From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: Strange values on ASRock K7S8X mainboard with W83697 chip
Message-Id: <Pine.LNX.4.58.0407232129100.30300@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407221213.00965.lourens@rainbowdesert.net>
In-Reply-To: <200407221213.00965.lourens@rainbowdesert.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I've still got version P2.20, but the ASRock changelog doesn't say
> anything about sensors.

I tried the fist version and last version. They are the same. (in this
part of code)

> How did you get that BIOS image? Is there a way to extract it? I'd
> love to have a look. I tried downloading the images from the ASRock
> website, but they don't even have those strings in them. Or am I
> missing something?

It is compressed. Just imagine that image like a filesystem.
There are some tools available.

See my Bios Hacking guide, made for this purpose :)

http://assembler.cz/biohack.html

> Hmm, multiply by 160. The LSB of the ADC output is 16mV. So we're
> working in tenths of millivolts apparently.

Nice.

>
> > The BX value is somewhere hidden or even not included so I cant
> > tell anything about the formula.
>
> Well, I worked it out from that disassembly, and we can say
> something about the formula. If I didn't make any mistakes, it
> seems to follow the formula in the datasheet, with the mysterious
> BX being the beta value. The 24h (36) in there is the 3.6V
> reference voltage. This means that my original estimate is probably
> somewhere near correct, but it leaves the problem of the resolution
> being way too small.
>
> Theory: the hardware guys at ASRock miswired in5 and in6. The BIOS
> software guys programmed the BIOS according to the datasheet. When
> testing, they noticed the problem, and disabled the negative
> voltage readout. It is a low-budget product after all, so fixing
> the hardware might simply have been too expensive. And negative
> voltages are hardly used in todays PCs anyway.

very nice catch maybe very close to reality.

> I've emailed ASRock, whose first reaction was to tell me to try the
> program at http://mbm.livewiredev.com. I took a second try at
> explaining them that I'm running Linux, and that I would like to
> know the formulas. I haven't had any response so far, but it's only
> been half a day. We'll see what happens.
>

Heh looking forward.

If you want to talk about this just go to IRC on irc.freenode.net
#linux-sensors

Regards

Rudolf
