From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 26 Jan 2014 19:28:16 +0000
Subject: [lm-sensors] lm90 driver no longer working on PCs in 3.13
Message-Id: <52E561D0.4040308@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>

Hi,

the lm90 driver is no longer working on PCs with the 3.13 kernel ... or at least not without
special configuration.

This is what I get if I try to instantiate a device on it (max6695):

i2c 1-0018: Driver lm90 requests probe deferral
i2c i2c-1: new_device: Instantiated device max6695 at 0x18

The regulator core always returns -EPROBE_DEFER if the platform does not support devicetree
and if the regulator it is looking for does not exist. Since the driver now requires a mandatory
regulator (commit 3e0f964f2ad - hwmon: (lm90) Add power control), and the regulator it requests
does not exist on a PC, the result is not really surprising. I thought the regulator core would
realize that it has to return a dummy regulator, but apparently that is not the case, or I don't
know how to configure it.

Any idea what I might need to do to get it working ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
