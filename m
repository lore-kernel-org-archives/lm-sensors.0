From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 24 Sep 2007 15:11:28 +0000
Subject: Re: [lm-sensors] [PATCH 8/9] ACPI: thinkpad-acpi: use a separate
Message-Id: <20070924171128.19f91009@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1190557457539-git-send-email-hmh@hmh.eng.br>
	<11905574583315-git-send-email-hmh@hmh.eng.br>
In-Reply-To: <11905574583315-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM-MRDXTZLjjMs8G+1z+Pypc6QD96bmaF075NbjCUgZEJk@public.gmane.org, Sensors ML <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Hi Henrique,

On Sun, 23 Sep 2007 11:24:16 -0300, Henrique de Moraes Holschuh wrote:
> Use a separate platform device to attach hwmon attributes and class, and
> add a name attribute of "thinkpad_hwmon" to it.  To do it properly, we
> also register a new platform driver ("thinkpad_hwmon").

The name attribute should really read "thinkpad" not "thinkpad_hwmon",
otherwise "sensors" will present the chip as "thinkpad_hwmon-isa-0000",
its section in /etc/sensors.conf will be named chip "thinkpad_hwmon-*",
etc. That's pretty redundant and unaesthetic.

> This makes thinkpad-acpi compatible with libsensors4 from lm-sensors, and
> the platform driver and device split will make it much easier to separate
> hwmon functionality into its own module later on.

I'm still not convinced that we want a separate device for this. If you
have a namespace issue, it's because the hwmon attributes are created
directly in the device directory (for historical reasons) while they
should be created in the hwmon class device directory. I'd rather work
on fixing this now, than use a temporary workaround as you are
proposing.

> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Cc: LM Sensors ML <lm-sensors@lm-sensors.org>

It's pretty pointless to have a mailing list listed here, as the list
itself can't ack nor nack your patch.

> ---
>  Documentation/thinkpad-acpi.txt |   24 +++++++++---
>  drivers/misc/thinkpad_acpi.c    |   79 +++++++++++++++++++++++++++++++++------
>  drivers/misc/thinkpad_acpi.h    |    6 ++-
>  3 files changed, 90 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
> index 60953d6..029bb43 100644
> --- a/Documentation/thinkpad-acpi.txt
> +++ b/Documentation/thinkpad-acpi.txt
> @@ -105,10 +105,15 @@ The version of thinkpad-acpi's sysfs interface is exported by the driver
>  as a driver attribute (see below).
>  
>  Sysfs driver attributes are on the driver's sysfs attribute space,
> -for 2.6.20 this is /sys/bus/platform/drivers/thinkpad_acpi/.
> +for 2.6.20 this is /sys/bus/platform/drivers/thinkpad_acpi/ and
> +/sys/bus/platform/drivers/thinkpad_hwmon/
>  
> -Sysfs device attributes are on the driver's sysfs attribute space,
> -for 2.6.20 this is /sys/devices/platform/thinkpad_acpi/.
> +Sysfs device attributes are on the thinkpad_acpi device sysfs attribute
> +space, for 2.6.20 this is /sys/devices/platform/thinkpad_acpi/.

That's confusing. You keep mentioning version 2.6.20 when your patch
will not make it into mainline before 2.6.24 at best.

> +
> +Sysfs device attributes for the sensors and fan are on the
> +thinkpad_hwmon device's sysfs attribute space, but you should locate it
> +looking for a hwmon device with the name attribute of "thinkpad_hwmon".
>  
>  Driver version
>  --------------
> @@ -766,7 +771,7 @@ Temperature sensors
>  -------------------
>  
>  procfs: /proc/acpi/ibm/thermal
> -sysfs device attributes: (hwmon) temp*_input
> +sysfs device attributes: (hwmon "thinkpad_hwmon") temp*_input
>  
>  Most ThinkPads include six or more separate temperature sensors but only
>  expose the CPU temperature through the standard ACPI methods.  This
> @@ -989,7 +994,9 @@ Fan control and monitoring: fan speed, fan enable/disable
>  ---------------------------------------------------------
>  
>  procfs: /proc/acpi/ibm/fan
> -sysfs device attributes: (hwmon) fan_input, pwm1, pwm1_enable
> +sysfs device attributes: (hwmon "thinkpad_hwmon") fan_input, pwm1,
> +			  pwm1_enable

fan_input is not a valid attribute name, should be fan1_input.

> +sysfs hwmon driver attributes: fan_watchdog
>  
>  NOTE NOTE NOTE: fan control operations are disabled by default for
>  safety reasons.  To enable them, the module parameter "fan_control=1"
> @@ -1131,7 +1138,7 @@ hwmon device attribute fan1_input:
>  	which can take up to two minutes.  May return rubbish on older
>  	ThinkPads.
>  
> -driver attribute fan_watchdog:
> +hwmon driver attribute fan_watchdog:
>  	Fan safety watchdog timer interval, in seconds.  Minimum is
>  	1 second, maximum is 120 seconds.  0 disables the watchdog.
>  
> @@ -1233,3 +1240,8 @@ Sysfs interface changelog:
>  		layer, the radio switch generates input event EV_RADIO,
>  		and the driver enables hot key handling by default in
>  		the firmware.
> +
> +0x020000:	ABI fix: added a separate hwmon platform device and
> +		driver, which must be located by name (thinkpad_hwmon)
> +		and the hwmon class for lm_sensors4 compatibility.

There's no lm_sensors4. It's either lm-sensors 3, or libsensors4. (I
know it's confusing, not my fault.)

> +		Moved all hwmon attributes to this new platform device.
> diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
> index 8bd6c83..4a85ede 100644
> --- a/drivers/misc/thinkpad_acpi.c
> +++ b/drivers/misc/thinkpad_acpi.c
> @@ -22,7 +22,7 @@
>   */
>  
>  #define IBM_VERSION "0.16"
> -#define TPACPI_SYSFS_VERSION 0x010000
> +#define TPACPI_SYSFS_VERSION 0x020000
>  
>  /*
>   *  Changelog:
> @@ -526,6 +526,7 @@ static char *next_cmd(char **cmds)
>   ****************************************************************************/
>  
>  static struct platform_device *tpacpi_pdev;
> +static struct platform_device *tpacpi_sensors_pdev;
>  static struct class_device *tpacpi_hwmon;
>  static struct input_dev *tpacpi_inputdev;
>  static struct mutex tpacpi_inputdev_send_mutex;
> @@ -553,6 +554,12 @@ static struct platform_driver tpacpi_pdriver = {
>  	.resume = tpacpi_resume_handler,
>  };
>  
> +static struct platform_driver tpacpi_hwmon_pdriver = {
> +	.driver = {
> +		.name = IBM_HWMON_DRVR_NAME,
> +		.owner = THIS_MODULE,
> +	},
> +};
>  
>  /*************************************************************************
>   * thinkpad-acpi driver attributes
> @@ -2872,7 +2879,7 @@ static int __init thermal_init(struct ibm_init_struct *iibm)
>  
>  	switch(thermal_read_mode) {
>  	case TPACPI_THERMAL_TPEC_16:
> -		res = sysfs_create_group(&tpacpi_pdev->dev.kobj,
> +		res = sysfs_create_group(&tpacpi_sensors_pdev->dev.kobj,
>  				&thermal_temp_input16_group);
>  		if (res)
>  			return res;
> @@ -2880,7 +2887,7 @@ static int __init thermal_init(struct ibm_init_struct *iibm)
>  	case TPACPI_THERMAL_TPEC_8:
>  	case TPACPI_THERMAL_ACPI_TMP07:
>  	case TPACPI_THERMAL_ACPI_UPDT:
> -		res = sysfs_create_group(&tpacpi_pdev->dev.kobj,
> +		res = sysfs_create_group(&tpacpi_sensors_pdev->dev.kobj,
>  				&thermal_temp_input8_group);
>  		if (res)
>  			return res;
> @@ -2897,13 +2904,13 @@ static void thermal_exit(void)
>  {
>  	switch(thermal_read_mode) {
>  	case TPACPI_THERMAL_TPEC_16:
> -		sysfs_remove_group(&tpacpi_pdev->dev.kobj,
> +		sysfs_remove_group(&tpacpi_sensors_pdev->dev.kobj,
>  				   &thermal_temp_input16_group);
>  		break;
>  	case TPACPI_THERMAL_TPEC_8:
>  	case TPACPI_THERMAL_ACPI_TMP07:
>  	case TPACPI_THERMAL_ACPI_UPDT:
> -		sysfs_remove_group(&tpacpi_pdev->dev.kobj,
> +		sysfs_remove_group(&tpacpi_sensors_pdev->dev.kobj,
>  				   &thermal_temp_input16_group);
>  		break;
>  	case TPACPI_THERMAL_NONE:
> @@ -3686,7 +3693,7 @@ static struct device_attribute dev_attr_fan_fan1_input >  	__ATTR(fan1_input, S_IRUGO,
>  		fan_fan1_input_show, NULL);
>  
> -/* sysfs fan fan_watchdog (driver) ------------------------------------- */
> +/* sysfs fan fan_watchdog (hwmon driver) ------------------------------- */
>  static ssize_t fan_fan_watchdog_show(struct device_driver *drv,
>  				     char *buf)
>  {
> @@ -3828,10 +3835,10 @@ static int __init fan_init(struct ibm_init_struct *iibm)
>  
>  	if (fan_status_access_mode != TPACPI_FAN_NONE ||
>  	    fan_control_access_mode != TPACPI_FAN_WR_NONE) {
> -		rc = sysfs_create_group(&tpacpi_pdev->dev.kobj,
> +		rc = sysfs_create_group(&tpacpi_sensors_pdev->dev.kobj,
>  					 &fan_attr_group);
>  		if (!(rc < 0))
> -			rc = driver_create_file(&tpacpi_pdriver.driver,
> +			rc = driver_create_file(&tpacpi_hwmon_pdriver.driver,
>  					&driver_attr_fan_watchdog);
>  		if (rc < 0)
>  			return rc;
> @@ -3914,8 +3921,8 @@ static void fan_exit(void)
>  	vdbg_printk(TPACPI_DBG_EXIT, "cancelling any pending fan watchdog tasks\n");
>  
>  	/* FIXME: can we really do this unconditionally? */
> -	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &fan_attr_group);
> -	driver_remove_file(&tpacpi_pdriver.driver, &driver_attr_fan_watchdog);
> +	sysfs_remove_group(&tpacpi_sensors_pdev->dev.kobj, &fan_attr_group);
> +	driver_remove_file(&tpacpi_hwmon_pdriver.driver, &driver_attr_fan_watchdog);
>  
>  	cancel_delayed_work(&fan_watchdog_task);
>  	flush_scheduled_work();
> @@ -4366,6 +4373,19 @@ static struct ibm_struct fan_driver_data = {
>   ****************************************************************************
>   ****************************************************************************/
>  
> +/* sysfs name ---------------------------------------------------------- */
> +static ssize_t thinkpad_acpi_pdev_name_show(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	return snprintf(buf, PAGE_SIZE, "%s\n", IBM_HWMON_DRVR_NAME);
> +}
> +
> +static struct device_attribute dev_attr_thinkpad_acpi_pdev_name > +	__ATTR(name, S_IRUGO, thinkpad_acpi_pdev_name_show, NULL);
> +
> +/* --------------------------------------------------------------------- */
> +
>  /* /proc support */
>  static struct proc_dir_entry *proc_dir;
>  
> @@ -4768,12 +4788,20 @@ static int __init thinkpad_acpi_module_init(void)
>  
>  	ret = platform_driver_register(&tpacpi_pdriver);
>  	if (ret) {
> -		printk(IBM_ERR "unable to register platform driver\n");
> +		printk(IBM_ERR "unable to register main platform driver\n");
>  		thinkpad_acpi_module_exit();
>  		return ret;
>  	}
>  	tp_features.platform_drv_registered = 1;
>  
> +	ret = platform_driver_register(&tpacpi_hwmon_pdriver);
> +	if (ret) {
> +		printk(IBM_ERR "unable to register hwmon platform driver\n");
> +		thinkpad_acpi_module_exit();
> +		return ret;
> +	}
> +	tp_features.sensors_pdrv_registered = 1;
> +
>  	ret = tpacpi_create_driver_attributes(&tpacpi_pdriver.driver);
>  	if (ret) {
>  		printk(IBM_ERR "unable to create sysfs driver attributes\n");
> @@ -4793,7 +4821,26 @@ static int __init thinkpad_acpi_module_init(void)
>  		thinkpad_acpi_module_exit();
>  		return ret;
>  	}
> -	tpacpi_hwmon = hwmon_device_register(&tpacpi_pdev->dev);
> +	tpacpi_sensors_pdev = platform_device_register_simple(
> +							IBM_HWMON_DRVR_NAME,
> +							-1, NULL, 0);

As explained before, libsensors won't pick this device. You'd need to
give it an id of 0 instead of -1. Hmm, I'll see if I can hack something
in libsensors4 until that part of the code is reimplemented in a better
way.

> +	if (IS_ERR(tpacpi_sensors_pdev)) {
> +		ret = PTR_ERR(tpacpi_sensors_pdev);
> +		tpacpi_sensors_pdev = NULL;
> +		printk(IBM_ERR "unable to register hwmon platform device\n");
> +		thinkpad_acpi_module_exit();
> +		return ret;
> +	}
> +	ret = device_create_file(&tpacpi_sensors_pdev->dev,
> +				 &dev_attr_thinkpad_acpi_pdev_name);
> +	if (ret) {
> +		printk(IBM_ERR
> +			"unable to create sysfs hwmon device attributes\n");
> +		thinkpad_acpi_module_exit();
> +		return ret;
> +	}
> +	tp_features.sensors_pdev_attrs_registered = 1;
> +	tpacpi_hwmon = hwmon_device_register(&tpacpi_sensors_pdev->dev);
>  	if (IS_ERR(tpacpi_hwmon)) {
>  		ret = PTR_ERR(tpacpi_hwmon);
>  		tpacpi_hwmon = NULL;
> @@ -4864,12 +4911,20 @@ static void thinkpad_acpi_module_exit(void)
>  	if (tpacpi_hwmon)
>  		hwmon_device_unregister(tpacpi_hwmon);
>  
> +	if (tp_features.sensors_pdev_attrs_registered)
> +		device_remove_file(&tpacpi_sensors_pdev->dev,
> +				   &dev_attr_thinkpad_acpi_pdev_name);
> +	if (tpacpi_sensors_pdev)
> +		platform_device_unregister(tpacpi_sensors_pdev);
>  	if (tpacpi_pdev)
>  		platform_device_unregister(tpacpi_pdev);
>  
>  	if (tp_features.platform_drv_attrs_registered)
>  		tpacpi_remove_driver_attributes(&tpacpi_pdriver.driver);
>  
> +	if (tp_features.sensors_pdrv_registered)
> +		platform_driver_unregister(&tpacpi_hwmon_pdriver);
> +
>  	if (tp_features.platform_drv_registered)
>  		platform_driver_unregister(&tpacpi_pdriver);
>  
> diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
> index fa64ded..791b8ca 100644
> --- a/drivers/misc/thinkpad_acpi.h
> +++ b/drivers/misc/thinkpad_acpi.h
> @@ -58,13 +58,14 @@
>  
>  #define IBM_NAME "thinkpad"
>  #define IBM_DESC "ThinkPad ACPI Extras"
> -#define IBM_FILE "thinkpad_acpi"
> +#define IBM_FILE IBM_NAME "_acpi"
>  #define IBM_URL "http://ibm-acpi.sf.net/"
>  #define IBM_MAIL "ibm-acpi-devel@lists.sourceforge.net"
>  
>  #define IBM_PROC_DIR "ibm"
>  #define IBM_ACPI_EVENT_PREFIX "ibm"
>  #define IBM_DRVR_NAME IBM_FILE
> +#define IBM_HWMON_DRVR_NAME IBM_NAME "_hwmon"
>  
>  #define IBM_LOG IBM_FILE ": "
>  #define IBM_ERR	   KERN_ERR    IBM_LOG
> @@ -171,6 +172,7 @@ static int parse_strtoul(const char *buf, unsigned long max,
>  
>  /* Device model */
>  static struct platform_device *tpacpi_pdev;
> +static struct platform_device *tpacpi_sensors_pdev;
>  static struct class_device *tpacpi_hwmon;
>  static struct platform_driver tpacpi_pdriver;
>  static struct input_dev *tpacpi_inputdev;
> @@ -249,6 +251,8 @@ static struct {
>  	u32 input_device_registered:1;
>  	u32 platform_drv_registered:1;
>  	u32 platform_drv_attrs_registered:1;
> +	u32 sensors_pdrv_registered:1;
> +	u32 sensors_pdev_attrs_registered:1;
>  } tp_features;
>  
>  struct thinkpad_id_data {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
