From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 11 Dec 2011 16:42:51 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Add missing section
Message-Id: <20111211174251.3b950982@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111211141740.4edc53f0@endymion.delvare>
In-Reply-To: <20111211141740.4edc53f0@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 11 Dec 2011 08:09:25 -0800, Guenter Roeck wrote:
> On Sun, Dec 11, 2011 at 08:17:40AM -0500, Jean Delvare wrote:
> > Many functions in the coretemp driver lack a proper section
> > annotation. Add them to let the kernel free the memory after
> > initialization when possible.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Durgadoss R <durgadoss.r@intel.com>
> > Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> > Cc: Fenghua Yu <fenghua.yu@intel.com>
> 
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Thanks.

> Want me to take that one for the next rc ?

I'm taking it but not for next rc, rather for next merge window -
nothing critical here especially when everybody has HOTPLUG_CPU set
anyway.

Unless you already have patches touching coretemp in your stack?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
