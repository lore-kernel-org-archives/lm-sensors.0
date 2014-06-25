From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 25 Jun 2014 14:29:43 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (emc1403) Fix missing 'select REGMAP_I2C' in Kconfig
Message-Id: <53AADCD7.1010908@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140625142121.GA14873@dashie>
In-Reply-To: <20140625142121.GA14873@dashie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Josef Gajdusek <atx@atx.name>, lm-sensors@lm-sensors.org
Cc: jdelvare@suse.de, linux-kernel@vger.kernel.org

On 06/25/2014 07:21 AM, Josef Gajdusek wrote:
> In commit 4cab259f, the emc1403 driver was converted to use regmap but the
> necessary Kconfig option was not added.
>
> Signed-off-by: Josef Gajdusek <atx@atx.name>

Applied.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
