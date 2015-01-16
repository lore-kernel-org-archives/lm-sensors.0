From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 16 Jan 2015 20:30:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ads7828) Make sample interval configurable
Message-Id: <20150116203005.GA6524@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1421409922-28299-1-git-send-email-robert.rosengren@axis.com>
In-Reply-To: <1421409922-28299-1-git-send-email-robert.rosengren@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Rosengren <robert.rosengren@axis.com>
Cc: Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Robert Rosengren <robertr@axis.com>, Johan Adolfsson <johana@axis.com>

On Fri, Jan 16, 2015 at 01:05:22PM +0100, Robert Rosengren wrote:
> The default sample interval may be too slow for certain clients. This
> patch makes it configurable via the platform_data.
> 
> Signed-off-by: Robert Rosengren <robert.rosengren@axis.com>
> Signed-off-by: Johan Adolfsson <johan.adolfsson@axis.com>

Robert,

can you send me the output of i2cdump for this chip ? I would like
to write a module test for the driver.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
