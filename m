From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 30 Mar 2015 06:41:46 +0000
Subject: [lm-sensors] Call for testing: Driver for IT8620E, IT8790E
Message-Id: <5518F02A.9000703@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings:

We now have an experimental driver which supports both IT8620E and IT8790E.
The driver is available from the following url.

	https://github.com/groeck/it87

This driver supports IT8620E and IT8790E with all known chip specialties.
New features are:

- Support for IT8620E, including up to 6 fan tachometers and up to 6 pwm controls
- Support for IT8790E
- Support for Super-IO chips at SIO address 0x4e (needed for some Gigabytye boards)
- Support for two Super-IO chips in the system at the same time (needed for some
   Gigabyte boards)

This code will need extensive testing to be able to upstream it.
I would kindly ask everyone who has a board with IT8620E and/or IT8790E
to install the driver and test it, and to report the results on the
lm-sensors mailing list.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
