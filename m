From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: 11-bit temperature problem
Message-Id: <20030814095323.60a552a6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030812000544.71047b61.khali@linux-fr.org>
In-Reply-To: <20030812000544.71047b61.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> * Jean Delvare <khali@linux-fr.org> [2003-08-14 00:14:45 +0200]:
> > * Mark M. Hoffman <mhoffman@lightlink.com>:
> > > 
> > > 10kHz smbus speed (conservative - spec'ed minimum according to
> > > datasheet) 40 bits per read (smbus write + smbus read incl.
> > > start/stop/ack bits) 22 registers to read (conservative - probably
> > > need only 15)
> 
> <snip>
> 
> > Two remarks. First, when you say "10kHz smbus speed, conservative",
> > I don't quite agree. To me, the conservative value is the highest
> > possible bus speed. This is where the one-shot conversion will
> > increase the overall time more (relatively). So, let's consider a
> > bus speed of 100kHz. How do you come to 40 bits? I count 29 (3 9-bit
> > bytes, plus 1
> 
> According to the datasheet timing diagrams on p 11...
> 
> (a) is i2c_smbus_write_byte_data() ~29 bits
> (b) is i2c_smbus_write_byte() ~20 bits
> (c) is i2c_smbus_read_byte() ~20 bits
> 
> I.e. i2c_smbus_read_byte_data() is not supported by this chip, so you
> need to use (b) + (c) to read a register.

Interesting, it seems you read the datasheet more carefully than I did
;) However, this part is exactly the same as for the LM83, and it
happens that in my lm83 driver, I *do* use i2c_smbus_read_byte_data(),
and it works. Since the LM90 is more recent than the LM83, I think it'll
be the same here (and actuall some LM90 users have been using the lm83
driver so far, and it was working). So it seems that the read byte data
mode is indeed supported by both chips. Or should I really change the
code to match the datasheet? (I don't know if the chip could handle that
mode but "not like it", for example.)

Anyway, thanks for pointing this out, I'll try to be more careful next
time.

> And I say ~40 instead of exactly 40 because there are limits to how
> close one can stack transactions (the bus driver/hw should take care
> of that).

Yes, I had understood that.

> > BTW is there a way we can know at what frequency the bus really
> > works?
> 
> The simplest correct answer is "no".
> 
> A more useful answer is "look at the bus datasheet".
> 
> But this is actually not a simple topic at all.  Even if you know the
> nominal bus speed, the protocol allows for the master or slaves to
> "stretch" any single bit-time to arbitrary lengths (in theory).  Of
> course in practice a master or slave will not wait forever; the amount
> of time they *will* wait is published.  E.g. 10kHz minimum for LM90
> implies that the master better not stretch a bit-time longer than
> 100uS.
> 
> If I managed to get you interested about what's "on the wire", look
> here: http://www.semiconductors.philips.com/buses/i2c/

Oh, I got that one printed already. Now I just need some time to
actually read it, but I know I will spend much time in trains next week,
so I should find some time there (when my laptop batteries die and I
can't keep programming, for example).

Thanks again!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
