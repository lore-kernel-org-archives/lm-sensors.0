From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 26 Jan 2014 20:13:57 +0000
Subject: Re: [lm-sensors] lm90 driver no longer working on PCs in 3.13
Message-Id: <20140126211357.6fa68909@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <52E561D0.4040308@roeck-us.net>
In-Reply-To: <52E561D0.4040308@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Wei Ni <wni@nvidia.com>

Hi Guenter,

Adding Wei Ni to Cc, as he provided the commit which causes problem.

On Sun, 26 Jan 2014 11:28:16 -0800, Guenter Roeck wrote:
> Hi,
> 
> the lm90 driver is no longer working on PCs with the 3.13 kernel ... or at least not without
> special configuration.
> 
> This is what I get if I try to instantiate a device on it (max6695):
> 
> i2c 1-0018: Driver lm90 requests probe deferral
> i2c i2c-1: new_device: Instantiated device max6695 at 0x18
> 
> The regulator core always returns -EPROBE_DEFER if the platform does not support devicetree
> and if the regulator it is looking for does not exist. Since the driver now requires a mandatory
> regulator (commit 3e0f964f2ad - hwmon: (lm90) Add power control), and the regulator it requests
> does not exist on a PC, the result is not really surprising. I thought the regulator core would
> realize that it has to return a dummy regulator, but apparently that is not the case, or I don't
> know how to configure it.
> 
> Any idea what I might need to do to get it working ?

Me, I really don't know. I seem to remember I tested Wei's patch set on
an emulated ADM1032 chip and it was working fine. So maybe it depends
on the kernel configuration, or something changed on the regulator side
meanwhile.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
