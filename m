From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 10 Nov 2010 18:05:55 +0000
Subject: Re: [lm-sensors] [PATCH 04/11] hwmon: applesmc: Introduce a
Message-Id: <20101110180555.GC18472@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289386685-9988-1-git-send-email-rydberg@euromail.se>
In-Reply-To: <1289386685-9988-1-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Nov 10, 2010 at 05:58:03AM -0500, Henrik Rydberg wrote:
> One main problem with the current driver is the inability to quickly
> search for supported keys, resulting in detailed feature maps per
> machine model which are cumbersome to maintain.
> 
> This patch adds a register lookup table, which enables binary search
> for supported keys. The lookup also reduces the io frequency, so the
> original mutex is replaced by locks around the actual io.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
