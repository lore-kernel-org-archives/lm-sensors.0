From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 02 Jan 2011 23:31:22 +0000
Subject: Re: [lm-sensors] [PATCH] Support for DS620
Message-Id: <20110102233122.GA23859@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D0FB795.3010006@antcom.de>
In-Reply-To: <4D0FB795.3010006@antcom.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Dec 26, 2010 at 06:20:48PM -0500, Roland Stigge wrote:
> On 26/12/10 04:18, Guenter Roeck wrote:
> >> Added support for Dallas Semiconductor DS620
> >>
> >> Signed-off-by: Roland Stigge <stigge@antcom.de>
> >>
> > Queued for -next.
> 
> Thanks in advance!
> 
> Another question: I will need to write a driver for the MAX518 DAC. What
> is the appropriate place?
> 
> * hwmon (well, it is an analog _output_, not a monioring input)
> * gpio (it is an analog, not _digital_ 0/1 output)
> * misc
> 
> ?
> 
Sorry, I was out for a few days. iio (in staging) might be the best fit.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
