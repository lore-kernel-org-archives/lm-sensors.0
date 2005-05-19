From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: 11-bit temperature problem
Message-Id: <20030814001445.79be6f49.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030812000544.71047b61.khali@linux-fr.org>
In-Reply-To: <20030812000544.71047b61.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > "When retrieving all 10 bits from a previous remote diode
> > temperature measurement, the master must insure that all 10 bits are
> > from the same temperature conversion. This may be achieved by using
> > one-shot mode or by setting the conversion rate and monitoring the
> > busy bit so that no conversion occurs in between reading the MSB and
> > LSB of the last temperature conversion."
> > 
> > To me, both proposed solution are bad. In the first case, you'll
> > have to wait for the full conversion each time you want to read the
> > value. The I2C bus is slow enough, the hell if we want to wait even
> > more each time
> 
> Why not fire off a one-shot conversion and wait for it to finish?
> 
> 10kHz smbus speed (conservative - spec'ed minimum according to
> datasheet) 40 bits per read (smbus write + smbus read incl.
> start/stop/ack bits) 22 registers to read (conservative - probably
> need only 15)
> 
> So 31.25ms for the conversion + 88ms for the update => ~120ms. 
> There's other overhead too but it can't be helped.  This is pushing
> the limits of what people can notice, worst case.
> 
> But if you really must optimize it...
> 
> update() {
> 	start_conversion();
> 	read_non_volatile_regs();
> 	while (still_converting)
> 		i2c_delay(1);
> 	read_volatile_regs();
> }

That's interesting. I love it when discussing about things like that on
the list make me realize I just missed some clever ideas. This proves
how great teamwork is, I believe.

Two remarks. First, when you say "10kHz smbus speed, conservative", I
don't quite agree. To me, the conservative value is the highest possible
bus speed. This is where the one-shot conversion will increase the
overall time more (relatively). So, let's consider a bus speed of
100kHz. How do you come to 40 bits? I count 29 (3 9-bit bytes, plus 1
start and 1 stop). There are 17 registers we want to update (3 volatile,
14 non-volatile). So the update time would be 4.93ms (4.06 non-volatile,
0.87 volatile). Now we can consider that 31.25 extra ms for the
conversion is something significant, isn't it?

Of course you can object my reasonment is pointless, and I agree ;) We
don't really care what takes time as long as the overall operation fits
in a reasonable amount of time. But I don't like the idea much, while I
would have if the conversion time was less than the non-volatile
registers update.

BTW is there a way we can know at what frequency the bus really works?

Anyway, my main objection against one-shot mode is the hardware
protection. The LM90 is supposed to have its ALERT output wired to the
SMBus master, and its T_CRIT_A output wired to shutdown control. It is
obviously meant for hardware temperature regulation and overtemperature
shutdown. If we configure the LM90 in one-shot mode, it means that the
status registers will only be updated when someone asks the driver to
update. What if a user loads the driver and never use it? (I do that all
the time.) Then the hardware protections will be disabled. I don't want
to be held responsible for that!

> > The solution I have come to is:
> > 
> > Read first byte, read second byte, read first byte again. If the new
> > first byte matches the old one, it's ok, we have our reading (most
> > cases). If not, read the second byte once again. If the conversion
> > rate is low enough (and I'll make sure it is) the second try should
> > not fail. The good point there is that we don't have to wait for any
> > event nor monitor any flag. The bad point is a 50 to 100% overhead.
> > Still I believe it's overall better than the other possibilities (if
> > you can call them that way).

Any objection to that? I expect this to make me read 18 (or 19)
registers instead of 17, this ain't much of an overhead it seems.

> Useless precision is a pet peeve of mine, too.  I was once asked to
> extend the std C lib struct tm to include a field for microseconds -
> as if there was some calculation that cared about months and uS at
> the same time... equivalent to 12 decimals of precision?!

Yeah, usually it just means people don't know what they are doing (or
that commercial arguments were put on the top of technical ones, which
is the same as in the first case).

Thanks a lot for helping me think about all the possible solutions :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
