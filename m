From: Andreas Werner <andreas.werner@men.de>
Date: Thu, 10 Dec 2015 12:08:57 +0000
Subject: [lm-sensors] LM90 driver and ti tmp461 detection
Message-Id: <20151210120856.GA27765@awelinux>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: jdelvare@suse.com, linux@roeck-us.net, lm-sensors@lm-sensors.org, wni@nvidia.com

Hi,
i have a temperature sensor device named "TI TMP461" which is quite the
same than the tmp451 which is already included in the lm90 driver.

I just want to add the tmp461 to the driver but currently i have no way
to differ between the tmp461 and tmp451.

The main different is that the tmp461 address can be configured by to Pins
whereas the tmp451 has a fixed address.

The register layout is quite the same except that the tmp461 has one
register more (0x16 Channel Enable Register).

Every zero bit is the same for both bits, so we cannot use these bits for
identification.

Does anybody of you have a tmp451 to read out the register 0x16 (which is
not implement but i expect a value). May be we can use this to
identify the tmp461.

Regards
Andy



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
