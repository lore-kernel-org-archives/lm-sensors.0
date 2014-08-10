From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 10 Aug 2014 14:56:30 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (tmp103) Remove duplicate test for I2C_FUNC_SMBUS_BYTE_DATA function
Message-Id: <53E7881E.40907@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1407663721.6912.9.camel@phoenix>
In-Reply-To: <1407663721.6912.9.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/10/2014 02:42 AM, Axel Lin wrote:
> Since commit b42261078a91 ("regmap: i2c: fallback to SMBus if the adapter
> does not support standard I2C"), regmap-i2c will check the
> I2C_FUNC_SMBUS_[BYTE|WORD]_DATA functionality based on the regmap_config
> setting if the adapter does not support standard I2C.
>
> So remove the I2C_FUNC_SMBUS_BYTE_DATA functionality check in the driver code.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
