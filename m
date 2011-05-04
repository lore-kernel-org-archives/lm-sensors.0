From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 04 May 2011 16:29:12 +0000
Subject: Re: [lm-sensors] [RFC 2/5] gpio: add support for Technologic
Message-Id: <201105041829.12801.arnd@arndb.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1304115712-5299-1-git-send-email-vivien.didelot@savoirfairelinux.com> <1304115712-5299-3-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1304115712-5299-3-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, Jerome Oufella <jerome.oufella@savoirfairelinux.com>, platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org, lm-sensors@lm-sensors.org

On Saturday 30 April 2011, Vivien Didelot wrote:
> +       ts5xxx_sbcinfo_set(&sbcinfo);
> +       if (5500 != sbcinfo.board_id) {
> +               printk(MODULE_NAME ": Incompatible TS Board.\n");
> +               return -ENODEV;
> +       }

The above should not be necessary:

> +static int __init ts5500_gpio_init(void)
> +{
> +       int ret;
> +
> +       ret = platform_driver_register(&ts5500_gpio_driver);
> +       if (ret)
> +               return ret;
> +
> +       ret = platform_device_register(&gpio_device);
> +       if (ret) {
> +               printk(MODULE_NAME ": Failed to register platform device\n");
> +               platform_driver_unregister(&ts5500_gpio_driver);
> +               return ret;
> +       }
> +
> +       printk(MODULE_NAME ": GPIO/DIO driver loaded.\n");
> +       return 0;
> +}
> +module_init(ts5500_gpio_init);

Doing it this way requires you know that you have to load the driver,
which is not good if you want to have the same kernel running on 
different machines.

Better move the device registration into your platform code, in the
place where you know what device you have. The add a MODULE_DEVICE_TABLE()
entry to the module so the driver gets automatically loaded (if it's
a module), and match the platform device to the driver you register
from the module_init function.

Same for the other devices where you follow the same pattern.

Another way to do the same in a more modern fashion would be
to provide a flattened device tree that describes all your devices
and pass that into the kernel. Take a look at the CE4100 and OLPC
platforms to see how that is done.

	Arnd

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
