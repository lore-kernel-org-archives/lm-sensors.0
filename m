From: Tang Yuantian-B29983 <B29983@freescale.com>
Date: Tue, 15 Nov 2011 02:35:44 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pmbus) Fix two issues
Message-Id: <3C06C26914DACA4BB3A368F78CA0B3A712AA6F@039-SN1MPN1-004.039d.mgd.msft.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321249266-17071-1-git-send-email-Yuantian.Tang@freescale.com>
In-Reply-To: <1321249266-17071-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean Delvare,

Please find my comments in line.

> -----Original Message-----
> 
> Again, no. PMBus goes on top of SMBus which includes SMBus block reads
> (i2c_smbus_read_block_data) but not I2C block reads
> (i2c_smbus_read_i2c_block_data). As a result, many hardware SMBus
> controllers do not support I2C block reads, and it can't be added (only
> the set of transfers supported by the hardware controller can be
> implemented by the driver) which means that your proposed change would
> break support on existing systems. This is not acceptable.
> 
> On the other hand, an I2C controller which supports I2C block reads can
> almost always get SMBus block reads added, it's only a matter of adding a
> few lines of code to the bus driver.
> 
> Which i2c bus driver are you using? From which kernel version?
> 
[Yuantian:] I am using newest kernel 3.2. PowerPC arch. 
I2c bus driver file is: drivers/i2c/busses/i2c-mpc.c.

I greped the i2c bus driver and found the following platform's i2c don't 
Support i2c_smbus_read_block_data. So Zl6100 driver can't work on these platforms.
1. drivers/i2c/busses/i2c-mpc.c(powerpc arch, which I am working on).
2. drivers/i2c/busses/i2c-mv64xxx.c
3. drivers/i2c/busses/i2c-nomadik.c
4. drivers/i2c/busses/i2c-octeon.c
5. drivers/i2c/busses/i2c-pxa.c
6. drivers/i2c/busses/i2c-s6000.c
Almost all the platforms the kernel support.
But they all support I2C_FUNC_SMBUS_EMUL, which means support i2c_smbus_read_i2c_block_data.
How can you explain this?

> > > > 2. Not all zlxx chips's id start with zlxx. zl6100's id starts
> > > > with 0x10. Take this situation into account.
> bus driver, the device driver never gets to see it, if you properly call
> i2c_smbus_read_block_data() as you are supposed to.
> 
> --
> Jean Delvare

Regards,
Yuantian


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
