From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: [2.6 patch] i2c-core.c: make some code static
Message-Id: <20050131215050.61c2924c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050131185955.GA18316@stusta.de>
In-Reply-To: <20050131185955.GA18316@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: greg@kroah.com, sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org

Hi Adrian,

> This patch makes some needlessly global code static.
> (...)
> @@ -38,12 +38,43 @@
>  static DECLARE_MUTEX(core_lists);
>  static DEFINE_IDR(i2c_adapter_idr);
>  
> -int i2c_device_probe(struct device *dev)
> +/* match always succeeds, as we want the probe() to tell if we really
> accept this match */ +static int i2c_device_match(struct device *dev,
> struct device_driver *drv) +{
> +	return 1;
> +}
> +
> +static int i2c_bus_suspend(struct device * dev, pm_message_t state)
> +{
> +	int rc = 0;
> +
> +	if (dev->driver && dev->driver->suspend)
> +		rc = dev->driver->suspend(dev,state,0);
> +	return rc;
> +}
> +
> +static int i2c_bus_resume(struct device * dev)
> +{
> +	int rc = 0;
> +	
> +	if (dev->driver && dev->driver->resume)
> +		rc = dev->driver->resume(dev,0);
> +	return rc;
> +}
> +
> +static struct bus_type i2c_bus_type = {
> +	.name =		"i2c",
> +	.match =	i2c_device_match,
> +	.suspend =      i2c_bus_suspend,
> +	.resume =       i2c_bus_resume,
> +};
> +
> +static int i2c_device_probe(struct device *dev)
>  {
>  	return -ENODEV;
>  }
>  
> -int i2c_device_remove(struct device *dev)
> +static int i2c_device_remove(struct device *dev)
>  {
>  	return 0;
>  }
> @@ -523,38 +554,6 @@
>         up(&adap->clist_lock);
>  }
>  
> -
> -/* match always succeeds, as we want the probe() to tell if we really
> accept this match */ -static int i2c_device_match(struct device *dev,
> struct device_driver *drv) -{
> -	return 1;
> -}
> -
> -static int i2c_bus_suspend(struct device * dev, pm_message_t state)
> -{
> -	int rc = 0;
> -
> -	if (dev->driver && dev->driver->suspend)
> -		rc = dev->driver->suspend(dev,state,0);
> -	return rc;
> -}
> -
> -static int i2c_bus_resume(struct device * dev)
> -{
> -	int rc = 0;
> -	
> -	if (dev->driver && dev->driver->resume)
> -		rc = dev->driver->resume(dev,0);
> -	return rc;
> -}
> -
> -struct bus_type i2c_bus_type = {
> -	.name =		"i2c",
> -	.match =	i2c_device_match,
> -	.suspend =      i2c_bus_suspend,
> -	.resume =       i2c_bus_resume,
> -};
> -
>  static int __init i2c_init(void)
>  {
>  	int retval;

Is moving that code around really necessary? Looks to me like only the
i2c_bus_type structure needs to be moved.

Thanks,
-- 
Jean Delvare
