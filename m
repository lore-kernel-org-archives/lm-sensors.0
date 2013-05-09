From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 09 May 2013 17:48:22 +0000
Subject: Re: [lm-sensors] [PATCH 0/3] pm: Introduce __pm to mark power management code
Message-Id: <20130509174822.GA30549@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1368119366-8716-1-git-send-email-linux@roeck-us.net>
 <Pine.LNX.4.44L0.1305091337050.1796-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1305091337050.1796-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jingoo Han <jg1.han@samsung.com>

On Thu, May 09, 2013 at 01:38:36PM -0400, Alan Stern wrote:
> On Thu, 9 May 2013, Guenter Roeck wrote:
> 
> > The following patch series introduces a marker for power management functions
> > and data. This this marker, #ifdef CONFIG_PM and #ifdef CONFIG_PM_SLEEP
> > can be removed from most of the code. This ensures that the conditional code
> > still compiles but is not included in the object file.
> > 
> > As a side effect, drivers declaring struct dev_pm_ops unconditionally
> > get a bit smaller if CONFIG_PM_SLEEP is not configured.
> 
> What about code that depends on CONFIG_PM_RUNTIME?  Or code that 
> depends on CONFIG_PM_SLEEP but not on CONFIG_PM_RUNTIME?
> 
Should we also introduce __pm_sleep and __pm_runtime ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
