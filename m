From: David Brownell <david-b@pacbell.net>
Date: Thu, 30 Oct 2008 06:49:00 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] hwmon: lm70: TI TMP121 support.
Message-Id: <200810292349.01526.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022080423.GB11169@roarinelk.homelinux.net>
In-Reply-To: <20081022080423.GB11169@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wednesday 29 October 2008, Kaiwan N Billimoria wrote:
> On Tue, 2008-10-28 at 03:43 -0700, David Brownell wrote:
> > On Tuesday 28 October 2008, Kaiwan N Billimoria wrote:
> > > Hi,
> > > 
> > > Got a chance to test this patch today..
> > > short answer: no it did not seem to work.
> > 
> > Well, then can you see what the issue is then?

Maybe the lm70llp code shouldn't set spi->bits_per_word to 16;
that seems to be another problem.


> > The current mainline code is clearly buggy...
> > 
> 
> A quick qs: (perhaps i'm missing something obvious/silly here);
> rxbuf[1] is the MSB part of the rxbuf buffer right.

No.  Since the sensor sends an 11-bit number (sign then 10 data bits)
in MSB format, when the lm70llp (parport adapter) returns two bytes
it will return first rxbuf[0] with the 8 MSBs, then rxbuf[1] with
three data bits and five irrelevant bits.  (Although code at that
level has been known to goof up and shift a bit in the wrong direction,
for example because it's sampling the wrong edge...)

rxbuf[0] holds the MSBs ... rxbuf[1] holds the LSBs.

Recall that the whole reason we noticed this bug is that the $SUBJECT
patch was -- correctly!! -- getting its MSBs from rxbuf[0], but Jean
noted the lm70 code was different.


> So the code is moving in the bits from there first into the variable
> raw, then adding in the LSB part of rxbuf. Why is that wrong?

See above.  If spi->bits_per_word were 16 AND you were hard-wiring
the lm70.c code to work only on little-endian hardware, THEN it would
be right to "know" that rxbuf[1] has the MSBs. 

But it's not OK to hard-wire drivers to work only on little endian
systems, which is why I suspect the missing part of the fix is to
strike the lm70llp line setting bits_per_word to nonzero.


> > I think there must be bugs covering up for each other...
> > 
> > 
> > > I can (re)confirm though that for the LM70 chip the temperature
> > register
> > > is sent MSB first...
> > 
> > Right, which is why the lm70.c code should use the
> > 
> > > -     raw = (rxbuf[1] << 8) + rxbuf[0];
> > > +     raw = (rxbuf[0] << 8) + rxbuf[1];
> > 
> > So the question is then what *else* is going on (buggy)
> > that the previous code seemed to work despite that bug...
> > 
> > - Dave
> 
> Okay, though am unable to work on this right now.
> It's in my queue & i'll get back when i have a chance...
> 
> Later,
> Kaiwan.
> 
> 
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
