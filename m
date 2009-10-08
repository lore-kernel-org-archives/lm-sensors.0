From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 08 Oct 2009 12:18:50 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.31-rc2] hwmon: add support for
Message-Id: <20091008141850.4d9e940e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.com>
In-Reply-To: <73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Lu,

Sorry for the late answer.

On Sat, 11 Jul 2009 15:19:02 +0000, lu zhihe wrote:
> > I am also curious what these PCI devices are. We do not want to have
> > driver conflicts, so it might make more sense to add hardware
> > monitoring functionality to an existing driver than writing a brand new
> > driver.
> 
>   They are Host Bridge Devices D0:F0. As driver touch North Bridge, it
> need to avoid drivers conflict.
> Although I test on my Lenovo F31G platform, it seems work.
> 
>   But it need to make sure, as your suggestion.
> 
>   I check i915.ko and agp-intel.ko. What I found are:
> 1. i915.ko (drivers/gpu/drm/i915) is registed as Internal Graphics
> Device 2(D2:F0-F1) driver.
> 2. agp-intel.ko (drivers/char/agp/intel-agp.c) is registed as Host
> Bridge Devices D0:F0 pci driver.
> 
> May be gm965temp will conflict with agp-intel. And I check agp-intel
> driver, it don't touch MCHBAR register. For GM965, it only touch:
> 
> /* Intel 965G registers */
> #define I965_MSAC 0x62
> #define I965_IFPADDR    0x70
> 
> And it mainly focus on Internal Graphics Device 2(D2:F0-F1) configure
> and process.
> It don't touch the Thermal sensor register, even don't touch MCHBAR register.
> 
> apg-intel focus on agpgart table setting, so I curious that it should
> not add function as hwmon driver too.
> 
> What's more. I check hwmon's PCI driver, sis5595, it's ID is
> "PCI_DEVICE_ID_SI_503". And it also register on
> drivers/i2c/busses/i2c-sis5595 as PCI driver. The situation is similar
> as gm965temp and agp-intel.

You will notice that both the (hwmon) sis5595 and i2c-sis5595 drivers
have a probe function which ends with:

	pci_dev_get(dev);
	return -ENODEV;

Basically we have to fail the probe, otherwise the device is marked as
busy and the second driver can't bind. This works, but it has a number
of downsides, for example all drivers must cooperate, and it doesn't
fit the device driver model so things like power management can be
difficult to implement properly. And these drivers can only support one
device, or they become more complex.

It would certainly be possible to do the same in your case. However,
while it does make sense for relatively large drivers (and sis5595 and
i2c-sis5595 both fall into this category with 26 kB and 12 kB of source
code, respectively), the driver you want to add is small (less than 8
kB) so the alternative of just adding the hwmon feature to an existing
driver is appealing. But there are other things to consider too, for
example whether the different devices you want to support have the same
"main" driver today or not.

> Above are my opinion for PCI driver conflict.
> Please help me to review them?
> 
> May be I just make some mistake, and don't notice. :-)

Thanks for your analysis. I'll think about it, look at the code more
deeply, and come back to you when I'm done.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
