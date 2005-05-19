From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: i2c/kernel i2c-algo-bit.c
Message-Id: <20031106231151.GB16888@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031101170944.386fd941.khali@linux-fr.org>
In-Reply-To: <20031101170944.386fd941.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2003-11-01 17:09:44 +0100]:
> > Modified Files:
> > 	i2c-algo-bit.c 
> > Log Message:
> > (Khali) Fix sclhi() for adapters that do not have getscl().
> >         Enable bit_test for adapters that do not have getscl().
> >         Mostly rewrite test_bus(), cleaner and probably faster.
> 
> I'd like reviewers and testers on this, since I plan to submit a similar
> for Linux 2.6. There are two distinct changes:

I haven't read the source in i2c-algo-bit.c, *ever*.  I'm sorry, but for
the moment I cannot allow myself to read it.  I may yet need to maintain
a bit-bashing I2C driver for a client that I wrote some years ago which
predates my involvement in this project.  At least the I2C bus spec is
publicly available. [1]

> 1* Fixed sclhi() for adapters that do not have getscl(). It looks like
> there was a udelay call missing in this case.

If you can't read SCL, you can't have a true I2C master.  SCL is
wired-AND which means that any device on the bus can hold it low
until that device is ready.

In theory, any I2C bus master which is implemented by bit-bashing
yet which cannot read SCL is fundamentally broken.  In practice,
such a system will work fine if the slaves never hold the clock low.
For bus arbitration (more than one master), the ability to read SCL
is definitely required.

> 2* Rewrote test_bus() almost entirely, to allow adapters without
> getscl() to be tested. It's still interesting to test SDA in this case.
> 
> I have a pair of questions with regard to i2c-algo-bit:
> 
> 1* I don't understand how the whole thing works. Each of sdalo(),
> sdahi(), scllo() and sclhi() are waiting adap->udelay before returning.
> How in this condition can the driver change both SCL and SDA values in a
> row?

Do you mean to transition SCL and SDA at the same time?  It cannot, nor
does it have to.  Take another look at the I2C protocol spec, especially
figure 4 on page 9.

> 2* It looks like i2c-algo-bit assumes that both SDA and SCL are high by
> the time it is called. Why that? Looks like not all drivers will do so.

Because that is the bus idle condition?  If the hardware has pullups
on SCL and SDA then the driver doesn't need to do anything to cause
bus idle.  OTOH if SCL/SDA are floating, then the driver might have
to manually establish bus idle first.  Again, I haven't looked at the
source... but it makes sense if that's how it's implemented.  The
algorithm simply expects an idle bus.  The driver does whatever it
must do (possibly nothing) to create that condition.

> Especially, I tried my changes using i2c-matroxfb and it looks like this
> driver doesn't set SDA not SCL before registering with i2c-algo-bit,
> causing bit_test to sometimes fail with the message "seems to be busy".
> I wonder if it wouldn't be easier (and safer) not to assume anything
> about SDA and SCL in i2c-algo-bit.c:test_bus() (that is, remove that
> "may be busy" test).

In this case, do you remove and reload the modules, or are you forced
to reboot the machine?  The bus really might just be stuck.  The I2C
bus is especially vulnerable to SCL stuck low because start, idle, and
stop conditions are all impossible in that case; and the wired-AND-ness
of SCL means it only takes one confused slave to kill the bus.

[1] http://www.semiconductors.philips.com/acrobat/literature/9398/39340011.pdf

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
