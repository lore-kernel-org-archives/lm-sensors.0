From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Wed, 28 Sep 2011 13:36:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Document Atom E660
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109ED10F2A3@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110928143042.7ddd0c0a@endymion.delvare>
In-Reply-To: <20110928143042.7ddd0c0a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Wednesday, September 28, 2011 6:48 PM
> To: R, Durgadoss
> Cc: LM Sensors; Yu, Fenghua; Alexander Stein
> Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Document Atom E660 support
> 
> Hi Durga,
> 
> On Wed, 28 Sep 2011 18:36:50 +0530, R, Durgadoss wrote:
> > I have the CPU model of the next generation Atom based Core.
> > Can we add this also in the list here ?
> > If you don't find time, I can add the one liner, after this gets in.
> >
> > )
> > > +                              0x1a (Nehalem), 0x1c (Atom), 0x1e
> (Lynnfield),
> > > +                              0x26 (Tunnel Creek Atom)
> >
> > 0x27 (Medfield Atom) and TjMax 90
> 
> I can add it, no problem. Is TjMax the same for all Medfield-based Atom
> CPUs? If so, and if it can't be read from MSR_TEMPERATURE_TARGET, then
> this value shouldn't go in the documentation file but in the driver,
> unless the fragile heuristic we have already comes to that conclusion
> (it's so complex that honestly I can't tell.)

Thanks Jean.
Yes. It's the same for all Medfield based Atom products.
And it cannot be read from MSR_TEMPERATURE_TARGET.
So, we have to add the model name in the driver.
Currently I have added a OR inside the 'if' in adjust_tjmax Function.

if (c->x86_model = 0x1c || c->x86_model = 0x27) {

This fetches me 90 and I have confirmed it with the Hardware folks here.

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
