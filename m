From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 05 Dec 2008 14:06:54 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: New driver for the Asus F8000
Message-Id: <20081205150654.57a7c051@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081204155242.32c3255e@hyperion.delvare>
In-Reply-To: <20081204155242.32c3255e@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 05 Dec 2008 14:53:33 +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> > A new driver (f8000) to support the hardware monitoring features of
> > the Asus F8000 Super-I/O chip, together with documentation.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> Looks good to me, nice and simple.

True :)

> > ---
> > Hans, looking at the datasheet of the Asus/Fintek F8000, it appears to
> > have a lot in common with the F71882FG and F71862FG, in particular when
> > it comes to fan speed control. So maybe you will prefer to add support
> > to your f71882fg driver, rather than having a new driver?
> > 
> 
> Well, looking at the current driver you submitted, it looks much simpler, so I 
> think its better to have it as a separate driver, rather then add tons of ifs 
> to the f71882fg driver.
> 
> Or is this just the tip of the iceberg and are there more features to implement?

This is the problem. I only implemented the minimal functionality
initially because I didn't have a datasheet. Now I have a datasheet but
no time to extend the driver, especially as there is only one user for
this driver so far. However, if a user ever comes asking for fan speed
control on the F8000, I will most certainly decide that I don't want to
add it to the f8000 driver because it would simply duplicate a lot of
code from your f71882fg driver. So at this point we would have to add
support for the F8000 to your driver anyway. Which makes me wonder if
it makes sense to do it now to save the users the hassle of a driver
change. Again, not that there are that many users to date, but still...

The F8000 also has shared features with the F71882FG and/or F718862FG,
for example diode fault detection and over-temperature alarms. Maybe
you want to take a look at the datasheet and make your own opinion?

Note that I am not too sure myself what to do. In the past, adding
support for Asus custom chips to other drivers has usually been a bad
idea. We ended up moving the ASB100 support to a separate driver, and
it is unfortunate that we didn't do the same for the AS99127F because
it adds quite some conditionals to the w83781d driver. Not to mention
that we can't offer the same level of support on the AS99127F than we
do for other chips supported by that driver, as we have datasheets for
the Winbond chips and not for the Asus AS99127F. From a distribution
perspective, where support level is essentially a per-module value,
this is bad.

The situation is a bit different for the F8000 though, as we DO have a
datasheet for that chip.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
