From: Kaiwan N Billimoria <kaiwan@designergraphix.com>
Date: Wed, 12 Nov 2008 07:49:24 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] hwmon: lm70: TI TMP121 support.
Message-Id: <1226475444.18411.26.camel@kaiwan-1>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022080423.GB11169@roarinelk.homelinux.net>
In-Reply-To: <20081022080423.GB11169@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've just sent in the patch (as a separate email). Pl take a look..

On Wed, 2008-10-29 at 23:49 -0700, David Brownell wrote:

> Maybe the lm70llp code shouldn't set spi->bits_per_word to 16;
> that seems to be another problem.
Well, kind of pecuiliar behaviour here..

When i set bits_per_word to 0, the chip does not sense temperature
correctly, returning wrong values.

When set to 8, it works just fine.

However: 
drivers/spi/spi_bitbang.c:spi_bitbang_setup
--snip--
      if (!spi->bits_per_word)
                 spi->bits_per_word = 8;
--snip--


- Kaiwan.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
