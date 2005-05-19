From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: 11-bit temperature problem
Message-Id: <20030814162051.GA1295@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030812000544.71047b61.khali@linux-fr.org>
In-Reply-To: <20030812000544.71047b61.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2003-08-14 09:53:23 +0200]:
> > * Jean Delvare <khali@linux-fr.org> [2003-08-14 00:14:45 +0200]:
> > > Two remarks. First, when you say "10kHz smbus speed, conservative",
> > > I don't quite agree. To me, the conservative value is the highest
> > > possible bus speed. This is where the one-shot conversion will
> > > increase the overall time more (relatively). So, let's consider a
> > > bus speed of 100kHz. How do you come to 40 bits? I count 29 (3 9-bit
> > > bytes, plus 1
> > 
> > According to the datasheet timing diagrams on p 11...
> > 
> > (a) is i2c_smbus_write_byte_data() ~29 bits
> > (b) is i2c_smbus_write_byte() ~20 bits
> > (c) is i2c_smbus_read_byte() ~20 bits
> > 
> > I.e. i2c_smbus_read_byte_data() is not supported by this chip, so you
> > need to use (b) + (c) to read a register.
> 
> Interesting, it seems you read the datasheet more carefully than I did
> ;) However, this part is exactly the same as for the LM83, and it
> happens that in my lm83 driver, I *do* use i2c_smbus_read_byte_data(),
> and it works. Since the LM90 is more recent than the LM83, I think it'll
> be the same here (and actuall some LM90 users have been using the lm83
> driver so far, and it was working). So it seems that the read byte data
> mode is indeed supported by both chips. Or should I really change the
> code to match the datasheet? (I don't know if the chip could handle that
> mode but "not like it", for example.)

Gah!  I'm sorry: (b) + (c) *is* i2c_smbus_read_byte_data() minus a stop bit.
From our smbus protocol doc...

> SMBus Read Byte Data
> ==========
> 
> This reads a single byte from a device, from a designated register.
> The register is specified through the Comm byte.
> 
> S Addr Wr [A] Comm [A] S Addr Rd [A] [Data] NA P

So, that makes 39 bits not 29.

> Anyway, thanks for pointing this out, I'll try to be more careful next
> time.

Heh, me too.

-- 
Mark "goes to penalty box and feels shame" Hoffman
mhoffman@lightlink.com
