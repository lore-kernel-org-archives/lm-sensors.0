From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 27 Feb 2014 21:36:46 +0000
Subject: Re: [lm-sensors] sensors.conf for Gigabyte B75-D3V
Message-Id: <20140227213646.GA18339@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <005901cf33ae$ccc48130$664d8390$@gmx.de>
In-Reply-To: <005901cf33ae$ccc48130$664d8390$@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Feb 27, 2014 at 08:55:47PM +0100, Jean Delvare wrote:
> Hi Guenter,
> 
> On Thu, 27 Feb 2014 09:52:42 -0800, Guenter Roeck wrote:
> > On Thu, Feb 27, 2014 at 06:20:54PM +0100, Jean Delvare wrote:
> > > First time I see this. I don't know which driver does this but this
> > > looks pretty wrong, "pkg" is way too generic as a device name. This
> > > should be fixed quickly.
> >
> > Not sure, but it might come in through drivers/thermal/x86_pkg_temp_thermal.c.
> > It registers thermal zones named pkg-temp-<processor id>.
> 
> A name with a dash, that's bad. What about catching (and rejecting)
> these in hwmon_device_register_with_groups?
> 
They are calling hwmon_device_register(), so we don't see the name
and it would not help. The entire hwmon initialization sequence
from thermal is kind of upside down (hwmon device registration
and attribute handline is pretty much independent of each other),
so changing to the new API would be all but impossible.

Anyway, I think it is a good idea to add a validation to the new API.
I'll implement it and submit a patch when I find a few minutes.

Of course even that won't help much to prevent hyper-generic names
like the above from being introduced. pkg ? what pkg ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
