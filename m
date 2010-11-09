From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 09 Nov 2010 18:57:46 +0000
Subject: Re: [lm-sensors] [PATCH 03/11] drivers/hwmon/applesmc.c: Use pr_fmt
Message-Id: <1289329066.22931.214.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289315711-3011-1-git-send-email-rydberg@euromail.se>
	 <1289315711-3011-4-git-send-email-rydberg@euromail.se>
In-Reply-To: <1289315711-3011-4-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>

On Tue, 2010-11-09 at 10:15 -0500, Henrik Rydberg wrote:
> From: Joe Perches <joe@perches.com>
> 
> Added #define pr_fmt KBUILD_MODNAME ": " fmt
> Converted printks to pr_<level>
> Coalesced any long formats
> Removed prefixes from formats
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Applied (replacing Joe's original patch).

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
