From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: [PATCH 2.6] Fix conversion from milli volts in store_in_reg() for
Message-Id: <20030904184035.GA11160@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030602172040.GC4992@kroah.com> <20030605023922.GA8943@earth.solarsys.private> <20030605194734.GA6238@kroah.com> <1055136870.5280.196.camel@workshop.saharacpt.lan> <20030610054107.GA22719@earth.solarsys.private> <1055401021.5280.3143.camel@workshop.saharacpt.lan> <20030613023651.GA1401@earth.solarsys.private> <1055571995.12868.5.camel@nosferatu.lan> <20030616184149.GC25585@kroah.com> <1062622452.5275.38.camel@nosferatu.lan>
In-Reply-To: <1062622452.5275.38.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, LKML <linux-kernel@vger.kernel.org>, Sensors <sensors@stimpy.netroedge.com>

On Wed, Sep 03, 2003 at 10:54:12PM +0200, Martin Schlemmer wrote:
> Hi
> 
> I am not sure if it was a later patch from me that fixed in_* to display
> milli volts in sysfs, or if it was a patch from Jan Dittmer, but the
> conversion in the store_in_*() functions is wrong, and cause something
> like:
> 
> ----------------------------
> nosferatu patch # cat /sys/bus/i2c/devices/1-0290/in_max2
> 3632
> nosferatu patch # echo '3700' > /sys/bus/i2c/devices/1-0290/in_max2
> nosferatu patch # cat /sys/bus/i2c/devices/1-0290/in_max2
> 400
> nosferatu patch # echo '3640' > /sys/bus/i2c/devices/1-0290/in_max2
> nosferatu patch # cat /sys/bus/i2c/devices/1-0290/in_max2
> 400
> nosferatu patch # echo '3632' > /sys/bus/i2c/devices/1-0290/in_max2
> nosferatu patch # cat /sys/bus/i2c/devices/1-0290/in_max2
> 400
> nosferatu patch #
> -----------------------------
> 
> I think Andrey also noticed this (if I did not smoke too much Weedbix
> this morning ;) - if so, please verify that this fixes it ... it does
> here at least.
> 
> Anyhow, patch is attached and should apply to 2.6.0-test4-bk5.

Applied, thanks.

greg k-h
