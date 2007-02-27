From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 27 Feb 2007 18:07:07 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <20070227190707.f78b987d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 27 Feb 2007 17:29:59 +0100, Matej Kenda wrote:
> 2007/2/27, Jean Delvare <khali at linux-fr.org>:
> > > * define i2c driver ID in the include/i2c-id.h
> >
> > Even better, don't set an ID if you don't need it.
> 
> Most of the hwmon drivers set the id. Were they set by inertia or do
> some of the drivers actually need it?

Inertia, mostly.

> > The files should actually be named fan1_input to fan4_input (for
> > measured values.)
> 
> I've modified the names like this:
> 
> static DEVICE_ATTR(fan1_input, S_IRUGO, get_fan1, NULL);
> static DEVICE_ATTR(fan2_input, S_IRUGO, get_fan2, NULL);
> static DEVICE_ATTR(fan3_input, S_IRUGO, get_fan3, NULL);
> static DEVICE_ATTR(fan4_input, S_IRUGO, get_fan4, NULL);
> static DEVICE_ATTR(count, S_IRUGO, get_count, NULL);
> static DEVICE_ATTR(config, S_IRUGO, get_config, NULL);
> static DEVICE_ATTR(speed, S_IWUSR | S_IRUGO, get_speed, set_speed);
> 
> Other driver usually have _min and _div files.

It only makes sense if the chip actually supports it!

> Do the count, speed and config also have to be modified to follow a convention?

The count and config files are non-standard files so they don't have to
follow any specific convention. In fact I would even remove these
files, in particular the config file infringes the fundamental sysfs
rule. And the count file isn't particularly useful.

The speed file, what is it doing? If it is used to set the desired fan
speed, then the right name would be fan1_target. Does it only apply to
one fan or all? Is it always active?

-- 
Jean Delvare

