From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Thu, 11 Aug 2011 19:48:51 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: Add interrupt support to
Message-Id: <20110811194851.GC5885@polaris.bitmath.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312906483-3046-3-git-send-email-mjg@redhat.com>
In-Reply-To: <1312906483-3046-3-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Aug 10, 2011 at 10:18:40AM -0700, Guenter Roeck wrote:
> On Tue, 2011-08-09 at 12:14 -0400, Matthew Garrett wrote:
> > The applesmc hardware supports providing interrupts for significant
> > accelerometer events. Add framework for this - we'll want to notify
> > userspace on these in the long run to handle head unloading, but we need
> > to figure out the best interface for that first. Code based on a patch by
> > Nicolas Boichat and the FreeBSD kernel code.
> > 
> > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> > Cc: Nicolas Boichat <nicolas@boichat.ch>
> 
> Not sure if the overall code makes sense w/o actual use of the
> interrupts, just to fill up the log. I'd like to get some feedback from
> others on this.

The notion is exciting, but I agree with Guenter, no point adding it
without usecase.

> > +	buffer[0] = 20;
> > +	ret = applesmc_write_key_check(pdev, NOTIFY_LOW_RATE, buffer, 1);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = applesmc_write_key_check(pdev, NOTIFY_HIGH_RATE, buffer, 1);
> > +	if (ret)
> > +		goto out;
> >  
> > -	pr_warn("failed to init the device\n");
> > +	buffer[0] = 0;
> > +	buffer[1] = 0x60;
> > +	ret = applesmc_write_key_check(pdev, NOTIFY_LOW_THRESH, buffer, 2);
> > +	if (ret)
> > +		goto out;
> > +
> > +	buffer[0] = 1;
> > +	buffer[1] = 0xc0;
> > +	ret = applesmc_write_key_check(pdev, NOTIFY_HIGH_THRESH, buffer, 2);
> > +	if (ret)
> > +		goto out;
> > +
> > +	buffer[0] = 0xe0;
> > +	buffer[1] = 0xf8;
> > +	ret = applesmc_write_key_check(pdev, MOTION_SENSOR_KEY, buffer, 2);

Lots of buffer setting and calls to a new function - perhaps the
function arguments should be modified?

> > +static irqreturn_t applesmc_interrupt(int irq, void *d)
> > +{
> > +	struct applesmc_dev *pdev = d;
> > +	u8 intr = applesmc_read_reg(pdev, APPLESMC_INT_PORT);
> > +
> > +	switch (intr) {
> > +	case 0x60:
> > +		printk(KERN_INFO "applesmc: Free fall interrupt\n");
> > +		break;
> > +	case 0x6f:
> > +		printk(KERN_INFO "applesmc: High acceleration interrupt\n");
> > +		break;
> > +	case 0x80:
> > +		printk(KERN_INFO "applesmc: Shock interrupt\n");
> > +		break;
> > +	default:
> > +		if (intr)
> > +			printk(KERN_INFO "applesmc: Unknown interrupt %x\n",
> > +			       intr);
> > +		break;
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +

Is the list above exhaustive?

Thanks,
Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
