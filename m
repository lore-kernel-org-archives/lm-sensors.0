From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Jun 2014 13:26:00 +0000
Subject: Re: [lm-sensors] [PATCH RFT] hwmon: (gpio-fan) Convert to devm_hwmon_device_register_with_groups
Message-Id: <539C4D68.3020505@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1402728650.25269.1.camel@phoenix>
In-Reply-To: <1402728650.25269.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/13/2014 11:50 PM, Axel Lin wrote:
> This simplifies the code a bit and also ensures the attribute groups are
> properly removed from sysfs when unload the module.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Hmm ... no idea why I did not use the devm_ function to start with. Applied to -next.

On a side note, I wonder if the interrupt handler works on this one.
Shared edge triggered interrupts used to be not supported, or my memory is wrong.
If I find some time, I may build a little test board to give this a try.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
