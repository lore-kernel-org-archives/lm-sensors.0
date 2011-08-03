From: Alexander Stein <alexander.stein@systec-electronic.com>
Date: Wed, 03 Aug 2011 14:40:30 +0000
Subject: Re: [lm-sensors] coretemp: Support for Intel Atom E6XX CPU
Message-Id: <201108031640.31196.alexander.stein@systec-electronic.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201106271220.51953.alexander.stein@systec-electronic.com> <201108031458.01805.alexander.stein@systec-electronic.com> <D6D887BA8C9DFF48B5233887EF04654109E88956B7@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF04654109E88956B7@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "guenter.roeck@ericsson.com" <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

On Wednesday 03 August 2011 15:26:53 R, Durgadoss wrote:
> Yes I checked with some Atom Guys here.
> Apparently there is no way to know it from the OS Level.
> 
> > On Monday 27 June 2011 18:54:44 R, Durgadoss wrote:
> > > > Unfortunately, looking at Alexander's /proc/cpuinfo output, it looks
> > > > like the E6xx chips have no mention of E6xx in the CPU ID string,
> > > > which unfortunately kills the idea.
> > > > 
> > > > Do you know if there is _any_ means to distinguish E6xx from E6xxT ?
> > > 
> > > Sorry I do not know. But I can ask some folks here and get back
> > > to you guys. Should not take more time, once I identify the right
> > > person to ask :-)

So, is there a possibility to add a module parameter to force a either 
specific tjmax or the T model for E6xx?

Regards,
Alexander

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
