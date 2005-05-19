From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: ADM1032 eval board
Message-Id: <20031102125056.2b7995c4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031030222034.72a00bd5.khali@linux-fr.org>
In-Reply-To: <20031030222034.72a00bd5.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


(Answering to myself.)

> I have somewhat good results, since:
> 
> 1* The power led lights up.
> 
> 2* The bit_test option of our i2c-algo-bit module (which I had to
> tweak a bit because the eval board doesn't let me read SCL back)
> suggests that SDA can be set and read back correctly.
> 
> 3* When running some commands on the bus (using i2cdetect for example)
> I detect electrical activity on both SDA and SCL. I'm using a low-cost
> multimeter, unfortunatelly I don't have anything better to watch the
> signals. I'd love a good oscilloscope these days :/
> 
> Now the problem is: i2cdetect doesn't detect anything. Not a single
> chip. Running i2cdump on address 0x4c (where I know the adm1032 has to
> be) fails reporting a single valid byte too. It looks like the adm1032
> doesn't want to answer, and I can't understand why.
> (...)
> Sean, is there something I'm supposed to do that does not appear on
> the schematic? Some pin of the parallel port that must be forced to
> either high or low for proper operation? I'm kind of lost now. I was
> expecting everything to work OK once I'd have worked the bit-bashing
> driver out, and am diappointed that it still doesn't work. Your
> Windows tool being working on the same machine, I know that there is
> no hardware incompatibility, so that must be something I am doing
> wrong somewhere. I've even been trying various speeds, but it did not
> help.

OK, I finally got it working! :)

After trying various modules and parameters, and even trying to link the
eval board to one of my computer motherboard's SMBus, with absolutely no
results for 3 days, I was about to give up. Then I read the schematic
once again, to make sure I had not missed something, although after
reading it ten times I was pretty sure I wouldn't discover anything new
this time. And finally I understood what I had made wrong.

You'll probably find it ridiculous since it was so obvious. It was all
plain written on the schematic. All inputs and outputs are inversed. I
had to write *1* to SCL or SDA to pull it low, *not* 0, and all the rest
works the same way. I can't blame anyone but me there. Would I have been
able to read the nice schematic correctly at first, I would have it all
working within an hour or so... I'm not a hardware guy, so it did not
even imagine that I would have to write a 0 to set the line high, and so
on.

So, sorry Sean for annoying you with my silly questions ;)

I'll now move on to the ADM1032 driver itself, and that should be rather
fast since we already support a very similar and mostly compatible chip
(LM90). I'll read the datasheet once again to make sure there's no
hidden trap, and then will let you know when I got it working :)

Thanks again.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
