From: Johannes Pointner <johannes.pointner@gmail.com>
Date: Thu, 21 Aug 2014 07:29:56 +0000
Subject: [lm-sensors] iio: iio_channel_get: ntc_thermistor isn't working since patch for of_iio_channel_get_b
Message-Id: <CAJKbBDBCEVfB-f6W1NbpPhuyduYB4KQMoT=9=wF4yny3a6weKA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org

Hello,

I found out that since this patch https://lkml.org/lkml/2014/6/11/201,
which fixes the return values in this function, the ntc_thermistor
driver isn't working anymore for me.
The problem is that before the driver asked for probe deferral because
the adc driver isn't loaded at this point and now the probe fails in
the function iio_channel_get_sys and returns -ENODEV.
My question is: Who is in this case responsible to request a deferral?
The driver or the subsystem?

Thanks,
Hannes

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
