From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Aug 2014 21:58:39 +0000
Subject: Re: [lm-sensors] power supply gating with ltc2978
Message-Id: <53EE828F.2070101@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.02.1408151623140.21645@atx-linux-37>
In-Reply-To: <alpine.DEB.2.02.1408151623140.21645@atx-linux-37>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: atull <atull@opensource.altera.com>
Cc: Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>

On 08/15/2014 02:34 PM, atull wrote:
> Hello,
>
> I am interested in adding functionality to be able to gate power supplies
> going through a ltc2978.  I see that there is a hwmon driver already
> existing (hwmon/pmbus/ltc2978.c).  I see some of the other hwmon drivers
> have MFD's.  It looks like this ltc driver would need a MFD and a
> regulator driver added.  However I don't see other pmbus hwmon drivers
> using MFD.
>
> So I am asking for recommendations and reservations on how to proceed here
> before I get too far with this.
>

I would suggest to add the regulator driver registration into the pmbus code.
I would have done this earlier myself, but there was no clear need for it
so I did not bother.

The functionality between regulator and limit/status reporting is heavily
intertwined in pmbus devices, and there is no clear functional separation
between power regulation and limit/status reporting related functionality.
Or, in other words, PMBus devices are not multi-function devices.

One of the challenges is that the values to write into the "operation" register
is device specific, so it is not possible to enable the functionality for all
PMBus chips. We'll need some device specific configuration data, such as on/off
values or maybe function callbacks into device specific code, to enable
regulator functionality.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
