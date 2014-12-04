From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 04 Dec 2014 19:05:50 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (gpio-fan) Add a shutdown handler to poweroff the fans
Message-Id: <20141204190550.GB16925@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417712336-31070-1-git-send-email-nm@ti.com>
In-Reply-To: <1417712336-31070-1-git-send-email-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nishanth Menon <nm@ti.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-omap@vger.kernel.org

On Thu, Dec 04, 2014 at 10:58:56AM -0600, Nishanth Menon wrote:
> Poweroff the fans when shutting down the system. Else,
> echo '1' > /sys/class/hwmon/hwmon0/fan1_target; poweroff leaves the
> fan running if the System power off does not drive the gpio expander
> which might control the fan power supply.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---

Applied to hwmon-next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
