From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 07 Jun 2012 13:38:36 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (applesmc) Limit key length in warning messages
Message-Id: <20120607133836.GC26008@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339059269-383-1-git-send-email-rydberg@euromail.se>
In-Reply-To: <1339059269-383-1-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Jun 07, 2012 at 04:54:29AM -0400, Henrik Rydberg wrote:
> Key lookups may call read_smc() with a fixed-length key string,
> and if the lookup fails, trailing stack content may appear in the
> kernel log. Fixed with this patch.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
