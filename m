From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Dec 2013 19:03:09 +0000
Subject: Re: [lm-sensors] [PATCH 00/12] i8k patch series
Message-Id: <20131214200309.3a2007f4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1387042221-3671-1-git-send-email-linux@roeck-us.net>
	<201312141945.20348.arnd@arndb.de>
In-Reply-To: <201312141945.20348.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Sat, 14 Dec 2013 19:45:19 +0100, Arnd Bergmann wrote:
> On Saturday 14 December 2013, Guenter Roeck wrote:
> > Clean up and simplify the driver, add support for additional temperature
> > sensors, fix a problem seen with multi-core CPU, and add support
> > for additional systems.
> > 
> > ----------------------------------------------------------------
> > Guenter Roeck (14):
> >       i8k: Convert to use pr_ functions instead of printk
> >       i8k: Fix various checkpatch warnings and errors
> >       i8k: Convert to use to hwmon_device_register_with_groups hwmon API
> >       i8k: Support additional temperature sensors
> >       MAINTAINERS: Add myself as i8k maintainer
> >       i8k: Remove obsolete link to out-of-tree driver
> >       i8k: Drop driver version number and info message at startup
> >       i8k: Force SMM to run on CPU 0
> >       i8k: Add copyright
> >       i8k: Add support for Dell Studio laptops
> >       i8k: Add support for Dell XPS M140
> >       i8k: Use driver_data field of dmi_system_id to override fan multiplier
> >       i8k: Stop reading SMM BIOS version during driver probe
> >       i8k: Implement hwmon based fan speed control
> > 
> >  MAINTAINERS        |    2 +-
> >  drivers/char/i8k.c |  358 +++++++++++++++++++++++++++++-----------------------
> >  2 files changed, 201 insertions(+), 159 deletions(-)
> > 
> 
> All changes in this patch set look good to me.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> I wonder if it makes sense to move the driver to drivers/platform/x86/, which
> has a bunch of similar ones already.

That would be a good idea IMHO.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
