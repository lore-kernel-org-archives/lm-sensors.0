From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 03 Oct 2012 23:37:30 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/2] hwmon: (ads7828) driver cleanup
Message-Id: <20121003233730.GB21410@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1349297648-19843-1-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1349297648-19843-1-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, Steve Hardy <shardy@redhat.com>

On Wed, Oct 03, 2012 at 04:54:07PM -0400, Vivien Didelot wrote:
> As there is no reliable way to identify the chip, it is preferable to
> remove the detect callback, to avoid misdetection.
> 
> Module parameters are not worth it here, so let's get rid of them and
> add an ads7828_platform_data structure instead.
> 
> Clean the code by removing unused macros, fixing coding style issues,
> avoiding function prototypes and using convenient macros such as
> module_i2c_driver().
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
