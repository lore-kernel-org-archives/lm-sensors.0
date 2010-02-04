From: Steven King <sfking@fdwdc.com>
Date: Thu, 04 Feb 2010 21:17:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: driver for TI tmp102 temperature
Message-Id: <201002041317.37574.sfking@fdwdc.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201002031723.49976.sfking@fdwdc.com> <20100204102203.ecf4bbb5.akpm@linux-foundation.org>
In-Reply-To: <20100204102203.ecf4bbb5.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Thursday 04 February 2010 10:22:03 Andrew Morton wrote:
> On Wed, 3 Feb 2010 17:23:49 -0800
>
> Steven King <sfking@fdwdc.com> wrote:
> > The TI TMP102 is similar to the lm75.  It differs from the lm75 by having
> > a 16 bit conf register and the temp registers have a minimum resolution
> > of 12bits; the extended conf register can select 13 bit resolution (which
> > this driver does) and also change the update rate (which this driver
> > currently doesn't use).
>
> A neat little driver.

Thanks.

> checkpatch spits this warning:
>
>     WARNING: struct dev_pm_ops should normally be const
>     #387: FILE: drivers/hwmon/tmp102.c:300:
>     +static struct dev_pm_ops tmp102_dev_pm_ops = {
>
> which seems truthful enough.

Indeed.   I am, however, somewhat surprised since I ran the patch thru 
checkpatch before posting it and no errors or warnings were reported.  Is 
there a version of checkpatch other than the one included in the tree that I 
should be using?

>
> And doing this will hurt readers' brains less:
>
>
>
> Use conventional array-walk loop.

Ah yes, an idiosyncrasy of mine in preferring do while over for loops 
especially when I 'know' the initial test will pass.  Whatever is the 
preferred idiom for the kernel is fine with me.

-- 
Steven King -- sfking at fdwdc dot com

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
