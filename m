From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 27 Jun 2014 10:50:58 +0000
Subject: Re: [lm-sensors] hwmon: ntc_thermistor: Add another ntc(epcos) to the driver
Message-Id: <20140627125058.0d4b79a0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAJKbBDDYdGATTtW0Vz6v1iqnwkLgjj8dB8-dgM0xPAb+UkHvAg@mail.gmail.com>
In-Reply-To: <CAJKbBDDYdGATTtW0Vz6v1iqnwkLgjj8dB8-dgM0xPAb+UkHvAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johannes Pointner <johannes.pointner@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

On Fri, 27 Jun 2014 10:50:39 +0200, Johannes Pointner wrote:
> As I saw in the latest patches for the ntc_thermistor, in which as
> part of the patch the module description changed to :
> 
> MODULE_DESCRIPTION("NTC Thermistor Driver from Murata");
> 
> I wanted to know if it is intended to extend the driver for further
> manufacturers like in my case for an epcos ntc in the future?

If there is enough compatibility, then yes, of course.

> Of course I would create the necessary patch.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
