From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 06 Dec 2007 13:41:13 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Let the user override the detected
Message-Id: <20071206134113.GE7021@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071109161111.451bd208@hyperion.delvare>
In-Reply-To: <20071109161111.451bd208@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-11-09 16:11:11 +0100]:
> While it is possible to force SMBus-based hardware monitoring chip
> drivers to drive a not officially supported device, we do not have this
> possibility for Super-I/O-based drivers. That's unfortunate because
> sometimes newer chips are fully compatible and just forcing the driver
> to load would work. Instead of that we have to tell the users to
> recompile the kernel driver, which isn't an easy task for everyone.
> 
> So, I propose that we add a module parameter to all Super-I/O based
> hardware monitoring drivers, letting advanced users force the driver
> to load on their machine. The user has to provide the device ID of a
> supposedly compatible device. This requires looking at the source code or
> a datasheet, so I am confident that users can't randomly force a driver
> without knowing what they are doing. Thus this should be relatively safe.
> 
> As you can see from the code, the implementation is pretty simple and
> unintrusive.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> ---
> Updated: s/overrule/override/.
> 
>  drivers/hwmon/dme1737.c    |    6 +++++-
>  drivers/hwmon/f71805f.c    |    6 +++++-
>  drivers/hwmon/f71882fg.c   |    6 +++++-
>  drivers/hwmon/it87.c       |    6 +++++-
>  drivers/hwmon/pc87360.c    |    6 +++++-
>  drivers/hwmon/pc87427.c    |    6 +++++-
>  drivers/hwmon/smsc47b397.c |    6 +++++-
>  drivers/hwmon/smsc47m1.c   |    6 +++++-
>  drivers/hwmon/vt1211.c     |    8 +++++++-
>  drivers/hwmon/w83627ehf.c  |   11 +++++++++--
>  drivers/hwmon/w83627hf.c   |    6 +++++-
>  11 files changed, 61 insertions(+), 12 deletions(-)

Git refuses to apply this patch.  Hmmm...

> --- linux-2.6.24-rc2.orig/drivers/hwmon/f71805f.c	2007-11-09 15:58:43.000000000 +0100
> +++ linux-2.6.24-rc2/drivers/hwmon/f71805f.c	2007-11-09 15:59:04.000000000 +0100
> @@ -42,6 +42,10 @@
>  #include <linux/acpi.h>

That line doesn't appear in any revision git knows about.  I guess you
based this off of some other development?  Could you please respin it?

>  #include <asm/io.h>
>  
> +static unsigned short force_id;
> +module_param(force_id, ushort, 0);
> +MODULE_PARM_DESC(force_id, "Override the detected device ID");
> +
>  static struct platform_device *pdev;
>  
>  #define DRVNAME "f71805f"
> @@ -1502,7 +1506,7 @@ static int __init f71805f_find(int sioad
>  	if (devid != SIO_FINTEK_ID)
>  		goto exit;
>  
> -	devid = superio_inw(sioaddr, SIO_REG_DEVID);
> +	devid = force_id ? force_id : superio_inw(sioaddr, SIO_REG_DEVID);
>  	switch (devid) {
>  	case SIO_F71805F_ID:
>  		sio_data->kind = f71805f;

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
