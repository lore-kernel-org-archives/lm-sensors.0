From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 09 Jul 2012 14:07:48 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (applesmc) Shorten minimum wait time
Message-Id: <20120709140748.GA12691@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1341828626-6543-1-git-send-email-rydberg@euromail.se>
In-Reply-To: <1341828626-6543-1-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Mon, Jul 09, 2012 at 12:10:26PM +0200, Henrik Rydberg wrote:
> The 2012 series of MacBooks have a faster SMC, and the current driver
> timings do not work at all. Tests show that decreasing the minimum
> wait time, from 64 us to 16 us, works well. Since this is still larger
> than the original minimum of 10 us used before 2008, there is nothing
> inherently problematic with changing it. The fail frequency on older
> machines seems to increase slightly, but not enough to be noticeable.
> 
> Tested on MBA11, MBA31, MBA5,2, MBP9,2.
> 
> The patch was originally written by adamski99 (ubuntuforums.org) and
> later tested by janhouse (bbs.archlinux.org).
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> Hi Guenter,
> 
> This patch enables the mid-2012 MacBook models. The patch affects
> older models slightly, but mostly in a good way; all models get
> slightly faster reads, but some older models see a slight increase in
> read fail frequency. I do not think this will be noticeable, but I
> would hesitate to backport too far. For 3.6.
> 
Queued for 3.6.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
