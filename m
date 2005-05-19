From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [PATCH: 2.6.11-rc5] i2c chips: ds1337 RTC driver
Message-Id: <20050301075413.GC3791@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42235171.80500@katalix.com>
In-Reply-To: <42235171.80500@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Chapman <jchapman@katalix.com>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 05:14:25PM +0000, James Chapman wrote:
> +/* Define to compile in pr_debug() trace */
> +#undef DEBUG

Not needed, we do this in the makefile now.

> +	if (debug >= 1)
> +		pr_debug("%s: client=%p, dt=%p\n", __FUNCTION__, client, dt);

Please use the dev_dbg(), dev_err() and friend functions instead of
pr_debug().  It provides a sane user interface that all of the other
drivers use.

thanks,

greg k-h
