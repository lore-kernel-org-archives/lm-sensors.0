From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Sat, 18 Jul 2009 09:59:17 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add WM835x PMIC hardware	monitoring
Message-Id: <20090718095917.GA10160@opensource.wolfsonmicro.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1247862795-22547-1-git-send-email-broonie@opensource.wolfsonmicro.com> <20090718111712.78771b36@hyperion.delvare>
In-Reply-To: <20090718111712.78771b36@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@cam.ac.uk>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Sat, Jul 18, 2009 at 11:17:12AM +0200, Jean Delvare wrote:

> > +WM8350_NAMED_VOLTAGE(0, USB);
> > +WM8350_NAMED_VOLTAGE(1, BATT);
> > +WM8350_NAMED_VOLTAGE(2, LINE);

> I would suggest passing the whole WM8350_AUXADC_USB, etc. string as the
> 2nd parameter. This makes grepping the source code for users (as LXR
> does for example) possible.

The reason it's formatted like that is that the AUXADC input names match
the names of the supplies that are being monitored so the second parameter
is also used to provide a label to userspace.

> > +static struct platform_driver wm8350_hwmon_driver = {
> > +	.probe = wm8350_hwmon_probe,
> > +	.remove = __devexit_p(wm8350_hwmon_remove),
> > +	.driver = {
> > +		.name = "wm8350-hwmon",

> I think you are supposed to set .owner to THIS_MODULE?

Hrm, yeah.  I need to figure out where I cut'n'pasted this from since I
suspect the error came along with that.

> When you are done, what is your merge plan? I would be happy to take
> the patch in my unofficial hwmon tree and push it in 2.6.32, but due to
> wm8350-core dependencies, you may prefer it to be merged differently?

I'm happy to go with whatever is easiest for the people actually doing
the merging.  wm8350 is fairly static at the minute - it's much more
likely that there would be merge issues from the build infrastructure.
It might be a little easier to merge via mfd.

I'll fix the rest of your comments, thanks.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
