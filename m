From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 22 Jan 2011 19:04:21 +0000
Subject: Re: [lm-sensors] user question about how to load xeontemp
Message-Id: <20110122200421.3c8ad22e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimtTrZuU2VXQ0b=1_Z38hOQC-sst5B0F=YEdzL7@mail.gmail.com>
In-Reply-To: <AANLkTimtTrZuU2VXQ0b=1_Z38hOQC-sst5B0F=YEdzL7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 19 Jan 2011 11:09:51 -0800, Guenter Roeck wrote:
> On Wed, 2011-01-19 at 13:52 -0500, Jerry Lin wrote:
> [ ... ]
> 
> > Questions:
> > 1) What's the name of the jc42 module that I would need to load via modprobe?
> 
> jc42. Problem is that support for it was added in a later version of the
> kernel.
> 
> > 2a) sensors-detect mentions copying from "prog/init/lm_sensors.init"
> > -- where is that prog directory?
> > 2b) Does doing that copy of lm_sensors.init take the place of
> > copying-and-pasting the module lines into the /etc/modules file in the
> > older version of the script?
> > 3) Is "ipmisensors" the same as "ipmi-si" (as in "modprobe ipmi-si")?
> 
> I don't know the status of ipmi integration and ipmi module names. There
> is the OpenIPMI project, and they have lots of patches to improve ipmi
> support. Jean may know better than me if/when/how those patches will be
> integrated into the mainline kernel.

The impisensor driver is abandoned for years. I won't look into it as I
have many other drivers to work on and I don't have supported hardware.

In the meantime, my recommendation is to use ipmitool. It is _not_
integrated with libsensors, but other than that, it should report the
sensor values properly.

> > 4) Why is sensors-detect able to detect the sensor via the coretemp
> > driver, but modprobe not able to load it?
> 
> Because your version of the coretemp driver is old and doesn't support
> your CPU.
> 
> > 5) Is there something else that I should be doing?
> > 
> Easiest would be if you could switch to a recent kernel (2.6.37 or at
> least 2.6.36). Otherwise you'll have to backport the coretemp driver (as
> Jean has tried) as well as the jc42 driver.

I already have it ready:
http://khali.linux-fr.org/devel/misc/jc42/

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
