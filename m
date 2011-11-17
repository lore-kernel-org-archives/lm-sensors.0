From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 17 Nov 2011 09:50:17 +0000
Subject: Re: [lm-sensors] [PATCH v7] hwmon: Add driver for EXYNOS4 TMU
Message-Id: <20111117095017.GA22540@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1315388948-20346-1-git-send-email-dg77.kim@samsung.com>
 <1321389279.20271.241.camel@x61.thuisdomein>
 <1321392253.2309.379.camel@groeck-laptop>
 <4EC4999F.8030604@samsung.com>
In-Reply-To: <4EC4999F.8030604@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Donggeun Kim <dg77.kim@samsung.com>
Cc: Paul Bolle <pebolle@tiscali.nl>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Nov 17, 2011 at 12:20:31AM -0500, Donggeun Kim wrote:
[ ... ]
> >>>  
> >>> +config SENSORS_EXYNOS4_TMU
> >>> +	tristate "Temperature sensor on Samsung EXYNOS4"
> >>> +	depends on EXYNOS4_DEV_TMU
> >>
> >> It doesn't look like that Kconfig symbol is part of the tree just yet.
> >> That means people will not be able to build this driver from the
> >> mainline tree. Why is this dependency needed? In a (rather quick) scan
> >> of the code of this driver I couldn't spot anything not yet available in
> >> the tree.
> >>
> > I have to defer to the driver author for that. Maybe the dependency was
> > renamed at some point, or removed altogether.
> > 
> The dependency will be renamed to 'ARCH_EXYNOS4'.
> 
Please submit a patch.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
