From: kai.svahn@nokia.com (Kai Svahn)
Date: Mon, 06 Mar 2006 10:10:13 +0000
Subject: [lm-sensors] i2c-core error messages
Message-Id: <20060306101013.GK16281@six.research.nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060306071543.GE16281@six.research.nokia.com>
In-Reply-To: <20060306071543.GE16281@six.research.nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

On Mon, Mar 06, 2006 at 10:36:04AM +0100, ext Jean Delvare wrote:
> 
> Ah, so it was function i2c_probe_address, not i2c_probe.

Yeah sorry about that I wrote at the first time just from my memory
didn't look the code my mistake :) . 

> 
> > ---line 664---
> > if (kind < 0) {
> > 	if (i2c_smbus_xfer(adapter, addr, 0, 0, 0,
> > 		          I2C_SMBUS_QUICK, NULL) < 0)
> > 		return 0;
> > }
> > ---
> > Shouldn't it be something like, or have I misunderstood something here?
> > 
> > if (kind < 0) {
> > 	if ((err = (i2c_smbus_xfer(adapter, addr, 0, 0, 0,
> > 	                           I2C_SMBUS_QUICK, NULL)) < 0)
> > 		return err;
> > }
> 
> No, we return 0 on purpose.
> 
> Each driver lists the possible addresses for the device(s) it supports.
> More often than not, only one of these addresses will hold a real chip
> on a given system (unless the same chip is used several times in a given
> design.) Other address probes are expected to fail, so this is not an
> error.
> 
> The real problem here is that the design of our probing mechanism is not
> suitable for every design. When you know where your chip is, it's a bit
> frustrating that you have to let the i2c-core probe and find out by
> itself, especially when it makes it harder to detect errors.

Yes, that I found out it was kinda hard to debug but I found a solution
for the problem without changing this.

> A new explicit attach method is being worked on (for quite some time
> now...) which should hopefully help in this type of situation. A
> preliminary patch can be seen here:
> http://khali.linux-fr.org/devel/i2c/linux-2.6/i2c-probe-04-explicit-attach.patch
> But I need some real life uses to make sure it's properly designed. I
> wanted to experiment on the zoran media/video driver, but didn't quite
> find the time to do that yet.

Sounds nice I can take a look at it also and maybe try it out.

> Thanks,
> --
> Jean Delvarei

Thank you about the information.

Cheers,
Kai

