From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: Linux  2.6.10-rc3 for 8xx with I2C config enabled  fails ...
Message-Id: <20041219150053.GB10771@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Alexander:

* Povolotsky, Alexander <Alexander.Povolotsky@marconi.com> [2004-12-18 10:57:38 -0500]:
> Hi Mark,

Not sure why you're writing me privately...

> I have FreeScale (Motorola) 8xx custom board with single 24C02 I2C EEPROM,
> connected to the I2C bus.
> 
> Building Linux (latest and greatest ;-) ) 2.6.10-rc3 FAILS for 8xx with I2C
> config enabled  - see attached below - 
> but it works in Linux 2.4 .
> 
> So I want to try to port 8xx i2c bus driver code from the 2.4.26 (which
> works !) to Linux 2.6 ...
> 
> In Linux 2.6 distribution I see:
> 
> .../drivers/i2c/busses and .../drivers/i2c/algos 
> 
> I do not see the same subdirectories in the Linux 2.4 distribution ...
> 
> Is there any documentation (or may be you could kindly explain to me)
> what was the idea behind reorganizing drivers sub-directories between 2.4
> and 2.6 ?
> It looks like those changes are beyond simply 'cosmetic' improvements ? - am
> I correct ?

AFAIK, the directory org was just cosmetic.

>  - I would highly appreciate this answer, since it would help me to attempt
> to try make it work in 2.6 !

If you haven't already, take a look here for documentation:

http://secure.netroedge.com/~lm78/docs.html

And if you have any more questions, please send them to the sensors mailing list
which I've CC'ed.  BTW: there's no need to subscribe, the list is open.

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Tuesday, December 14, 2004 4:38 AM
> To: Alexander.Povolotsky@marconi.com; greg@kroah.com
> Subject: Re: 8xx i2c drivers (cross)compilation errors on Linux 2.6.8
> 
> On 2004-12-14, Alexander Povolotsky wrote:
> 
> > Hi,
> >
> > I have the following .config setup:
> > (...)
> > CONFIG_I2C_RPXLITE=y
> > (...)
> > 
> > Originally I was getting error:
> >  CC      drivers/i2c/busses/i2c-rpx.o
> > drivers/i2c/busses/i2c-rpx.c:20:32: linux/i2c-algo-8xx.h: No such file or
> > directory - why I am missing it - any hint ?
> 
> Hm, looks like the 8xx i2c algorithm was never ported to Linux 2.6. Greg,
> how come that the RPX adapter driver is present in the tree and the
> algorithm it depends on isn't?
> 
> > So I copied the i2c-algo-8xx.h file from Linux 2.4.26 distribution ...
> > could I use it ?
> > (if not - could you send me the correct i2c-algo-8xx.h file ? - TIA !)
> 
> I don't think it'll work. The header file is one thing, the algorithm
> driver is another and you would need to port both (they proabbly won't
> work out of the box due to important changes in the i2c subsystem
> between 2.4 and 2.6 kernels). Also, obviously the RPX adapter driver
> couldn't be used so far so it was possibly never tested. There will
> probably be much porting and debugging work if you want to get it to
> work.
> 
> Greg, could it be that an arch-specific (m68k? don't know what this
> rpx/8xx thing is) variant of the Linux tree already has the i2c-algo-8xx
> driver ported to 2.6? We probably want to import it into the main tree
> if this is the case (having adapter drivers that won't compile doesn't
> sound good...)
> 
> Alexander, at any rate, there's not much I can do myself, as I don't
> have compatible hardware to port/test/debug the i2c-algo-8xx and i2c-rpx
> drivers. Sorry.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
