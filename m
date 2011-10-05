From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 05 Oct 2011 18:30:07 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon class driver registration with a
Message-Id: <1317839407.3983.46.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1317834791-2803-1-git-send-email-hschauhan@nulltrace.org>
In-Reply-To: <1317834791-2803-1-git-send-email-hschauhan@nulltrace.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Himanshu Chauhan <hschauhan@nulltrace.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernelnewbies@kernelnewbies.org" <kernelnewbies@kernelnewbies.org>, lm-sensors@lm-sensors.org

On Wed, 2011-10-05 at 13:13 -0400, Himanshu Chauhan wrote:
> This patch adds a way to register a hwmon class driver
> with a device number rather than the default MK_DEV(0,0).
> This would help in creating required "dev" file under
> sysfs which in turn can be used in populating /dev tree
> during bootup (helpful to driver which want to show up
> a char interface along with sysfs).
> 
> Signed-off-by: Himanshu Chauhan <hschauhan@nulltrace.org>

hwmon patches should be sent to lm-sensors@lm-sensors.org.

I can not comment on the merits of your patch. Unless I am missing
something, which may well be since I only spent a couple of minutes on
it, other device classes don't seem to provide a similar API, so I don't
know if or why it would make sense for hwmon. Maybe a driver which wants
to register a character device interface should do so independently of
hwmon.

On the technical side, EXPORT_SYMBOL is missing.

Guenter

> ---
>  drivers/hwmon/hwmon.c |   28 ++++++++++++++++++++++------
>  include/linux/hwmon.h |    1 +
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index a61e781..36961c5 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -31,15 +31,17 @@ static DEFINE_IDR(hwmon_idr);
>  static DEFINE_SPINLOCK(idr_lock);
>  
>  /**
> - * hwmon_device_register - register w/ hwmon
> - * @dev: the device to register
> + * hwmon_device_register_numbered - register hwmon class dev
> + * with specific device number.
> + * @dev: Device to register.
> + * @dev_id: device number to register.
>   *
> - * hwmon_device_unregister() must be called when the device is no
> - * longer needed.
> + * hwmon_device_unregister() must be called when the device
> + * is no longer needed.
>   *
>   * Returns the pointer to the new device.
>   */
> -struct device *hwmon_device_register(struct device *dev)
> +struct device* hwmon_device_register_numbered(struct device *dev, dev_t dev_id)
>  {
>  	struct device *hwdev;
>  	int id, err;
> @@ -58,7 +60,7 @@ again:
>  		return ERR_PTR(err);
>  
>  	id = id & MAX_ID_MASK;
> -	hwdev = device_create(hwmon_class, dev, MKDEV(0, 0), NULL,
> +	hwdev = device_create(hwmon_class, dev, dev_id, NULL,
>  			      HWMON_ID_FORMAT, id);
>  
>  	if (IS_ERR(hwdev)) {
> @@ -71,6 +73,20 @@ again:
>  }
>  
>  /**
> + * hwmon_device_register - register w/ hwmon
> + * @dev: the device to register
> + *
> + * hwmon_device_unregister() must be called when the device is no
> + * longer needed.
> + *
> + * Returns the pointer to the new device.
> + */
> +struct device *hwmon_device_register(struct device *dev)
> +{
> +	return hwmon_device_register_numbered(dev, MK_DEV(0,0));
> +}
> +
> +/**
>   * hwmon_device_unregister - removes the previously registered class device
>   *
>   * @dev: the class device to destroy
> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
> index 6b6ee70..d816cbe 100644
> --- a/include/linux/hwmon.h
> +++ b/include/linux/hwmon.h
> @@ -16,6 +16,7 @@
>  
>  #include <linux/device.h>
>  
> +struct device *hwmon_device_register_numbered(struct device *dev, dev_t dev_id);
>  struct device *hwmon_device_register(struct device *dev);
>  
>  void hwmon_device_unregister(struct device *dev);



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
