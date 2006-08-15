From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 15 Aug 2006 07:37:12 +0000
Subject: [lm-sensors] [RFC PATCH 2.6.18-rc4-mm1] hwmon: unchecked return
Message-Id: <20060815093712.e2e5561a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060814020407.GA3327@jupiter.solarsys.private>
In-Reply-To: <20060814020407.GA3327@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> I added some return value checks in w83627ehf_detect(). This is called
> from i2c_isa_add_driver using driver->attach_adapter(&isa_adapter). So
> I returned an error from w83627ehf_detect(), and was surprised to see
> that the module silently succeeded, without fully creating the
> w83627ehf sysfs interface. I looked deeper and found that
> i2c_isa_add_driver() does not check the return value when calling its
> driver->attach_adapter(). i2c_isa_add_driver() is called from
> sensors_w83627ehf_init(), which is the module_init function.

Good catch, we should indeed check the return value.

This code was copied from i2c-core, where the value returned by
driver->attach_adapter() is ignored as well. There's even a comment:
"We ignore the return code; if it fails, too bad". Sigh. The problem in
i2c-core is that attach_adapter() will be called in a loop, on each
available driver (when calling i2c_add_adapter) or each available
adapter (when calling i2c_add_driver). We can't stop if one call fail,
that wouldn't be fair for the others which may still succeed. The proper
fix is to switch to the device driver model...

In the i2c-isa case things are much more simple, we have a single call
so failing on error sounds good.

> I have attached a very short patch for drivers/i2c/busses/i2c-isa.c
> which should fix the problem. Instead of returning 0, it returns the
> result of driver->attach_adapter().

> diff -ur linux-2.6.18-rc4/drivers/i2c/busses/i2c-isa.c linux-2.6.18-rc4/drivers/i2c/busses/i2c-isa.c
> --- linux-2.6.18-rc4/drivers/i2c/busses/i2c-isa.c	2006-08-14 17:48:28.000000000 -0700
> +++ linux-2.6.18-rc4/drivers/i2c/busses/i2c-isa.c	2006-08-14 17:52:04.000000000 -0700
> @@ -89,9 +89,7 @@
>  	dev_dbg(&isa_adapter.dev, "Driver %s registered\n", driver->driver.name);
>  
>  	/* Now look for clients */
> -	driver->attach_adapter(&isa_adapter);
> -
> -	return 0;
> +	return driver->attach_adapter(&isa_adapter);
>  }

That's not enough, unfortunately. In case of error you must unregister
the driver before returning. I also think we should print some message
on error. Care to send an updated patch?

> However, this may cause a great deal of unexpected grief, considering
> how many drivers use this function.

Not that many (11), and they are all hardware monitoring drivers.

-- 
Jean Delvare

