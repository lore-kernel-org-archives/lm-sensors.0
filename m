From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 13 Feb 2011 17:16:40 +0000
Subject: Re: [lm-sensors] hwmon API update
Message-Id: <20110213171640.GB13323@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D57CC24.1040306@free.fr>
In-Reply-To: <4D57CC24.1040306@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Peres <martin.peres@free.fr>
Cc: nouveau <Nouveau@lists.freedesktop.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Sun, Feb 13, 2011 at 07:18:44AM -0500, Martin Peres wrote:
> Hi,
> 
> I am working on power management on the nouveau driver and I need a way 
> to get data out of and send commands to the i2c drivers from the kernel 
> space.
> 
> We can already change the clocks of the card, but we need a way to 
> monitor the temperature and bump the fan speed if needed.
> Another problem with letting users mess with the i2c driver by 
> themselves is that some cards use the i2c driver for fan management 
> while others don't. This is why I would like to introduce nouveau as an 
> hwmon driver, exporting the temperature, fan management and clock speeds 
> so as we can use the thermal zone to monitor the temperature and react 
> when needed.
> 
> So far, we use:
> - w83l785ts
> - w83781d
> - adt7473 (most common one)
> - f75375
> - lm99
> 
> With the help of Matthew Garret, I updated his previous proposal for an 
> in-kernel API for hwmon. The patch should apply cleanly on Linux 
> 2.6.38-rc4. This patch only provides the API, no modification to the 
> drivers has been completed yet.
> 
> Looking forward to your review and feedback.
> 
> Martin

> From 059b647b7b8bd98c04cf48b4062048b8ae963593 Mon Sep 17 00:00:00 2001
> From: Martin Peres <martin.peres@ensi-bourges.fr>
> Date: Sun, 13 Feb 2011 11:35:17 +0100
> Subject: [PATCH] hwmon API update
> 
> Original creator: Matthew Garrett <mjg@redhat.com>
> 
> Signed-off-by: Martin Peres <martin.peres@ensi-bourges.fr>

This is an extremely complex change just for the benefit of one driver,
with a huge potential of misuse. The changes required in each driver
to actually implement the API are substantial, and pretty much only add
complexity to each hwmon driver with no real benefit.

The cost gets even larger if one has to consider that some may want or
have to to backport drivers to earlier kernel versions. This patchset
would result in significant efforts to do such backports.

For the API itself, there are lots of functions with similar parameters, 
and those parameters are needed in the drivers to determine which attribute
is affected. A single function would have accomplished the same, as the drivers
will need case statements anyway to identify the actual attribute to be read
or written. What we end up here with is a large number of functions to be
supported by each driver, all with pretty much the same set of arguments.

I don't know what current thinking is about kernel size increases, but it
looks like this patch will result in quite significant kernel size increase
(some 18*8 = 144 bytes per driver for all the pointers, plus the actual 
functions, adds up to a lot). Again this would be with no benefit for most
of the users of the hwmon subsystem. Sure, one can argue that the size increases
will only occur if the drivers are actually loaded, but that is a pretty weak
argument since the code size increase will still show up in each driver.

In summary I am not in favor for this change. Maybe Jean thinks differently,
but for my part I don't plan to approve it.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
