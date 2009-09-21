From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 21 Sep 2009 21:44:23 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for Texas Instruments
Message-Id: <20090921144423.6ebf564f.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090905_120834_010267.tomaz.mertelj@guest.arnes.si>
	<20090908170649.855dd1ff.akpm@linux-foundation.org>
	<20090909093435.60531d95@hyperion.delvare>
In-Reply-To: <20090909093435.60531d95@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: tomaz.mertelj@guest.arnes.si, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Wed, 9 Sep 2009 09:34:35 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> > #define set_temp_para(name, reg)\
> > static ssize_t set_##name(\
> > 		struct device *dev,\
> > 		struct device_attribute *attr,\
> > 		const char *buf,\
> > 		size_t count)\
> > {\
> > 	return set_helper(dev, attr, buf, count, &dev->name);\
> > }
> > 
> > And then do all the real work in a common function?  Rather than
> > expanding tens of copies of the same thing?
> 
> Yes please. We got rid of macro-generated callbacks in most hwmon
> drivers a couple years ago already.

I never received an update to this patch so I'm retaining it in my tree
for now.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
