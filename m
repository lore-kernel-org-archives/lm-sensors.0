From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Donation.
Message-Id: <20031030215229.12cc8149.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <F7CB408531C5264680C9E37DE4FE71A4088FDF@limkexm2.ad.analog.com>
In-Reply-To: <F7CB408531C5264680C9E37DE4FE71A4088FDF@limkexm2.ad.analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I'm a hardware guy, so I like to workaround problems that way. ;')  I 
> used to use my video card as a test platform since it had the I2C bus 
> available on a bank of jumpers (probably for an addition board).  
> Notice, too, that the AD kit I got came with both a parallel port and
> a DIMM dummy, which was very handy.

Not the case for this one, it's parallel only.

> Yeah, it should work w/ the parallel port.  You'll need to figure out 
> which pins on the parallel port is Data and which is Clock.
> Hopefully power isn't going to be hard to figure out (does it come
> with an AC adapter? Or does it pull it from the parallel port?).
> Then, you'll probably need to tweak the parallel port driver to match.
> Since it's a bit-banger based driver, it shouldn't be too hard.  All
> the info should be in the eval kit docs (especially the schematics).

Everything is actually in a PDF on the evaluation CD. Very nice
schematics. Power is taken from the parallel port (4 pins). I could
figure out what is on which pin. Unfortunatelly I am still not able to
see the ADM1032 on the bus. See my answer to Sean for details.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
