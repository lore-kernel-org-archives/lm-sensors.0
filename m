From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 23 Oct 2008 17:09:49 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] hwmon: lm70: TI TMP121 support.
Message-Id: <20081023190949.5cfb980b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022080423.GB11169@roarinelk.homelinux.net>
In-Reply-To: <20081022080423.GB11169@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

Thanks for your comments.

On Thu, 23 Oct 2008 09:53:00 -0700, David Brownell wrote:
> On Thursday 23 October 2008, Manuel Lauss wrote:
> >  	/*
> > +	 * LM70:
> >  	 * The "raw" temperature read into rxbuf[] is a 16-bit signed 2's
> >  	 * complement value. Only the MSB 11 bits (1 sign + 10 temperature
> >  	 * bits) are meaningful; the LSB 5 bits are to be discarded.
> > @@ -80,8 +82,23 @@ static ssize_t lm70_sense_temp(struct device *dev,
> >  	 * by 0.25. Also multiply by 1000 to represent in millidegrees
> >  	 * Celsius.
> >  	 * So it's equivalent to multiplying by 0.25 * 1000 = 250.
> > +	 *
> > +	 * TMP121:
> > +	 * 13 bits of 2's complement data, discard LSB 3 bits.  Chip
> > +	 * transmits high byte first.  Resolution 0.0625 degrees celsius.
> 
> For SPI, everything is MSB first ... else insist (spi->mode & SPI_LSB_FIRST)
> is true.  Please strike the comment implying it might not be MSB first.

Except that the LM70 transmits the LSB first, so it seems valuable to
underline that the TMP121 behaves differently.

> >  	 */
> > -	val = ((int)raw/32) * 250;
> > +	switch (p_lm70->chip) {
> > +	case LM70_CHIP_LM70:
> > +		raw = (rxbuf[1] << 8) + rxbuf[0];
> > +		val = ((int)raw/32) * 250;
> > +		break;
> > +
> > +	case LM70_CHIP_TMP121:
> > +		raw = (rxbuf[0] << 8) + rxbuf[1];
> > +		val = (raw / 8) * 625 / 10;
> > +		break;
> > +	}
> > +	dev_dbg(dev, "raw=0x%x\n", raw);
> >  	status = sprintf(buf, "%d\n", val); /* millidegrees Celsius */
> >  out:
> >  	mutex_unlock(&p_lm70->lock);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
