From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 01 Jul 2014 20:30:03 +0000
Subject: Re: [lm-sensors] [RFT][PATCH 2/2] hwmon: (adm1029) Convert to devm_hwmon_device_register_with_groups
Message-Id: <20140701203003.GB2708@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jun 29, 2014 at 09:42:17AM +0800, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied to -next.

Turns out the driver has a minor bug, seen in module testing:
Writing to fanX_div does not clear the cache. As a result, reading
from fanX_div may return the old value for up to two seconds
after writing a new value. That is unrelated, of course.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
