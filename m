From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 27 Jun 2014 14:15:55 +0000
Subject: Re: [lm-sensors] hwmon: ntc_thermistor: Add another ntc(epcos) to the driver
Message-Id: <53AD7C9B.8040407@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAJKbBDDYdGATTtW0Vz6v1iqnwkLgjj8dB8-dgM0xPAb+UkHvAg@mail.gmail.com>
In-Reply-To: <CAJKbBDDYdGATTtW0Vz6v1iqnwkLgjj8dB8-dgM0xPAb+UkHvAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johannes Pointner <johannes.pointner@gmail.com>, Jean Delvare <jdelvare@suse.de>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

On 06/27/2014 01:50 AM, Johannes Pointner wrote:
> As I saw in the latest patches for the ntc_thermistor, in which as
> part of the patch the module description changed to :
>
> MODULE_DESCRIPTION("NTC Thermistor Driver from Murata");
>
> I wanted to know if it is intended to extend the driver for further
> manufacturers like in my case for an epcos ntc in the future?
>

Sure, why not ? Better than create an entirely new driver which would
be all the same but for the tables. The comment is misleading anyway
(the driver is for Murata thermistors, not from them), so we can
always drop the "from Murata".

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
