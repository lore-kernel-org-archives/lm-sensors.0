From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: Patch for I2C + sysfs
Message-Id: <20040109231724.GC4693@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 09, 2004 at 07:09:28AM -0700, Matthew Mastracci wrote:
> This patch ensures that I2C adapter devices show up under the
> /sys/bus/i2c directory.  Without, only I2C devices themselves will show
> up, breaking HAL.  

Ccing the sensors list, as I should have pointed you to that in the
first place, sorry.

> --- drivers/i2c/i2c-core.c~     2004-01-08 20:47:05.000000000 -0700
> +++ drivers/i2c/i2c-core.c      2004-01-08 20:47:22.000000000 -0700
> @@ -143,6 +143,7 @@
>         sprintf(adap->dev.bus_id, "i2c-%d", adap->nr);
>         adap->dev.driver = &i2c_adapter_driver;
>         adap->dev.release = &i2c_adapter_dev_release;
> +       adap->dev.bus = &i2c_bus_type;
>         device_register(&adap->dev);
>         device_create_file(&adap->dev, &dev_attr_name);

But adapters are not on the i2c bus.  They are the "root" of the i2c
bus.  I2C adapters live as devices on other busses (PCI, platform, etc.)

What exactly is the problem that HAL can't see the devices in the place
where they are in the sysfs tree?

thanks,

greg k-h
