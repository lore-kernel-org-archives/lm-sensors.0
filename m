From: zeisberg@informatik.uni-freiburg.de (Uwe Zeisberger)
Date: Tue, 21 Mar 2006 10:38:39 +0000
Subject: [lm-sensors] BUG: Re:  [PATCH] I2C: add new rx8025 driver
Message-Id: <20060321103839.GA6327@informatik.uni-freiburg.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I just found a bug in that driver:

> ...
> +	if (result[0] | RX8025_BIT_CTRL1_1224)
> +		dt->tm_hour = BCD2BIN(result[2 + RX8025_REG_HOUR] & 0x3f);
> +	else
> +		dt->tm_hour = BCD2BIN(result[2 + RX8025_REG_HOUR] & 0x1f) % 12
> +			+ (result[2 + RX8025_REG_HOUR] & 0x20 ? 12 : 0);
> ...
That "|" has to be an "&", else the test is quite useless.

just in case someone wants to use this driver before I'm able to submit
an updated version...

Best regards
Uwe Zeisberger

-- 
Uwe Zeisberger

$ dc -e "5735816763073014741799356604682P"

