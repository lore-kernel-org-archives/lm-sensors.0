From: Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 09 May 2013 17:38:36 +0000
Subject: Re: [lm-sensors] [PATCH 0/3] pm: Introduce __pm to mark power management code
Message-Id: <Pine.LNX.4.44L0.1305091337050.1796-100000@iolanthe.rowland.org>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1368119366-8716-1-git-send-email-linux@roeck-us.net>
References: <1368119366-8716-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1368119366-8716-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jingoo Han <jg1.han@samsung.com>

On Thu, 9 May 2013, Guenter Roeck wrote:

> The following patch series introduces a marker for power management functions
> and data. This this marker, #ifdef CONFIG_PM and #ifdef CONFIG_PM_SLEEP
> can be removed from most of the code. This ensures that the conditional code
> still compiles but is not included in the object file.
> 
> As a side effect, drivers declaring struct dev_pm_ops unconditionally
> get a bit smaller if CONFIG_PM_SLEEP is not configured.

What about code that depends on CONFIG_PM_RUNTIME?  Or code that 
depends on CONFIG_PM_SLEEP but not on CONFIG_PM_RUNTIME?

Alan Stern



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
