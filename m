From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: i2c/kernel i2c-algo-bit.c
Message-Id: <20031107214337.1459aaff.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031101170944.386fd941.khali@linux-fr.org>
In-Reply-To: <20031101170944.386fd941.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > 1* Fixed sclhi() for adapters that do not have getscl(). It looks
> > like there was a udelay call missing in this case.
> 
> If you can't read SCL, you can't have a true I2C master.  SCL is
> wired-AND which means that any device on the bus can hold it low
> until that device is ready.

You're of course right. Still some masters can't read SCL back. This is
the case for the ADM1032 evaluation I received from Analog Devices. The
i2c-algo-bit module was supposed to handle that case already, so it must
not be that uncommon.

> In theory, any I2C bus master which is implemented by bit-bashing
> yet which cannot read SCL is fundamentally broken.  In practice,
> such a system will work fine if the slaves never hold the clock low.
> For bus arbitration (more than one master), the ability to read SCL
> is definitely required.

I guess that evalution boards must be matching that criteria. Mine must
be, at least, since it's working OK.

> > 1* I don't understand how the whole thing works. Each of sdalo(),
> > sdahi(), scllo() and sclhi() are waiting adap->udelay before
> > returning. How in this condition can the driver change both SCL and
> > SDA values in a row?
> 
> Do you mean to transition SCL and SDA at the same time?  It cannot,
> nor does it have to.  Take another look at the I2C protocol spec,
> especially figure 4 on page 9.

Yes, I know that. I've read the I2C spec, mind you ;) OK, I stopped
before the end, I admit. But I've at least understood that SDA changes
on SCL low, and "sampled" (if that make sense for a one-bit value) on
SCL high.

What confuses me is that comment in i2c-algo-bit.h:

  int udelay;  /* half-clock-cycle time in microsecs */
               /* i.e. clock is (500 / udelay) KHz */

Since each of sdalo(), sdahi(), scllo() and sclhi() is waiting udelay
before returning, the clock-cycle would more likely be four times
udelay, not two. Or am I missing something? Sending one bit on the bus
being setting SCL low, setting SDA to the wanted value, setting SCL
high, waiting for SDA to be sampled. Four times udelay, no less. Please
tell me if I'm wrong somehow.


> > 2* It looks like i2c-algo-bit assumes that both SDA and SCL are high
> > by the time it is called. Why that? Looks like not all drivers will
> > do so.
> 
> Because that is the bus idle condition?  If the hardware has pullups
> on SCL and SDA then the driver doesn't need to do anything to cause
> bus idle.  OTOH if SCL/SDA are floating, then the driver might have
> to manually establish bus idle first.  Again, I haven't looked at the
> source... but it makes sense if that's how it's implemented.  The
> algorithm simply expects an idle bus.  The driver does whatever it
> must do (possibly nothing) to create that condition.

That makes sense - providing all bus drivers play the game. The
parallel-port bus driver, for example, has to set the lines high
manually. The pins have to be set or not, they can't be left floating.

> > Especially, I tried my changes using i2c-matroxfb and it looks like
> > this driver doesn't set SDA not SCL before registering with
> > i2c-algo-bit, causing bit_test to sometimes fail with the message
> > "seems to be busy". I wonder if it wouldn't be easier (and safer)
> > not to assume anything about SDA and SCL in
> > i2c-algo-bit.c:test_bus() (that is, remove that"may be busy" test).
> 
> In this case, do you remove and reload the modules, or are you forced
> to reboot the machine?  The bus really might just be stuck.  The I2C
> bus is especially vulnerable to SCL stuck low because start, idle, and
> stop conditions are all impossible in that case; and the
> wired-AND-ness of SCL means it only takes one confused slave to kill
> the bus.

Reloading the i2c-matroxfb module didn't help, but reloading
i2c-algo-bit without the bit_test parameter worked without a hitch.
That's what made me think the test wasn't good. Now I understand that
i2c-algo-bit doesn't want to trouble the bus if someone else is talking
(multi-master case for example), but in my case it looks like
something's not working as intended. I don't see what bad could happen
setting the lines high at the beginning of the test. If someone else is
holding the line low at the same time, if my understanding of the I2C
bus is correct, that other device won't even notice it, since setting
low always wins over setting high. This is why I believe we could set
the lines high in i2c-algo-bit rather than in drivers (or at least set
the lines high before trying to test wether the lines are stuck or not).

Of course, the other possibility is to fix i2c-matroxfb, if it is
actually broken.

Thanks for your advice :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
