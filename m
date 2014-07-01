From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 01 Jul 2014 21:23:52 +0000
Subject: Re: [lm-sensors] [PATCH RFT] hwmon: (htu21) Convert to devm_hwmon_device_register_with_groups
Message-Id: <20140701212352.GA3116@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jun 29, 2014 at 03:00:59PM +0800, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
