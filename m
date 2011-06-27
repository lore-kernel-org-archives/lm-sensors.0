From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 27 Jun 2011 16:50:05 +0000
Subject: Re: [lm-sensors] coretemp: Support for Intel Atom E6XX CPU
Message-Id: <1309193405.8271.645.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <201106271220.51953.alexander.stein@systec-electronic.com>
	 <20110627164108.777c2e28@endymion.delvare>
	 <1309191054.8271.636.camel@groeck-laptop>
	 <D6D887BA8C9DFF48B5233887EF04654109E84A62C0@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF04654109E84A62C0@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: Jean Delvare <khali@linux-fr.org>, "Yu, Fenghua" <fenghua.yu@intel.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>

On Mon, 2011-06-27 at 12:40 -0400, R, Durgadoss wrote:
> Hi Guenter,
> 
> > I thought about replacing the manual TjMax detection code with code
> > using the model string to take care of problems like this - essentially
> > by providing a table with entries { model string, Tjmax } for each CPU
> > with Tjmax other than 100 degrees C. This way we could get rid of some
> > of the odd code we have today. Would that make sense ?
> 
> I completely agree with you here.
> This way, a lot of code in get_tjmax will be reduced, by just
> a search through some array.
>  
Unfortunately, looking at Alexander's /proc/cpuinfo output, it looks
like the E6xx chips have no mention of E6xx in the CPU ID string, which
unfortunately kills the idea. 

Do you know if there is _any_ means to distinguish E6xx from E6xxT ?

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
