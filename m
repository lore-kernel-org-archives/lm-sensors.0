From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [RFC PATCH 2.6.12-rc3-mm2 1/2] i2c: new sysfs class "hwmon"
Message-Id: <20050503205329.GA16137@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050503034928.GC4977@jupiter.solarsys.private>
In-Reply-To: <20050503034928.GC4977@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, May 02, 2005 at 11:49:28PM -0400, Mark M. Hoffman wrote:
> 
> This patch adds the sysfs class "hwmon" for use by hardware monitoring
> (sensors) chip drivers.  It (the Kconfig text) presumes that sensors
> chip drivers will be moved to drivers/hwmon (although that is not done
> by this patch).

Looks good, minor comments:

> --- linux-2.6.12-rc3-mm2.orig/drivers/hwmon/hwmon.c	2005-04-22 03:12:06.429003480 -0400
> +++ linux-2.6.12-rc3-mm2/drivers/hwmon/hwmon.c	2005-05-02 22:34:51.000000000 -0400
> @@ -0,0 +1,64 @@
> +/*
> +    hwmon.c - part of lm_sensors, Linux kernel modules for hardware monitoring
> +
> +    This file defines the sysfs class "hwmon", for use by sensors drivers.
> +
> +    Copyright (C) 2005 Mark M. Hoffman <mhoffman@lightlink.com>
> +
> +    This program is free software; you can redistribute it and/or modify
> +    it under the terms of the GNU General Public License as published by
> +    the Free Software Foundation; either version 2 of the License, or
> +    (at your option) any later version.

Do you really mean "any later version"?

> +    This program is distributed in the hope that it will be useful,
> +    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +    GNU General Public License for more details.
> +
> +    You should have received a copy of the GNU General Public License
> +    along with this program; if not, write to the Free Software
> +    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

You don't need these two paragraphs.

> +EXPORT_SYMBOL(hwmon_device_register);
> +EXPORT_SYMBOL(hwmon_device_unregister);

EXPORT_SYMBOL_GPL() perhaps?

> +/**
> + * hwmon_device_register - register w/ hwmon sysfs class
> + * @dev: the device to register
> + *
> + * hwmon_device_unregister() must be called when the class device is no longer needed.
> + *
> + * Returns the pointer to the new struct class device.
> + */
> +struct class_device *hwmon_device_register(struct device *dev);

kerneldoc comments belong in the .c file, not the .h file.

thanks,

greg k-h
