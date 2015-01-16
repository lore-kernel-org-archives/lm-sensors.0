From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 16 Jan 2015 14:52:06 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ads7828) Make sample interval configurable
Message-Id: <54B92596.2040206@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1421409922-28299-1-git-send-email-robert.rosengren@axis.com>
In-Reply-To: <1421409922-28299-1-git-send-email-robert.rosengren@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Rosengren <robert.rosengren@axis.com>, Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org, Robert Rosengren <robertr@axis.com>, Johan Adolfsson <johana@axis.com>

On 01/16/2015 04:05 AM, Robert Rosengren wrote:
> The default sample interval may be too slow for certain clients. This
> patch makes it configurable via the platform_data.
>
> Signed-off-by: Robert Rosengren <robert.rosengren@axis.com>
> Signed-off-by: Johan Adolfsson <johan.adolfsson@axis.com>

I am basically fine with the patch, though I would prefer replacing
the entire update handling and chip access with regmap. Would you be
interested in doing that ?

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
