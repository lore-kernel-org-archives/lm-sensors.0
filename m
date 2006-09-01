From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 01 Sep 2006 11:42:40 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND 4] hwmon: new vt1211 driver
Message-Id: <20060901134240.c1454ae1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

> This is a new driver for the VIA vt1211 Super-IO chip. It is a rewrite
> of the existing vt1211 driver (by Mark D. Studebaker and Lars Ekman)
> which has been around for a while but never made it into the main
> kernel tree.
> 
> It is implemented as a platform driver and therefore requires the
> latest CVS version of lm_sensors to function properly.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

There are still a few things not correct:

> +	/* Create sysfs interface files */
> +	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_in_input); i++) {
> +		if (ISVOLT(i, data->uch_config)) {
> +			if ((err = device_create_file(dev,
> +				&vt1211_sysfs_in_input[i].dev_attr)) ||
> +			    (err = device_create_file(dev,
> +				&vt1211_sysfs_in_min[i].dev_attr)) ||
> +			    (err = device_create_file(dev,
> +				&vt1211_sysfs_in_max[i].dev_attr)) ||
> +			    (err = device_create_file(dev,
> +				&vt1211_sysfs_in_alarm[i].dev_attr))) {
> +				goto EXIT_DEV_REMOVE;
> +		  }
> +		}
> +	}

You have a misplaced parenthesis here.

> +static int __init vt1211_init(void)
> +{
> +	int err;
> +	unsigned short address = 0;
> +
> +	err = vt1211_find(&address);
> +	if (err) {
> +		goto EXIT;
> +	}
> +
> +	if ((uch_config < -1) || (uch_config > 31)) {
> +		err = -ENODEV;
> +		printk(KERN_WARNING DRVNAME ": Invalid UCH configuration %d. "
> +		       "Choose a value between 0 and 31.\n", uch_config);
> +	  goto EXIT;
> +	}
> +
> +	if ((int_mode < -1) || (int_mode > 0)) {
> +		err = -ENODEV;
> +		printk(KERN_WARNING DRVNAME ": Invalid interrupt mode %d. "
> +		       "Only mode 0 is supported.\n", int_mode);
> +	  goto EXIT;
> +	}

-ENODEV is not true, the device is there. -EINVAL would make more
sense.

> +
> +	err = platform_driver_register(&vt1211_driver);
> +	if (err) {
> +		goto EXIT;
> +	}
> +
> +	/* Sets global pdev as a side effect */
> +	err = vt1211_device_add(address);
> +	if (err) {
> +		goto EXIT_DRV_UNREGISTER;
> +	}
> +
> +	return 0;
> +
> +EXIT_DRV_UNREGISTER:
> +	platform_driver_unregister(&vt1211_driver);
> +EXIT:
> +	return err;
> +}

Care to resend an updated patch?

Aha, just kidding :) I've fixed it myself. Patch applied, thanks, and
great job!

-- 
Jean Delvare

