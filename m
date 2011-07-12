From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 12 Jul 2011 13:40:57 +0000
Subject: Re: [lm-sensors] [PATCH] pmbus: Use long variables for register to
Message-Id: <20110712134057.GA24690@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310411064-16337-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1310411064-16337-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jul 12, 2011 at 03:00:16AM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Mon, 11 Jul 2011 12:04:24 -0700, Guenter Roeck wrote:
> > Using integer variable types for register to data conversions can cause
> > overflows especially for power calculations, which are in microwatt.
> > Use long variables instead.
> 
> I have no objection, using longs for calculations certainly makes
> sense, however does it really help in practice? I thought that
> sizeof(int) = sizeof(long) for all architectures on Linux?
> 
No ... for x86_64 long is 64 bit and int is 32 bit. I'll may have
to switch to "long long" at some point, though, or maybe s64.
Still hesitating to do that.

> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> Either way:
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
