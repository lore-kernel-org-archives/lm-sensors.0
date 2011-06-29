From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 29 Jun 2011 14:27:20 +0000
Subject: Re: [lm-sensors] [PATCH 6/11] HWMON: DA9052 hwmon driver v1
Message-Id: <20110629142720.GA5915@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1309271069.376.236.camel@L-0532.kpit.com>
 <1309282554.2612.7.camel@groeck-laptop>
 <1309347848.4210.14.camel@dhruva>
In-Reply-To: <1309347848.4210.14.camel@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ashish Jangam <ashish.jangam@kpitcummins.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "dchen@diasemi.com" <dchen@diasemi.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Wed, Jun 29, 2011 at 07:44:08AM -0400, Ashish Jangam wrote:
> On Tue, 2011-06-28 at 23:05 +0530, Guenter Roeck wrote:
> > On Tue, 2011-06-28 at 10:24 -0400, ashish jangam wrote:
> > > +static ssize_t da9052_read_vddout(struct device *dev,
> > > +                                  struct device_attribute *devattr, char *buf)
> > > +{
> > > +       struct da9052_hwmon *hwmon = dev_get_drvdata(dev);
> > > +       int ret, vdd = -1;
> > > +
> > > +       mutex_lock(&hwmon->hwmon_lock);
> > > +
> > > +       ret = da9052_enable_vddout_channel(hwmon->da9052);
> > > +       if (ret < 0)
> > > +               goto hwmon_err;
> > > +
> > > +       ret = da9052_reg_read(hwmon->da9052, DA9052_VDD_RES_REG);
> > > +       if (ret < 0)
> > > +               pr_err("failed to read VDD_RES_REG\n");
> > > +       else
> > > +               vdd = ret;
> > > +
> > > +       ret = da9052_disable_vddout_channel(hwmon->da9052);
> > > +       if (ret < 0)
> > > +               goto hwmon_err;
> > > +
> > > +       if (vdd >= 0) {
> > > +               mutex_unlock(&hwmon->hwmon_lock);
> > > +               return sprintf(buf, "%d\n", vdd);
> > > +       }
> > > +
> > > +hwmon_err:
> > > +       mutex_unlock(&hwmon->hwmon_lock);
> > > +       return ret;
> > > +}
> > 
> > This function still produces a bad result if the call to
> > da9052_reg_read() fails and the call to da9052_disable_vddout_channel()
> > doesn't. 
> Thanks much for comments and patience. When vddout channel is enabled
> and then read from this channel fails then, in this case should vddout
> channel get disabled? Is this correct understanding.

Hmm, yes, you are right there. You should try to disable it. But you would have 
to do that such that you don't override the original error. One possibility would
be to add an unconditional call to da9052_disable_vddout_channel() into the error 
path.

	ret = da9052_reg_read(hwmon->da9052, DA9052_VDD_RES_REG);
	if (ret < 0)
		goto hwmon_err_release;

	...
hwmon_err_release:
	da9052_disable_vddout_channel(hwmon->da9052);
hwmon_err:
	...

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
