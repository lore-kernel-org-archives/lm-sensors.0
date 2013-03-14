From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 16:00:30 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] hwmon: (lm75) Tune resolution and sample time per chip
Message-Id: <20130314160030.GA2734@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130312155108.054dd75e@endymion.delvare>
In-Reply-To: <20130312155108.054dd75e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 14, 2013 at 04:22:05PM +0100, Jean Delvare wrote:
> On Thu, 14 Mar 2013 08:16:28 -0700, Guenter Roeck wrote:
> > On Thu, Mar 14, 2013 at 08:28:57AM +0100, Jean Delvare wrote:
> > > And if this ultimately lets us remove support for some chips from the
> > > w83627ehf driver and make it look sane again, I'm all for it.
> > 
> > Makes sense. This also makes one of the patches I submitted for w83627ehf
> > unnecessary, as it affects nct6775/nct6776 support.
> 
> Not necessarily an issue, having both drivers overlap for a period of
> time is desirable for smooth transition.
> 
Agreed. More a matter of time needed for the code review. I'll let you decide.

Dropping nct6775/nct6776 from the w83627ehf driver will reduce its size
by more than 500 LOC, and its size by more than 7k (49k -> 41.5k) on x86_64.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
