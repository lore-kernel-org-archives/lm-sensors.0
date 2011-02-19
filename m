From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 19 Feb 2011 20:48:31 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] hp_accel: Fix driver name
Message-Id: <20110219204831.GC1728@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110219142832.1516d1ee@endymion.delvare>
In-Reply-To: <20110219142832.1516d1ee@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Feb 19, 2011 at 03:11:14PM -0500, Jean Delvare wrote:
[ ... ]
> >
> > Not sure if you can do that, given the close interrelation with lis3lv02d.c.
> 
> I was a little worried about this at first, but then noticed that the
> string is (almost) only used as the name of the acpi driver and device.
> The lis3lv02d core driver doesn't deal with ACPI at all, so it
> shouldn't make a difference. Also, the lis3lv02d_i2c and lis3lv02d_spi
> drivers do have different driver name strings, which implies that there
> is no requirement for a common driver name string.
> 
> > That really asks for testing on a real system.
> 
> I agree still. The only problem I can think of is if user-space expects
> a specific ACPI driver and/or device name. Note that, in the event this
> one patch causes trouble, I'll simply drop it. I noticed what I think
> is an improper driver name while working on the driver, but what I
> really care about is moving these drivers out of drivers/hwmon, i.e.
> the first 3 patches of the set.
> 
Makes sense.

Still,

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
