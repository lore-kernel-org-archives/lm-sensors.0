From: Ashish Jangam <Ashish.Jangam@kpitcummins.com>
Date: Mon, 17 Sep 2012 10:15:34 +0000
Subject: Re: [lm-sensors] [Patch v1 5/7] DA9055 HWMON driver
Message-Id: <C3AE124F08223B42BC95AEB82F0F6CED32B990BF@KCHJEXMB02.kpit.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347629518.18587.17.camel@dhruva>
In-Reply-To: <1347629518.18587.17.camel@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> -----Original Message-----
> Subject: Re: [lm-sensors] [Patch v1 5/7] DA9055 HWMON driver
> 
> On Fri, Sep 14, 2012 at 7:01 PM, Ashish Jangam
> <ashish.jangam@kpitcummins.com> wrote:
> > This is the HWMON patch for DA9055 PMIC and has got dependency on the
> > DA9055 MFD core.
> >
> > This patch monitors the DA9055 PMIC's ADC channels vddout, junction
> > temperature and auxiliary channels.
> >
> > This patch is functionally tested on Samsung SMDKV6410.
> >
> > +static ssize_t da9055_read_auto_ch(struct device *dev,
> > +                               struct device_attribute *devattr, char
> *buf)
> > +{
> > +       struct da9055_hwmon *hwmon = dev_get_drvdata(dev);
> > +       int ret, adc;
> > +       int channel = to_sensor_dev_attr(devattr)->index;
> > +
> > +       mutex_lock(&hwmon->hwmon_lock);
> > +
> > +       ret = da9055_enable_auto_mode(hwmon->da9055, channel);
> > +       if (ret < 0)
> > +               goto hwmon_err;
> > +
> > +       mdelay(10);
> can this be sleep here?
Yes, as the code is mutex protected msleep() can be used.
> > --
> > 1.7.0.4
> >
> >
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
