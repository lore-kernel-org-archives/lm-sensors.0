From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: [RFC|PATCH][2.6] Additional i2c adapter flags for i2c client
Message-Id: <20040330213418.195dc972.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40686476.7020603@convergence.de>
In-Reply-To: <40686476.7020603@convergence.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Hunold <hunold@convergence.de>
Cc: sensors@Stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>

> I've implemented the idea of an additional i2c adapter flag in order to
> be able to keep i2c drivers away from certain i2c adapters.
> 
> Here is what I did:
> 
> First of all I was surprised that "struct i2c_adapter" already contained 
> a "flags" field. It doesn't seem to be used anywhere, though -- please 
> correct me if I'm wrong.

You seem to be correct. It looks like the flags member was added to all
i2c structures, but for adapters it was left unused.

> I added one flag named "I2C_ADAP_FLAG_CLASS_MATCH" which adapters can 
> set if they want the type of the i2c driver match the type of the i2c 
> adapter.

Why would an adapter want to accept non-matching clients once we will have
added a clean isolation method?

> Next I added a "class" member to "struct i2c_driver". I decided to use 
> the same flags as for the "struct i2c_adapter" here, although the are 
> all named I2C_ADAP_CLASS_* and are a bit misleading now when used for in 
> the i2c driver.

The flags could be renamed if needed. There's at least one flag that we
already planed to rename (I2C_ADAP_CLASS_SMBUS, because the "SMBUS" part
is a misnomer - a more correct term would be HWMON or SENSORS).

> There are two places in i2c-core where drivers are informed of new adapters.
> 
> At both places, the flags field is checked against the newly introduced 
> flags I2C_ADAP_FLAG_CLASS_MATCH. If this flag is set and the adapter 
> class and the driver class don't match, the driver is not probed on the bus.

My initial approach was different. I wouldn't have introduced a new
flag. Instead I would have defined a "neutral" class I2C_ADAP_CLASS_ANY
0xFFFF, suitable for chips that can belong to any bus (such as
eeprom.c). This same value could be used for busses that don't care
about which chips are connected to it (i2c-parport comes to mind). No
flag needed.

Finding whether a chip and an adapter match is as easy as checking if
((chip->class & adapter->class) != 0).

> All "old" drivers don't have this flag set, so everything works just 
> like before this change.

This is where your approach looks slightly better than mine. With my
method, backward compatibility isn't provided. However, fixing existing
drivers would be rather easy, and I share Greg KH's view that drivers
living outside the kernel tree get the pain they deserve.

My main point is that if we start defining classes for both chips and
adapters and go on using them, we better consider it a policy and do it
consistently, or it will probably look confusing to newcomers.

> Now it's only possible to load these 5 i2c drivers against the MXB 
> saa7146 i2c bus -- all other i2c drivers don't get the chance to probe, 
> which is exactly what I wanted.

I guess you mean "against busses of class I2C_ADAP_CLASS_TV_ANALOG,
amongst which is the MXB saa7146 bus"? Or I just lost you.

> Todo list:
> - check if "flags" member in "struct i2c_adapter" is really unused -- 
> can any of the i2c experts commment on this?

I just tested. You can comment it out in the definition of i2c_adapter,
and everything still compiles without a complaint. I guess it means you
get a point.

> - Should the I2C_ADAP_CLASS_* be renamed to I2C_CLASS_*, so they can be 
> used by both i2c adapters and i2c drivers?

I would say yes, but I'm not the authority.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
