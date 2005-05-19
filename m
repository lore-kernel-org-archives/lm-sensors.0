From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <8KyXGvH6.1111147628.4208300.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Tony,

> I was talking about driver->list, because of my mistaken belief as
> mentioned above, where it is initialized.  Anyway, after checking the i2c
> code, I don't see where driver->list used anywhere, so I don't think it
> will hit a bug.

I am just learning how lists work in Linux, and it seems to me that list
items only exist as their own address (they don't contain any data). So
it's not surprising that you don't see any use of driver->list.

The list itself is used in i2c-core:i2c_add_adapter():

/* inform drivers of new adapters */
list_for_each(item,&drivers) {
        driver = list_entry(item, struct i2c_driver, list);
        if (driver->flags & I2C_DF_NOTIFY)
                /* We ignore the return code; if it fails, too bad */
                driver->attach_adapter(adap);
}

And similarly in i2c-core:i2c_del_adapter().

That being said, I think we are looking at the wrong list. The oops
happens when inserting an i2c_driver, not an i2c_adapter, so the list
that will be notified is the adapters list. In i2c_add_driver() we have
the following:

/* now look for instances of driver on our adapters */
if (driver->flags & I2C_DF_NOTIFY) {
        list_for_each(item,&adapters) {
                adapter = list_entry(item, struct i2c_adapter, list);
                driver->attach_adapter(adapter);
        }
}

Since this is the only part of the function which deals with adapters,
and the oops does not occur if CONFIG_FB_NVIDIA_I2C is not set, I assume
the oops happens just here. This would mean that either we aren't able
to walk the adapters list, or i2cdev_attach_adapter dies - but I would
then expect to see it in the stack when the oops occur. For this reason
I do think that the problem is on the list walk itself, rather than the
function call in the loop.

Miles, could you please try to modify your oopsing configuration in the
following way:
  CONFIG_I2C_CHARDEV=n
  CONFIG_SENSORS_EEPROM=y
I would expect if to oops in i2c_add_driver() as well.

Tony, could it be that the i2c_adapter structures that were allocated in
the nvidiafb driver and registered with the i2c core (using
i2c_bit_add_bus() in nvidia_setup_i2c_bus()) are no more reachable at
this point? I am not familiar with the framebuffer code so I have a hard
time figuring out when the memory is allocated and when it is freed. I
think I understand it is allocated by framebuffer_alloc() and freed by
framebuffer_release()?

I note that you never actually unregister the i2c_adapters. The function
nvidia_delete_i2c_busses() is #if'd out. This means that
framebuffer_release() can free the memory while the i2c_adapters are
still in i2c-core's adapters list. This would certainly explain the
crash Miles observed.

Now, when is framebuffer_release() called? I think I understand it should
only be called if:
* the nvidia device detection somehow failed in nvidiafb_probe(); or
* the driver is unloaded, in nvidiafb_remove().
Could either case happen in Miles' case? Miles, do you actually get the
nvidiafb driver to work? If not, then the oops is easily explained by
what I just described (i2c_adapters still listed at the i2c-core level,
but freed from memory at the nvidiafb level).

Hope that helps,
--
Jean Delvare
