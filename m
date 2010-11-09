From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 09 Nov 2010 18:57:13 +0000
Subject: Re: [lm-sensors] [PATCH 02/11] hwmon: applesmc: Relax the severity
Message-Id: <1289329033.22931.213.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289315711-3011-1-git-send-email-rydberg@euromail.se>
	 <1289315711-3011-3-git-send-email-rydberg@euromail.se>
In-Reply-To: <1289315711-3011-3-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@kernel.org" <stable@kernel.org>

On Tue, 2010-11-09 at 10:15 -0500, Henrik Rydberg wrote:
> The device init is used to reset the accelerometer. Failure to reset
> is not severe enough to stop loading the module or to resume from
> hibernation.  This patch relaxes failure to a warning and drops
> output in case of success.
> 
> Cc: stable@kernel.org
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Applied.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
