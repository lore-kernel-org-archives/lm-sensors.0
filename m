From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Tue, 15 Aug 2006 03:14:09 +0000
Subject: [lm-sensors] [RFC PATCH 2.6.18-rc4-mm1] hwmon: unchecked return
Message-Id: <20060815031409.GA2666@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060814020407.GA3327@jupiter.solarsys.private>
In-Reply-To: <20060814020407.GA3327@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David:

* David Hubbard <david.c.hubbard at gmail.com> [2006-08-14 17:09:47 -0700]:
> Hi Mark, Jean,
> 
> Jean, I have a request to make of the I2C mailing list. See below...
> 
> On 8/14/06, Jean Delvare <khali at linux-fr.org> wrote:
> >Hi Mark,
> >
> >> Added w83627hf, which should demonstrate how to do all the remaining
> >> hwmon drivers.  There is more (ab)use of sysfs_remove_group() here to
> >> make life easier.
> >
> >Yeah, I like it. Your approach deals nicely with chip-dependent files
> >and it can be applied to all drivers as far as I can see.
> 
> The w83627ehf driver uses struct sensor_device_attribute instead of
> struct device_attribute, and we've put them in arrays, so if I created

The only reason to put them in arrays in the first place was to make
registration easier.  For w83627ehf, I would do this...

-static struct sensor_device_attribute sda_in_input[] = {
-	SENSOR_ATTR(in0_input, S_IRUGO, show_in, NULL, 0),
-	SENSOR_ATTR(in1_input, S_IRUGO, show_in, NULL, 1),
-	SENSOR_ATTR(in2_input, S_IRUGO, show_in, NULL, 2),
-	SENSOR_ATTR(in3_input, S_IRUGO, show_in, NULL, 3),
-	SENSOR_ATTR(in4_input, S_IRUGO, show_in, NULL, 4),
-	SENSOR_ATTR(in5_input, S_IRUGO, show_in, NULL, 5),
-	SENSOR_ATTR(in6_input, S_IRUGO, show_in, NULL, 6),
-	SENSOR_ATTR(in7_input, S_IRUGO, show_in, NULL, 7),
-	SENSOR_ATTR(in8_input, S_IRUGO, show_in, NULL, 8),
-	SENSOR_ATTR(in9_input, S_IRUGO, show_in, NULL, 9),
-};
+static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_in, NULL, 0);
+static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_in, NULL, 1);
+static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_in, NULL, 2);
+static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_in, NULL, 3);
+static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, show_in, NULL, 4);
+static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, show_in, NULL, 5);
+static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, show_in, NULL, 6);
+static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, show_in, NULL, 7);
+static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, show_in, NULL, 8);
+static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, show_in, NULL, 9);
 
> a struct attribute *w83627ehf_attributes, it would contain something
> like &sda_sf3_arrays[0].device_attr, &sda_sf3_arrays[1].device_attr,

Given the above, it would be &dev_attr_in0_input.dev_attr.attr.

> I think that would be ugly code. It would allow me to call
> sysfs_create_group() just like Mark does, which I would do if I could
> find a way. Is there a sysfs_create_* function that takes
> sensor_device_attribute arrays instead? If I read correctly, no. :-(

Of course we could create one and put it into the hwmon module.  Not sure
if I like that idea though.  It won't save any code, and I don't think it
would save any time either.

> @Jean:
> 
> I added some return value checks in w83627ehf_detect(). This is called
> from i2c_isa_add_driver using driver->attach_adapter(&isa_adapter). So
> I returned an error from w83627ehf_detect(), and was surprised to see
> that the module silently succeeded, without fully creating the
> w83627ehf sysfs interface. I looked deeper and found that
> i2c_isa_add_driver() does not check the return value when calling its
> driver->attach_adapter(). i2c_isa_add_driver() is called from
> sensors_w83627ehf_init(), which is the module_init function.
> 
> I have attached a very short patch for drivers/i2c/busses/i2c-isa.c
> which should fix the problem. Instead of returning 0, it returns the
> result of driver->attach_adapter(). However, this may cause a great
> deal of unexpected grief, considering how many drivers use this
> function. So now I can either subscribe to the I2C mailing list for
> this (I'd rather not), or I can hand you the patch and ask you to talk
> to the I2C developers (easy for me, but...).

I2C developers = mostly Jean, increasingly me too.  Anyway, i2c-isa is
not used by anyone except hwmon, so it's just as well to discuss it here.

Jean: I thought you already had such a patch in your queue?  Now I can't
seem to find it.

> Which should it be? If you can pass it on to the I2C developers, I'll
> continue with the w83627ehf driver and to check for errors from
> device_create_file().

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


