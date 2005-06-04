From: ebs@ebshome.net (Eugene Surovegin)
Date: Sat, 04 Jun 2005 07:59:29 +0000
Subject: [lm-sensors] Re: [PATCH 1/2] Add support for Maxim/Dallas DS1374
Message-Id: <20050603214653.GA15314@gate.ebshome.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <42A0CD46.60300@mvista.com>
In-Reply-To: <42A0CD46.60300@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Vinson <rvinson@mvista.com>
Cc: Greg KH <greg@kroah.com>, sensors@stimpy.netroedge.com, linuxppc-embedded@ozlabs.org

On Fri, Jun 03, 2005 at 02:36:06PM -0700, Randy Vinson wrote:
> Greetings,
>  I've put together a small I2C client for the Maxim/Dallas DS1374 RTC
> chip and tested it on a Freescale MPC8349ADS board that uses the chip.
> The attached patch adds support for the chip itself and a follow-up patch
> will add support to the Freescale board.

[snip]

> +	down(&ds1374_mutex);
> +
> +	/*
> +	 * Since the reads are being performed one byte at a time using
> +	 * the SMBus vs a 4-byte i2c transfer, there is a chance that a
> +	 * carry will occur during the read. To detect this, 2 reads are
> +	 * performed and compared.
> +	 */
> +	do {
> +		t1 = ds1374_read_rtc();
> +		t2 = ds1374_read_rtc();
> +	} while (t1 != t2 && limit--);

I wonder, why you chose to use those 1-byte SMBus transfers instead of 
i2c transfer.

I wrote similar DS1374 driver some time ago which used those transfers 
and they worked just fine.

-- 
Eugene


