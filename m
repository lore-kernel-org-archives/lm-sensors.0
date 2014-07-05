From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 05 Jul 2014 17:27:58 +0000
Subject: Re: [lm-sensors] [RFT] hwmon: (lineage-pem) Convert to devm_hwmon_device_register_with_groups
Message-Id: <20140705172758.GA17446@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jul 05, 2014 at 11:22:44AM +0800, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> 
Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
