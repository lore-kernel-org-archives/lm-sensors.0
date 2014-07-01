From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 01 Jul 2014 20:56:11 +0000
Subject: Re: [lm-sensors] [RFT][PATCH 2/2] hwmon: (amc6821) Convert to devm_hwmon_device_register_with_groups
Message-Id: <20140701205611.GB13520@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jun 29, 2014 at 10:33:34AM +0800, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied to -next.

Module testing finds a bug (unrelated to this patch): temp2_input
should not be writable. Feel free to submit a patch if you have time ...

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
