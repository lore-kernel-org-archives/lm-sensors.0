From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 10 Nov 2010 18:08:42 +0000
Subject: Re: [lm-sensors] [PATCH 07/11] hwmon: applesmc: Extract all
Message-Id: <20101110180842.GF18472@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289386685-9988-1-git-send-email-rydberg@euromail.se>
 <1289386685-9988-3-git-send-email-rydberg@euromail.se>
In-Reply-To: <1289386685-9988-3-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Nov 10, 2010 at 05:58:05AM -0500, Henrik Rydberg wrote:
> With temperature keys being determined automatically, the dmi match
> data is only used to assign features that can easily be detected from
> the smc. This patch removes the dmi match data altogether, and reduces
> the match table to the main machine models.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
