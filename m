From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 09 May 2013 19:15:00 +0000
Subject: Re: [lm-sensors] [PATCH 0/3] pm: Introduce __pm to mark power management code
Message-Id: <1728768.gTkBc2iT1V@vostro.rjw.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <1368119366-8716-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1368119366-8716-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jingoo Han <jg1.han@samsung.com>

On Thursday, May 09, 2013 10:09:23 AM Guenter Roeck wrote:
> The following patch series introduces a marker for power management functions
> and data. This this marker, #ifdef CONFIG_PM and #ifdef CONFIG_PM_SLEEP
> can be removed from most of the code. This ensures that the conditional code
> still compiles but is not included in the object file.
> 
> As a side effect, drivers declaring struct dev_pm_ops unconditionally
> get a bit smaller if CONFIG_PM_SLEEP is not configured.
> 
> The first patch in the series introduces the marker, the following
> two patches introduce the marker in two drivers to demonstrate its use.
> 
> The patch series depends on the "PM: Add pm_ops_ptr() macro" patch
> submitted by Jingoo Han.

What about CCing a PM core maintainer?

Please see my reply to Alan Stern for my opinion.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
