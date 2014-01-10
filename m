From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 10 Jan 2014 16:22:26 +0000
Subject: Re: [lm-sensors] [PATCH-next] drivers/hwmon: remove new __cpuinit usage from coretemp.c
Message-Id: <20140110162226.GA8582@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1389366623-26552-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1389366623-26552-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Fri, Jan 10, 2014 at 10:10:23AM -0500, Paul Gortmaker wrote:
> Commit da9e8c7a7b99b245c464ff45c7bde38a4b510019 ("hwmon: (coretemp)
> Use PCI host bridge ID to identify CPU if necessary") added a new
> instance of the __cpuinit macro usage.
> 
> We removed this a couple versions ago; we now want to remove
> the compat no-op stubs.  Introducing new users is not what
> we want to see at this point in time, as it will break once
> the stubs are gone.
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> 
> [Patch based on today's linux-next tree, so if hwmon next content
>  gets rebased, then the above commit ID will be invalidated; if it
>  _does_ get rebased, then feel free to squash this fix into the orig.]
> 
Hi Paul,

thanks a lot for the fix. I rebased hwmon-next and removed __cpuinitconst from
the original commit, so the problem should be gone in the next iteration of
linux-next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
