From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 14 Feb 2011 19:01:33 +0000
Subject: Re: [lm-sensors] hwmon API update
Message-Id: <20110214190133.GA26577@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D57CC24.1040306@free.fr>
In-Reply-To: <4D57CC24.1040306@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 14, 2011 at 11:23:38AM -0500, Matthew Garrett wrote:
[ ... ]
> 
> It's often the case that fan control on these cards is handled by an 
> external hwmon chip, while the thermal diode is integrated into the chip 
> core and therefore only readable by the PCI driver. In that case we need 
> to be able to access the fan control registers. In other cases, cooling 
> is implemented passively by reducing the clock on the card. In those 
> cases the PCI driver needs to be able to obtain the temperature from 
> off-card chips. Whether you think the hardware approach sucks or not, 
> the reality is that we have plenty of devices where maanging the thermal 
> state of the hardware requires a single driver to be able to access both 
> PCI and i2c devices.
> 
So what you actually want to do is to implement fan control and/or, more
generically, power management, in the kernel. Fan control is so far implemented
in userland, the idea being that it is too complex and not well enough understood
to implement in the kernel.

So one of the questions is why you can not keep it that way - and that might include
clock management if the required attributes are made available through sysfs.
Once the code is stable, and if there are good arguments to move the functionality
into the kernel, one may still consider doing it. By then we would hopefully 
also have a better understanding of requirements, such as if and to what degree 
interrupt and event handling support would be required, and how to organize 
and/or create necessary subsystems to be usable for everyone, not just for GPUs.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
