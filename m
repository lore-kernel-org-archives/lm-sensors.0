From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Fri, 02 Mar 2012 16:54:36 +0000
Subject: Re: [lm-sensors] [PATCH 02/03] HWMON: HWMON driver for DA9052/53 PMIC v3
Message-Id: <4D68720C2E767A4AA6A8796D42C8EB59046B13@BGSMSX101.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1330698545.21817.31.camel@dhruva>
	 <4D68720C2E767A4AA6A8796D42C8EB59046AE9@BGSMSX101.gar.corp.intel.com>
 <1330707053.23014.279.camel@groeck-laptop>
In-Reply-To: <1330707053.23014.279.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "guenter.roeck@ericsson.com" <guenter.roeck@ericsson.com>
Cc: Ashish Jangam <ashish.jangam@kpitcummins.com>, "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "dchen@diasemi.com" <dchen@diasemi.com>

Hi Guenter,

> -----Original Message-----
> From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
> Sent: Friday, March 02, 2012 10:21 PM
> To: R, Durgadoss
> Cc: Ashish Jangam; randy.dunlap@oracle.com; linaro-dev@lists.linaro.org;
> sameo@linux.intel.com; linux-kernel@vger.kernel.org; lm-sensors@lm-sensors.org;
> dchen@diasemi.com
> Subject: RE: [lm-sensors] [PATCH 02/03] HWMON: HWMON driver for DA9052/53 PMIC
> v3
> 
> Hi Durga,
> 
> On Fri, 2012-03-02 at 11:44 -0500, R, Durgadoss wrote:
> > Hi,
> >
 
[snip..]

> > > +     sysfs_remove_group(&pdev->dev.kobj, &da9052_attr_group);
> > > +err_mem:
> >
> > I think you should do a kfree(hwmon) here.
> >
> 
> Not needed because devm_kzalloc() is used above.

Ok. Nice to know. Thank you :-)

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
