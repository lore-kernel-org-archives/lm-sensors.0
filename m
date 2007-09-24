From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 24 Sep 2007 18:18:41 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-rc6] lm75 should handle I/O errors
Message-Id: <20070924201841.1d7dbcec@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070918165107.7C0D2239772@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070918165107.7C0D2239772@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Tue, 18 Sep 2007 09:51:07 -0700, David Brownell wrote:
> When talking to a TMP75 chip with a flakey I2C adapter (it easily gets
> underrun errors on loaded systems), I happened to notice that the LM75
> driver holds the delusion that I/O calls can never fail.

Almost all I2C chip drivers do...

> This patch corrects that by retrying a few times after errors, and then
> by refusing to record error codes as register values.  The retries seem
> to resolve the problem under light system loads.  Clearly they won't be
> able to resolve it in all cases, so the second mechanism is also needed.

The patch looks correct and could be applied, however... While I agree
that the error handling mechanism belongs to the lm75 driver, the retry
mechanism doesn't. Duplicating this retry mechanism in all chip drivers
doesn't look good. Don't you think it would be better implemented at
i2c adapter level, or even better at i2c core level?

We have i2c_adapter.retries for that already, however it seems that the
code to handle retries is missing in most bus drivers. Only
i2c-algo-bit, i2c-algo-pcf, i2c-pxa and i2c-s3c2410 appear to implement
it, and not even the same way: the former two only retry if the address
byte is not acked, while the latter two retry on any failure.

What about moving the retry mechanism to i2c-core (in i2c_smbus_xfer
and i2c_transfer)?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
