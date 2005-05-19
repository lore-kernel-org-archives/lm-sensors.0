From: bzolnier@gmail.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: [PATCH][I2C] Marvell mv64xxx i2c driver
Message-Id: <58cb370e05020816017431b38@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42094ADB.9040403@mvista.com>
In-Reply-To: <42094ADB.9040403@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Greg KH <greg@kroah.com>, LM Sensors <sensors@stimpy.netroedge.com>, lkml <linux-kernel@vger.kernel.org>

Hi,

just a minor thing

> +static int __devinit
> +mv64xxx_i2c_init(void)
> +{
> +       return driver_register(&mv64xxx_i2c_driver);
> +}

__init

> +static void __devexit
> +mv64xxx_i2c_exit(void)
> +{
> +       driver_unregister(&mv64xxx_i2c_driver);
> +       return;
> +}

__exit

these functions relate to module not device

> +module_init(mv64xxx_i2c_init);
> +module_exit(mv64xxx_i2c_exit);
