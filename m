From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 06 Mar 2006 09:36:04 +0000
Subject: [lm-sensors] i2c-core error messages
Message-Id: <4pWSMF8X.1141637763.9989750.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060306071543.GE16281@six.research.nokia.com>
In-Reply-To: <20060306071543.GE16281@six.research.nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Kai,

On 2006-03-06, Kai Svahn wrote:
> > Which version of the i2c-core.c file are you referring to, please? The
> > file Linux 2.6.16-rc5 has an i2c_probe function which properly returns
> > errors.
>
> I have rc5 and I found a problem here
> static int i2c_probe_address(struct i2c_adapter *adapter, int addr,
>         int kind, int (*found_proc) (struct i2c_adapter *,int, int)

Ah, so it was function i2c_probe_address, not i2c_probe.

> ---line 664---
> if (kind < 0) {
> 	if (i2c_smbus_xfer(adapter, addr, 0, 0, 0,
> 		          I2C_SMBUS_QUICK, NULL) < 0)
> 		return 0;
> }
> ---
> Shouldn't it be something like, or have I misunderstood something here?
> 
> if (kind < 0) {
> 	if ((err = (i2c_smbus_xfer(adapter, addr, 0, 0, 0,
> 	                           I2C_SMBUS_QUICK, NULL)) < 0)
> 		return err;
> }

No, we return 0 on purpose.

Each driver lists the possible addresses for the device(s) it supports.
More often than not, only one of these addresses will hold a real chip
on a given system (unless the same chip is used several times in a given
design.) Other address probes are expected to fail, so this is not an
error.

The real problem here is that the design of our probing mechanism is not
suitable for every design. When you know where your chip is, it's a bit
frustrating that you have to let the i2c-core probe and find out by
itself, especially when it makes it harder to detect errors.

A new explicit attach method is being worked on (for quite some time
now...) which should hopefully help in this type of situation. A
preliminary patch can be seen here:
http://khali.linux-fr.org/devel/i2c/linux-2.6/i2c-probe-04-explicit-attach.patch
But I need some real life uses to make sure it's properly designed. I
wanted to experiment on the zoran media/video driver, but didn't quite
find the time to do that yet.

Thanks,
--
Jean Delvare

