From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: Accessing I2C clients from kernel code?
Message-Id: <3E792C76.6050301@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030311230413.A31883@saturn.billgatliff.com>
In-Reply-To: <20030311230413.A31883@saturn.billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

congratulations on a working adapter and chip driver.

From inside the kernel the best single entry point is probably i2c_smbus_xfer();
see i2c-dev.c for an example.
Any of the i2c_smbus_read/write/block_xxx calls from i2c-core.c are also fine.

Bill Gatliff wrote:
> Guys:
> 
> 
> I have an embedded computer that has a DS1307 on it.  I wrote an i2c
> adapter for the board, and now it appears to find the chip:
> 
> ..
> i2c-core.o: i2c core module
> i2c-dev.o: i2c /dev entries driver module
> i2c-core.o: driver i2c-dev dummy driver registered.
> i2c-algo-bit.o: i2c bit algorithm module
> i2c_xxx_init: builtin i2c bus adapter <bgat@billgatliff.com>
> i2c-dev.o: Registered 'xxx-i2c' as minor 0
> i2c-core.o: adapter xxx-i2c registered as adapter 0.
> i2c-proc.o version 2.6.1 (20010825)
> ..
> i2c-core.o: driver ds1307 registered.
> i2c-core.o: client [ds1307] registered to adapter [xxx-i2c](pos. 0).
> Dallas Semiconductor DS1307 Real-Time Clock driver (V0.03)
> i2c-core.o: driver fs6377 registered.
> i2c-core.o: client [fs6377] registered to adapter [xxx-i2c](pos. 1).
> fs6377_set_register(fs6377.c:101): WARNING: skipping register initialization
> AMI FS6377 Programmable PLL driver $Revision: 1.4 $ <bgat@billgatliff.com>
> ..
> 
> (I also wrote the fs6377 driver).
> 
> Trouble is, I can't figure out how I'm supposed to access the ds1307
> from kernel code.  My goal is to use the ds1307 as the system's
> realtime clock, which means I have to "hook" it to /dev/rtc and/or
> /proc/driver/rtc.
> 
> 
> My current attempt looks like this:
> 
> static unsigned long xxx_rtc_get_time (void)
> {
>   struct i2c_client *c;
>   struct ds1307_date d;
>   int i;
> 
>   c = i2c_get_client(I2C_DRIVERID_DS1307, 0, 0);
> 
>   if (c)
>     {
>       if (!i2c_use_client(c))
> 	{
> 	  i = ds1307_getdate(c, &d);
> 	  i2c_release_client(c);
> 	  return mktime(d.tm_year, d.tm_mon, d.tm_mday,
>                         d.tm_hour, d.tm_min, d.tm_sec);
> 	}
>       else printk("%s: error: i2c client already in use!\n", __FUNCTION__);
>     }
> 
>   else printk("%s: error: couldn't get i2c client handle!\n", __FUNCTION__);
> 
>   return mktime(2000, 1, 1, 0, 0, 0);
> }
> 
> 
> But I'm pretty sure that isn't what you had in mind.  :^)
> 
> I had to make ds1370_getdate() nonstatic to do this.  I have also
> noticed that the results returned by ds1307_getdate() aren't right---
> the time doesn't change.  (But since the ds1307 i2c driver can "see"
> the chip, the i2c adapter code must be right, no?)
> 
> What's the right way to go about communicating with a ds1307 i2c
> device from inside the kernel?  I could really use an example or two.
> 
> 
> Thanks!
> 
> 
> b.g.
