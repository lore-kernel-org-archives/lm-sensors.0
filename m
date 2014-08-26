From: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>
Date: Tue, 26 Aug 2014 17:57:56 +0000
Subject: Re: [lm-sensors] hwmon_device_register compatibility with lm-sensors
Message-Id: <BF3270C86E8B1349A26C34E4EC1C44CB2C9389CB@CMEXMB1.ad.emulex.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BF3270C86E8B1349A26C34E4EC1C44CB2C9388EE@CMEXMB1.ad.emulex.com>
In-Reply-To: <BF3270C86E8B1349A26C34E4EC1C44CB2C9388EE@CMEXMB1.ad.emulex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> -----Original Message-----
> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter
> Roeck
> Sent: Tuesday, August 26, 2014 10:20 PM
> To: Venkat Duvvuru
> Cc: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] hwmon_device_register compatibility with lm-
> sensors
> 
> On Tue, Aug 26, 2014 at 03:02:48PM +0000, Venkat Duvvuru wrote:
> > Hi,
> > I'm using "hwmon_device_register_with_groups" to register with hwmon
> to show be2net's on-die temperature. I'm successful in doing it and the node
> is also visible at "/sys/class/hwmon/hwmon1/temp1_input" and lm-sensors
> (sensors command) also shows the temperature.
> >
> > However I'm not sure if a kernel doesn't support "_groups" version of the
> api, how do I register with hwmon so that it is compatible with lm-sensors.
> >
> > For example, in kernels where "_groups" is not supported. I'm doing the
> following to register with hwmon
> >
> > 1.       sysfs_create_group
> >
> > 2.       hwmon_device_register
> > The above calls are creating "temp1_input" node at
> "/sys/class/hwmon/hwmon1/device/temp1_input" and sensors command is
> not showing the temperature.
> >
> > Please let me know if I'm missing anything.
> >
> With the old API, the attributes are attached to the parent device,
> not to the hwmon device. That was one of the reasons for introducing
> the new API. The sensors command should find both, unless you are missing
> the 'name' attribute when using the old API. The new API creates this
> attribute automatically, but the old API doesn't.

Guenter,
Thanks for the reply.

This is what I'm doing on old kernels which doesn't have "_groups" API.

static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
                          be_hwmon_show_temp, NULL, 1);

static struct attribute *be_hwmon_attrs[] = {
        &sensor_dev_attr_temp1_input.dev_attr.attr,
        NULL
};

static const struct attribute_group be_hwmon_group = {
        .attrs = be_hwmon_attrs,
};

sysfs_create_group(&dev->kobj, & be_hwmon_group);

hwmon_device_register(dev);

And I do see that "temp1_input" is created under /sys/class/hwmon/hwmon1/device" directory. But sensors command is not able to find it. Lm-sensors version 3.3.5.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
