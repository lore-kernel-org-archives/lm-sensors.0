From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 04 Feb 2010 18:37:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: driver for TI tmp102 temperature
Message-Id: <20100204193712.22e8b6e7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201002031723.49976.sfking@fdwdc.com>
In-Reply-To: <201002031723.49976.sfking@fdwdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven King <sfking@fdwdc.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Steven,

On Wed, 3 Feb 2010 17:23:49 -0800, Steven King wrote:
> The TI TMP102 is similar to the lm75.  It differs from the lm75 by having a 16 bit conf register
> and the temp registers have a minimum resolution of 12bits; the extended conf register
> can select 13 bit resolution (which this driver does) and also change the update rate (which this
> driver currently doesn't use).
> 
> Signed-off-by: Steven King <sfking@fdwdc.com>
> ---
> 
> Driver for the TI TMP102.

Could you please send a dump of your TMP102 chip, using i2cdump in word
mode?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
