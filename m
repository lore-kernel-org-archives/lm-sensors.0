From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 02 Jul 2014 19:30:13 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (lm93) Convert to devm_hwmon_device_register_with_groups
Message-Id: <20140702193013.GA6609@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404304610.15238.5.camel@phoenix>
In-Reply-To: <1404304610.15238.5.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jul 02, 2014 at 08:36:50PM +0800, Axel Lin wrote:
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
