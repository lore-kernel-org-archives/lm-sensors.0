From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 01 Oct 2005 21:49:09 +0000
Subject: [lm-sensors] Re: [PATCH 2.6-mm 5/5] i2c: make i2c-isa drivers
Message-Id: <20051001214903.782cb7e3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <433D50FC.30907@free.fr>
In-Reply-To: <433D50FC.30907@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Laurent,

> In function i2c_isa_add_driver, copied driver should inherit the owner field
> as well as the name field.
> 
> 
> Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
> ---
> 
> Index: linux-2.6-mm/drivers/i2c/busses/i2c-isa.c
> =================================> --- linux-2.6-mm.orig/drivers/i2c/busses/i2c-isa.c      2005-09-30 16:27:50.000000000 +0200
> +++ linux-2.6-mm/drivers/i2c/busses/i2c-isa.c   2005-09-30 16:34:00.903153000 +0200
> @@ -92,6 +92,7 @@
> 
>         /* Add the driver to the list of i2c drivers in the driver core */
>         driver->driver.name = driver->name;
> +       driver->driver.owner = driver->owner;
>         driver->driver.bus = &i2c_bus_type;
>         driver->driver.probe = i2c_isa_device_probe;
>         driver->driver.remove = i2c_isa_device_remove;
> 
> 

This one doesn't apply, because of tabs/spaces conversions it seems.
Please resend in a suitable form.

BTW, I appreciate diffstat output in the patch headers, it helps
figuring out at a glance which files a patch affects and how.

Thanks,
-- 
Jean Delvare
