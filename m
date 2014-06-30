From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 30 Jun 2014 19:16:08 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (hih6130) Convert to devm_hwmon_device_register_with_groups
Message-Id: <20140630191608.GA27555@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404024354.10911.1.camel@phoenix>
In-Reply-To: <1404024354.10911.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jun 30, 2014 at 05:19:34PM +0100, Iain Paton wrote:
> On 29/06/14 07:45, Axel Lin wrote:
> > Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> > simplify the code a bit.
> > 
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> 
> Tested-by: Iain Paton <ipaton0@gmail.com>
> 
Applied to hwmon-next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
