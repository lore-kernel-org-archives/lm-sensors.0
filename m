From: Huang Rui <ray.huang@amd.com>
Date: Mon, 31 Aug 2015 01:11:53 +0000
Subject: Re: [lm-sensors] [15/15] MAINTAINERS: change the maintainer of fam15h_power driver
Message-Id: <20150831011153.GA13066@hr-slim.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-16-git-send-email-ray.huang@amd.com>
 <20150829163354.GA22327@roeck-us.net>
In-Reply-To: <20150829163354.GA22327@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Borislav Petkov <bp@alien8.de>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Fengguang Wu <fengguang.wu@intel.com>

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

OK.

N: Andreas Herrmann
E: herrmann.der.user@gmail.com
E: herrmann.der.user@googlemail.com
D: Key developer of x86/AMD64
D: Author of AMD family 15h processor power monintoring driver
D: Maintainer of AMD Athlon 64 and Opteron processor frequency driver
S: Germany

Andreas, Boris, how about above description at CREDITS? Please let me
know if I something is wrong or missed.
BTW, could you give your snail-mail address? I just know Germany :)

Thanks,
Rui

> Andreas, can you Ack this change ?
> 
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
