From: Ashish Jangam <ashish.jangam@kpitcummins.com>
Date: Wed, 29 Jun 2011 11:56:08 +0000
Subject: Re: [lm-sensors] [PATCH 6/11] HWMON: DA9052 hwmon driver v1
Message-Id: <1309347848.4210.14.camel@dhruva>
List-Id: <lm-sensors.vger.kernel.org>
References: <1309271069.376.236.camel@L-0532.kpit.com>
	 <1309282554.2612.7.camel@groeck-laptop>
In-Reply-To: <1309282554.2612.7.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "guenter.roeck@ericsson.com" <guenter.roeck@ericsson.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "dchen@diasemi.com" <dchen@diasemi.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Tue, 2011-06-28 at 23:05 +0530, Guenter Roeck wrote:
> On Tue, 2011-06-28 at 10:24 -0400, ashish jangam wrote:
> > +static ssize_t da9052_read_vddout(struct device *dev,
> > +                                  struct device_attribute *devattr, char *buf)
> > +{
> > +       struct da9052_hwmon *hwmon = dev_get_drvdata(dev);
> > +       int ret, vdd = -1;
> > +
> > +       mutex_lock(&hwmon->hwmon_lock);
> > +
> > +       ret = da9052_enable_vddout_channel(hwmon->da9052);
> > +       if (ret < 0)
> > +               goto hwmon_err;
> > +
> > +       ret = da9052_reg_read(hwmon->da9052, DA9052_VDD_RES_REG);
> > +       if (ret < 0)
> > +               pr_err("failed to read VDD_RES_REG\n");
> > +       else
> > +               vdd = ret;
> > +
> > +       ret = da9052_disable_vddout_channel(hwmon->da9052);
> > +       if (ret < 0)
> > +               goto hwmon_err;
> > +
> > +       if (vdd >= 0) {
> > +               mutex_unlock(&hwmon->hwmon_lock);
> > +               return sprintf(buf, "%d\n", vdd);
> > +       }
> > +
> > +hwmon_err:
> > +       mutex_unlock(&hwmon->hwmon_lock);
> > +       return ret;
> > +}
> 
> This function still produces a bad result if the call to
> da9052_reg_read() fails and the call to da9052_disable_vddout_channel()
> doesn't. 
Thanks much for comments and patience. When vddout channel is enabled
and then read from this channel fails then, in this case should vddout
channel get disabled? Is this correct understanding.
> 
> I would suggest to replace pr_err() with "goto hwmon_err". If you do
> that, you don't need to initialize vdd, you don't need the else case for
> its assignment, and you don't need "if (vdd >= 0)" either.
Will take care of this. Thanks...Ashish
> 
> Guenter
> 
> 
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
