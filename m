From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Mon, 27 Jun 2011 16:52:44 +0000
Subject: Re: [lm-sensors] coretemp: Support for Intel Atom E6XX
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109E84A62C0@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201106271220.51953.alexander.stein@systec-electronic.com>
	<20110627164108.777c2e28@endymion.delvare>
 <1309191054.8271.636.camel@groeck-laptop>
In-Reply-To: <1309191054.8271.636.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "guenter.roeck@ericsson.com" <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>

Hi Guenter,

> I thought about replacing the manual TjMax detection code with code
> using the model string to take care of problems like this - essentially
> by providing a table with entries { model string, Tjmax } for each CPU
> with Tjmax other than 100 degrees C. This way we could get rid of some
> of the odd code we have today. Would that make sense ?

I completely agree with you here.
This way, a lot of code in get_tjmax will be reduced, by just
a search through some array.
 
Thanks,
Durga


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
