From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Apr 2008 14:04:16 +0000
Subject: Re: [lm-sensors] lm75: Convert to new-style I2C driver
Message-Id: <20080416160416.038ad4f2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161434.54335.laurentp@cse-semaphore.com>
In-Reply-To: <200804161434.54335.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 16 Apr 2008 15:49:47 +0200, Laurent Pinchart wrote:
> On Wednesday 16 April 2008 15:30, Jean Delvare wrote:
> > What about all the (PC) systems where the LM75 devices were probed
> > successfully so far? You're breaking them!
> > 
> > Adding support for new-style devices is fine. Dropping support for
> > legacy devices is not. Please see the f75375s driver for an example of
> > driver supporting both legacy and new-style i2c devices.
> 
> Sorry. Is there any plan to support new-style device drivers for PC hardware 
> in the future ?

I have something in mind but it's not clear if it will really happen.

We can't enumerate the I2C/SMBus hardware monitoring chips on PCs as we
do on embedded platforms, because there are soooo many different PC
motherboards (some of which cannot even be identified) that we wouldn't
be able to list them all. So we still have to rely on probing somehow.
However, I agree that switching to new-style i2c devices would be nice.
So what I have in mind is a dedicated kernel driver that would do the
probing and would instantiate the (new-style) I2C/SMBus hardware
monitoring devices.

The drawback is that the driver in question could grow quite large and
everybody would need to keep it loaded all the time, so that's not very
efficient. So an alternative would be to add a user-space interface to
create (and delete) new-style i2c devices. sensors-detect would create
a configuration file based on its finding, and some boot script would
use the user-space interface to create the devices.

But that's only wishful thinking, I have many higher-priority things to
work on at the moment, and this hasn't even been discussed in public so
I don't know what others think about my ideas.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
