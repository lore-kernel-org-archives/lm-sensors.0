From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 25 Nov 2013 21:15:48 +0000
Subject: Re: [lm-sensors] lm_sensors, hwmon, conky
Message-Id: <5293BE04.4060707@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CABfEahBWGnHRAPGXh1yao02OCGRjRFwKw=T4QSrXn1BKb7QyNA@mail.gmail.com>
In-Reply-To: <CABfEahBWGnHRAPGXh1yao02OCGRjRFwKw=T4QSrXn1BKb7QyNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 11/25/2013 12:02 PM, Patrick... wrote:
> Using hwmon to config conky.
> At reboot the info from hwmon appears in different hwmon
> directories.   Consequently, conky reads the wrong info into
> it's output.
>
> Is this an unreported bug or ?
>
> Please advise.
>

Hi,

unfortunately, you don't provide enough information to really enable us to help.

 From looking into the conky source, I am making the assumption that
you see the problem when booting kernel version 3.13-rc1. Of course,
that is just a wild guess.

conky wrongly assumes that sensor attributes are available in directory
/sys/class/hwmon/hwmonX/device. That assumption is wrong; attributes
can also be in /sys/class/hwmon/hwmonX directly. Several existing drivers
implement this scheme already and thus never worked with conky.
Starting with kernel version 3.13, several drivers have been converted
to attach sysfs attributes to the hwmon device and no longer to its
parent device. Going forward, more drivers will be converted to the new scheme.

Oddly enough, conky also searches through i2c and platform device directories
when looking for hwmon attributes. That is really not a good idea either.
It may work today, but there is no guarantee that it will work tomorrow.

conky should only look in /sys/class/hwmon/hwmonX and /sys/class/hwmon/hwmonX/device
for hwmon attributes. It can select the correct directory by searching for
the mandatory 'name' attribute. Of couse, an even better solution would
be to use libsensors to access hwmon attributes.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
