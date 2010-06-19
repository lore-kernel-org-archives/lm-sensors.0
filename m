From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 19 Jun 2010 14:36:56 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: Driver for SMM665 Six-Channel
Message-Id: <20100619143656.GA2038@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1276877194-28214-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1276877194-28214-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jun 19, 2010 at 04:23:12AM -0400, Jean Delvare wrote:
> On Fri, 18 Jun 2010 13:56:53 -0700, Guenter Roeck wrote:
> > [...]
> > > > +             /*
> > > > +              * Algorithm for reading ADC, per SMM665 datasheet
> > > > +              *
> > > > +              *  {[S][addr][W][Ack]} {[offset][Ack]} {[S][addr][R][Nack]}
> > > > +              * [wait 70 uS]
> > > > +              *  {[S][addr][R][Ack]} {[datahi][Ack]} {[datalo][Ack][P]}
> > > > +              *
> > > > +              * To implement the first part of this exchange,
> > > > +              * do a full read transaction and expect a failure/Nack.
> > > > +              * This sets up the address pointer on the SMM665
> > > > +              * and starts the ADC conversion.
> > > > +              * Then do a two-byte read transaction.
> > > > +              */
> > > Is there no better way of handling this? There are protocol mangling hacks
> > > to tell the i2c core to ignore a NAKs under some circumstances.
> 
> This is only available on raw I2C messages, not on the higher-level
> i2c_smbus_*() API. And not all bus drivers support it. And that's not
> what is needed here anyway: ignoring the nack means we would continue
> reading from the chip, while it really doesn't want to talk to us at
> that time.
> 
> > > > +             rv = i2c_smbus_read_byte_data(client, adc << 3);
> > > > +             if (rv >= 0) {
> 
> You should check for -ENXIO explicitly. According to
> Documentation/i2c/fault-codes, this is the value bus drivers should
> return on missing Ack.
> 
Ok, I'll do that. I'll submit a separate patch for the sibyte
i2c bus driver since it returns -1 - which is wrong anyway.

> > > > +                     /* No error, something is wrong. Retry. */
> > > > +                     rv = -1;
> > > > +                     continue;
> > > > +             }
> > 
> > I looked through the core i2c code, but did not find anything I can
> > use. 
> > 
> > Problem is that per smm665 specification, the first NACK is expected. So
> > we do not just want to ignore this NACK, we want to actively check if
> > the command "failed" as expected, and report an error if it did _not_
> > fail.
> 
> Do you really have to trigger the Nack for the ADC conversion to start?
> Can't you just use i2c_smbus_read_byte() (no _data) for the first part
> of the transaction?
> 
Unfortunately, yes. It is the only command that works.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
