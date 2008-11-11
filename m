From: Kaiwan N Billimoria <kaiwan@designergraphix.com>
Date: Tue, 11 Nov 2008 06:59:22 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] hwmon: lm70: TI TMP121 support.
Message-Id: <1226386042.7044.11.camel@kaiwan-1>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022080423.GB11169@roarinelk.homelinux.net>
In-Reply-To: <20081022080423.GB11169@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey,

It's working now as expected..
will send in the patch soon,

On Wed, 2008-10-29 at 23:49 -0700, David Brownell wrote:
> On Wednesday 29 October 2008, Kaiwan N Billimoria wrote:
> > On Tue, 2008-10-28 at 03:43 -0700, David Brownell wrote:
> > > On Tuesday 28 October 2008, Kaiwan N Billimoria wrote:
> > > > Hi,
> > > > 
> > > > Got a chance to test this patch today..
> > > > short answer: no it did not seem to work.
> > > 
> > > Well, then can you see what the issue is then?
> 
> Maybe the lm70llp code shouldn't set spi->bits_per_word to 16;
> that seems to be another problem.

Yes, that's one of the issues..in fact the main one.
I keep it at zero now.

> Recall that the whole reason we noticed this bug is that the $SUBJECT
> patch was -- correctly!! -- getting its MSBs from rxbuf[0], but Jean
> noted the lm70 code was different.
Yup neat catch!

Thanks guys,
Later,
Kaiwan.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
