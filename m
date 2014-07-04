From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 04 Jul 2014 18:31:02 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (smm665) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53B6F2E6.90501@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404303992.15238.1.camel@phoenix>
In-Reply-To: <1404303992.15238.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/02/2014 05:26 AM, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

This is a tricky one. I can not test it (no more board access since I
changed employers), its i2c interface is too complex to work with
i2c-stub, and the chips are no longer available as far as I can see.
Summit was acquired by Qualcomm in 2012, and Summit's power
sequencers/controllers seem to have disappeared from the market.

So I am not sure what to do with this one. I guess I'll apply it,
and see if there is any fallout.

Rob, can you check if someone at E// has some chips left ? The SMM665
was used on some of the older boards. I could use that to build a test
board.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
