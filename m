From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 31 Jul 2013 22:12:34 +0000
Subject: Re: [lm-sensors] [PATCH 20/35] hwmon: use dev_get_platdata()
Message-Id: <20130731221234.GA29618@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <004f01ce8cfc$9f232190$dd6964b0$@samsung.com>
In-Reply-To: <004f01ce8cfc$9f232190$dd6964b0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jul 30, 2013 at 05:13:06PM +0900, Jingoo Han wrote:
> Use the wrapper function for retrieving the platform data instead of
> accessing dev->platform_data directly.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
