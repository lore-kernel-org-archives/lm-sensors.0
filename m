From: Andreas Herrmann <herrmann.der.user@googlemail.com>
Date: Mon, 31 Aug 2015 15:19:39 +0000
Subject: Re: [lm-sensors] [15/15] MAINTAINERS: change the maintainer of fam15h_power driver
Message-Id: <20150831151939.GA24428@alberich>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-16-git-send-email-ray.huang@amd.com>
 <20150829163354.GA22327@roeck-us.net>
In-Reply-To: <20150829163354.GA22327@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Huang Rui <ray.huang@amd.com>, Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?utf-8?B?RnLDqWTDqXJpYw==?= Weisbecker <fweisbec@gmail.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>, x86@kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Borislav Petkov <bp@alien8.de>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Fengguang Wu <fengguang.wu@intel.com>

On Sat, Aug 29, 2015 at 09:33:54AM -0700, Guenter Roeck wrote:
> On Thu, Aug 27, 2015 at 04:07:46PM +0800, Huang Rui wrote:
> > Andreas Herrmann won't take the maintainer of fam15h_power driver. I
> > will take it and appreciate him for the great contributions on this
> > driver.
> > 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
> 
> Please add Andreas to CREDITS.
> 
> Andreas, can you Ack this change ?

Acked-by: Andreas Herrmann <herrmann.der.user@googlemail.com>

Thanks,
Andreas

> Thanks,
> Guenter
> 
> > ---
> >  MAINTAINERS | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 941d7b7..241d45e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -601,9 +601,9 @@ F:	drivers/crypto/ccp/
> >  F:	include/linux/ccp.h
> >  
> >  AMD FAM15H PROCESSOR POWER MONITORING DRIVER
> > -M:	Andreas Herrmann <herrmann.der.user@googlemail.com>
> > +M:	Huang Rui <ray.huang@amd.com>
> >  L:	lm-sensors@lm-sensors.org
> > -S:	Maintained
> > +S:	Supported
> >  F:	Documentation/hwmon/fam15h_power
> >  F:	drivers/hwmon/fam15h_power.c
> >  

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
