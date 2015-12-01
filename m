From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 01 Dec 2015 21:06:24 +0000
Subject: Re: [lm-sensors] [PATCH V2] hwmon: (tmp102) Force wait for conversion time for the first valid data
Message-Id: <20151201210624.GA9177@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1448943955-2385-1-git-send-email-nm@ti.com>
 <1448986221-6190-1-git-send-email-nm@ti.com>
In-Reply-To: <1448986221-6190-1-git-send-email-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nishanth Menon <nm@ti.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-omap@vger.kernel.org, beagleboard-x15@googlegroups.com, Eduardo Valentin <edubezval@gmail.com>

On Tue, Dec 01, 2015 at 10:10:21AM -0600, Nishanth Menon wrote:
> TMP102 works based on conversions done periodically. However, as per
> the TMP102 data sheet[1] the first conversion is triggered immediately
> after we program the configuration register. The temperature data
> registers do not reflect proper data until the first conversion is
> complete (in our case HZ/4).
> 
> The driver currently sets the last_update to be jiffies - HZ, just
> after the configuration is complete. When TMP102 driver registers
> with the thermal framework, it immediately tries to read the sensor
> temperature data. This takes place even before the conversion on the
> TMP102 is complete and results in an invalid temperature read.
> 
> Depending on the value read, this may cause thermal framework to
> assume that a critical temperature event has occurred and attempts to
> shutdown the system.
> 
> Instead of causing an invalid mid-conversion value to be read
> erroneously, we mark the last_update to be in-line with the current
> jiffies. This allows the tmp102_update_device function to skip update
> until the required conversion time is complete. Further, we ensure to
> return -EAGAIN result instead of returning spurious temperature (such
> as 0C) values to the caller to prevent any wrong decisions made with
> such values. NOTE: this allows the read functions not to be blocking
> and allows the callers to make the decision if they would like to
> block or try again later. At least the current user(thermal) seems to
> handle this by retrying later.
> 
> A simpler alternative approach could be to sleep in the probe for the
> duration required, but that will result in latency that is undesirable
> and delay boot sequence un-necessarily.
> 
> [1] http://www.ti.com/lit/ds/symlink/tmp102.pdf
> 
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Reported-by: Aparna Balasubramanian <aparnab@ti.com>
> Reported-by: Elvita Lobo <elvita@ti.com>
> Reported-by: Yan Liu <yan-liu@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
