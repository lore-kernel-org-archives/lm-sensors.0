From: Johannes Pointner <johannes.pointner@gmail.com>
Date: Fri, 27 Jun 2014 08:50:39 +0000
Subject: [lm-sensors] hwmon: ntc_thermistor: Add another ntc(epcos) to the driver
Message-Id: <CAJKbBDDYdGATTtW0Vz6v1iqnwkLgjj8dB8-dgM0xPAb+UkHvAg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

As I saw in the latest patches for the ntc_thermistor, in which as
part of the patch the module description changed to :

MODULE_DESCRIPTION("NTC Thermistor Driver from Murata");

I wanted to know if it is intended to extend the driver for further
manufacturers like in my case for an epcos ntc in the future?

Of course I would create the necessary patch.

Thanks,
Hannes

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
