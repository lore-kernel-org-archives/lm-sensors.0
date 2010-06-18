From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 18 Jun 2010 20:56:53 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: Driver for SMM665 Six-Channel
Message-Id: <1276894613.2631.535.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1276877194-28214-1-git-send-email-guenter.roeck@ericsson.com>
	 <1276877194-28214-2-git-send-email-guenter.roeck@ericsson.com>
	 <4C1BB2AC.4090308@jic23.retrosnub.co.uk>
In-Reply-To: <4C1BB2AC.4090308@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <kernel@jic23.retrosnub.co.uk>
Cc: Jean Delvare <khali@linux-fr.org>, Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Andrew Morton <akpm@linux-foundation.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

[...]
> > +             /*
> > +              * Algorithm for reading ADC, per SMM665 datasheet
> > +              *
> > +              *  {[S][addr][W][Ack]} {[offset][Ack]} {[S][addr][R][Nack]}
> > +              * [wait 70 uS]
> > +              *  {[S][addr][R][Ack]} {[datahi][Ack]} {[datalo][Ack][P]}
> > +              *
> > +              * To implement the first part of this exchange,
> > +              * do a full read transaction and expect a failure/Nack.
> > +              * This sets up the address pointer on the SMM665
> > +              * and starts the ADC conversion.
> > +              * Then do a two-byte read transaction.
> > +              */
> Is there no better way of handling this? There are protocol mangling hacks
> to tell the i2c core to ignore a NAKs under some circumstances.
> 
> > +             rv = i2c_smbus_read_byte_data(client, adc << 3);
> > +             if (rv >= 0) {
> > +                     /* No error, something is wrong. Retry. */
> > +                     rv = -1;
> > +                     continue;
> > +             }

I looked through the core i2c code, but did not find anything I can
use. 

Problem is that per smm665 specification, the first NACK is expected. So
we do not just want to ignore this NACK, we want to actively check if
the command "failed" as expected, and report an error if it did _not_
fail.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
