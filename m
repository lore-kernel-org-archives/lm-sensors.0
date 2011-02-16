From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 16 Feb 2011 15:09:16 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (jc42) fix type mismatch
Message-Id: <20110216150916.GA14076@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D5BCA87.7010204@ladisch.de>
 <4D5BCABD.1060106@ladisch.de>
In-Reply-To: <4D5BCABD.1060106@ladisch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <khali@linux-fr.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Wed, Feb 16, 2011 at 08:01:49AM -0500, Clemens Ladisch wrote:
> In set_temp_crit_hyst(), make the variable 'val' have the correct
> type for strict_strtoul().
> 
> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
