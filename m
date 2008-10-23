From: David Brownell <david-b@pacbell.net>
Date: Thu, 23 Oct 2008 18:37:05 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] hwmon: lm70: TI TMP121 support.
Message-Id: <200810231137.05968.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022080423.GB11169@roarinelk.homelinux.net>
In-Reply-To: <20081022080423.GB11169@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> +	switch (p_lm70->chip) {
> +	case LM70_CHIP_LM70:
> +		raw = (rxbuf[1] << 8) + rxbuf[0];
> +		val = ((int)raw/32) * 250;
> +		break;

This would seem to be masking a bug in the
drivers/spi/spi_lm70llp.c code ... observe
how lm70_txrx() interchanges bytes.  Sigh.


> +
> +	case LM70_CHIP_TMP121:
> +		raw = (rxbuf[0] << 8) + rxbuf[1];
> +		val = (raw / 8) * 625 / 10;
> +		break;

Which is correct for a 16-bit word being
encoded MSB-first in two bytes.


Arguably spi->bits_per_word should be set
to 16 and the driver should just perform
the I/O into a u16, so it only needs to
cope with the garbage LSBs.



> +	}
> 
> Does it look to you like both chips expect the same byte order? Me not.

Right, but afaik the lm70 code was only
tested with drivers/spi/spi_lm70llp.c and
that has a byte order handling bug.

Kaiwan Billimoria is the only person I
know who could test fixes to the LM70
and LM70LLP support ... Kaiwan, could
you give that a try?

- Dave



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
