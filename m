From: Kaiwan N Billimoria <kaiwan@designergraphix.com>
Date: Thu, 30 Oct 2008 06:44:50 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] hwmon: lm70: TI TMP121 support.
Message-Id: <1225348370.6120.21.camel@kaiwan-1>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022080423.GB11169@roarinelk.homelinux.net>
In-Reply-To: <20081022080423.GB11169@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2008-10-28 at 03:43 -0700, David Brownell wrote:
> On Tuesday 28 October 2008, Kaiwan N Billimoria wrote:
> > Hi,
> > 
> > Got a chance to test this patch today..
> > short answer: no it did not seem to work.
> 
> Well, then can you see what the issue is then?
> The current mainline code is clearly buggy...
> 

A quick qs: (perhaps i'm missing something obvious/silly here);
rxbuf[1] is the MSB part of the rxbuf buffer right.
So the code is moving in the bits from there first into the variable
raw, then adding in the LSB part of rxbuf. Why is that wrong?

> I think there must be bugs covering up for each other...
> 
> 
> > I can (re)confirm though that for the LM70 chip the temperature
> register
> > is sent MSB first...
> 
> Right, which is why the lm70.c code should use the
> 
> > -     raw = (rxbuf[1] << 8) + rxbuf[0];
> > +     raw = (rxbuf[0] << 8) + rxbuf[1];
> 
> So the question is then what *else* is going on (buggy)
> that the previous code seemed to work despite that bug...
> 
> - Dave

Okay, though am unable to work on this right now.
It's in my queue & i'll get back when i have a chance...

Later,
Kaiwan.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
